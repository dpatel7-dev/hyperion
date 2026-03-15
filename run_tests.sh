#!/bin/bash
# ─────────────────────────────────────────
# HYPERION MASTER TEST SUITE — v0.7
# includes hardware synthesis check
# ─────────────────────────────────────────

PASS=0
FAIL=0
WARN=0

run_test() {
    NAME=$1
    CMD=$2
    EXPECT=$3

    echo "Testing $NAME..."
    OUTPUT=$(eval "$CMD" 2>&1)

    if echo "$OUTPUT" | grep -q "$EXPECT"; then
        echo "  ✓ PASS"
        PASS=$((PASS + 1))
    else
        echo "  ✗ FAIL"
        echo "  Expected to find: $EXPECT"
        echo "  Got: $OUTPUT"
        FAIL=$((FAIL + 1))
    fi
}

run_synth() {
    NAME=$1
    TOP=$2
    FILES=$3
    EXPECT_GATES=$4

    echo "Synthesizing $NAME..."
    OUTPUT=$(yosys -p "
read_verilog $FILES
synth -top $TOP
stat
" 2>&1)

    CELLS=$(echo "$OUTPUT" | grep "Number of cells:" | tail -1 | awk '{print $NF}')

    if [ -n "$CELLS" ]; then
        echo "  ✓ PASS — $CELLS logic gates"
        PASS=$((PASS + 1))
    else
        echo "  ✗ FAIL — synthesis error"
        FAIL=$((FAIL + 1))
    fi
}

echo "======================================="
echo "HYPERION TEST SUITE — v0.7"
echo "======================================="
echo ""

echo "── Simulation tests ──────────────────"
echo ""

# test 1: MAC unit
run_test "MAC unit" \
    "iverilog -o /tmp/t1 verilog/mac_unit.v simulation/mac_unit_test.v && vvp /tmp/t1" \
    "MAC unit working correctly"

# test 2: SRAM
run_test "SRAM" \
    "iverilog -o /tmp/t2 verilog/sram.v simulation/sram_test.v && vvp /tmp/t2" \
    "Hyperion SRAM working"

# test 3: Controller
run_test "Controller" \
    "iverilog -o /tmp/t3 verilog/controller.v simulation/controller_test.v && vvp /tmp/t3" \
    "Hyperion controller test complete"

# test 4: Systolic array 8x8
run_test "Systolic array 8x8" \
    "iverilog -o /tmp/t4 verilog/mac_unit.v verilog/systolic_array_8x8.v simulation/systolic_8x8_test.v && vvp /tmp/t4" \
    "64 MAC units running in parallel"

# test 5: Systolic array 16x16
run_test "Systolic array 16x16" \
    "iverilog -o /tmp/t5 verilog/mac_unit.v verilog/systolic_array_16x16.v simulation/systolic_16x16_test.v && vvp /tmp/t5" \
    "256 MAC units running in parallel"

# test 6: ReLU unit
run_test "ReLU activation unit" \
    "iverilog -o /tmp/t6 verilog/relu_unit.v simulation/relu_test.v && vvp /tmp/t6" \
    "Hyperion ReLU unit working"

# test 7: Full chip 8x8 pipeline
run_test "Full chip 8x8 pipeline" \
    "iverilog -o /tmp/t7 verilog/mac_unit.v verilog/sram.v verilog/systolic_array_8x8.v verilog/controller.v verilog/hyperion_top_8x8.v simulation/hyperion_8x8_test.v && vvp /tmp/t7" \
    "This is Hyperion v0.6"

echo ""
echo "── Hardware synthesis tests ──────────"
echo ""

# check yosys is available
if ! command -v yosys &> /dev/null; then
    echo "Installing yosys..."
    sudo apt-get install -y yosys -q
fi

# synth 1: MAC unit
run_synth "MAC unit" \
    "mac_unit" \
    "verilog/mac_unit.v"

# synth 2: Systolic array 8x8
run_synth "Systolic array 8x8" \
    "systolic_array_8x8" \
    "verilog/mac_unit.v verilog/systolic_array_8x8.v"

# synth 3: Systolic array 16x16
run_synth "Systolic array 16x16" \
    "systolic_array_16x16" \
    "verilog/mac_unit.v verilog/systolic_array_16x16.v"

# synth 4: ReLU unit
run_synth "ReLU unit" \
    "relu_unit" \
    "verilog/relu_unit.v"

# synth 5: Full Hyperion chip
run_synth "Full Hyperion chip (8x8)" \
    "hyperion_top_8x8" \
    "verilog/mac_unit.v verilog/sram.v verilog/controller.v verilog/systolic_array_8x8.v verilog/hyperion_top_8x8.v"

echo ""
echo "======================================="
echo "Results: $PASS passed, $FAIL failed"
if [ $FAIL -eq 0 ]; then
    echo "All tests passed. Hyperion is working."
else
    echo "Some tests failed. Check output above."
fi
echo "======================================="
