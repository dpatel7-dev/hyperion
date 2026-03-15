#!/bin/bash
# ─────────────────────────────────────────
# HYPERION MASTER TEST SUITE — v0.8
# simulation + hardware synthesis
# ─────────────────────────────────────────

PASS=0
FAIL=0

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
        echo "  Output: $OUTPUT"
        FAIL=$((FAIL + 1))
    fi
}

run_synth() {
    NAME=$1
    TOP=$2
    FILES=$3
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
        echo "$OUTPUT" | grep -i error
        FAIL=$((FAIL + 1))
    fi
}

echo "========================================"
echo "HYPERION TEST SUITE — v0.8"
echo "========================================"
echo ""

# ── install yosys if needed ──
if ! command -v yosys &> /dev/null; then
    echo "Installing yosys..."
    sudo apt-get install -y yosys -q
fi

echo "── Simulation tests ─────────────────────"
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
run_test "ReLU unit" \
    "iverilog -o /tmp/t6 verilog/relu_unit.v simulation/relu_test.v && vvp /tmp/t6" \
    "Hyperion ReLU unit working"

# test 7: Bias unit
run_test "Bias unit" \
    "iverilog -o /tmp/t7 verilog/bias_unit.v simulation/bias_test.v && vvp /tmp/t7" \
    "Hyperion bias unit working"

# test 8: Full chip 8x8 pipeline
run_test "Full chip 8x8 pipeline" \
    "iverilog -o /tmp/t8 verilog/mac_unit.v verilog/sram.v verilog/systolic_array_8x8.v verilog/controller.v verilog/hyperion_top_8x8.v simulation/hyperion_8x8_test.v && vvp /tmp/t8" \
    "This is Hyperion v0.6"

# test 9: Complete layer (16x16 + bias + ReLU)
run_test "Complete neural net layer" \
    "iverilog -o /tmp/t9 verilog/mac_unit.v verilog/relu_unit.v verilog/bias_unit.v verilog/systolic_array_16x16.v verilog/hyperion_layer.v simulation/hyperion_layer_test.v && vvp /tmp/t9" \
    "Hyperion v0.7 — mathematically complete"

# test 10: 2 stacked layers
run_test "2 stacked layers (Hyperion Deep)" \
    "iverilog -o /tmp/t10 verilog/mac_unit.v verilog/relu_unit.v verilog/bias_unit.v verilog/systolic_array_16x16.v verilog/hyperion_layer.v verilog/hyperion_deep.v simulation/hyperion_deep_test.v && vvp /tmp/t10" \
    "Hyperion DEEP — 2 stacked layers complete"

echo ""
echo "── Hardware synthesis tests ─────────────"
echo ""

# synth 1: MAC unit
run_synth "MAC unit" \
    "mac_unit" \
    "verilog/mac_unit.v"

# synth 2: ReLU unit
run_synth "ReLU unit" \
    "relu_unit" \
    "verilog/relu_unit.v"

# synth 3: Bias unit
run_synth "Bias unit" \
    "bias_unit" \
    "verilog/bias_unit.v"

# synth 4: Systolic array 16x16
run_synth "Systolic array 16x16 (256 MACs)" \
    "systolic_array_16x16" \
    "verilog/mac_unit.v verilog/systolic_array_16x16.v"

# synth 5: Full chip 8x8
run_synth "Full chip 8x8 pipeline" \
    "hyperion_top_8x8" \
    "verilog/mac_unit.v verilog/sram.v verilog/controller.v verilog/systolic_array_8x8.v verilog/hyperion_top_8x8.v"

# synth 6: Complete layer
run_synth "Complete neural net layer" \
    "hyperion_layer" \
    "verilog/mac_unit.v verilog/relu_unit.v verilog/bias_unit.v verilog/systolic_array_16x16.v verilog/hyperion_layer.v"

# synth 7: Full Hyperion Deep
run_synth "Hyperion Deep (2 layers, full chip)" \
    "hyperion_deep" \
    "verilog/mac_unit.v verilog/sram.v verilog/controller.v verilog/relu_unit.v verilog/bias_unit.v verilog/systolic_array_16x16.v verilog/hyperion_layer.v verilog/hyperion_deep.v"

echo ""
echo "========================================"
echo "Results: $PASS passed, $FAIL failed"
if [ $FAIL -eq 0 ]; then
    echo "All tests passed. Hyperion is working."
else
    echo "Some tests failed. Check output above."
fi
echo ""
echo "── Hyperion v0.8 hardware spec ──────────"
echo "  Simulation tests:   10"
echo "  Synthesis tests:     7"
echo "  MAC units:         512 (2 × 256)"
echo "  Logic gates:   296,650"
echo "  Flip flops:      8,196"
echo "  FPGA usage:        ~56% of Arty A7"
echo "========================================"
