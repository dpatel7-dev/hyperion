#!/bin/bash
# ─────────────────────────────────────────
# HYPERION MASTER TEST SUITE — v0.6
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
        echo "  Got: $OUTPUT"
        FAIL=$((FAIL + 1))
    fi
}

echo "======================================="
echo "HYPERION TEST SUITE — v0.6"
echo "======================================="
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

# test 5: Full chip 4x4 pipeline
run_test "Full chip 4x4 pipeline" \
    "iverilog -o /tmp/t5 verilog/mac_unit.v verilog/sram.v verilog/systolic_array.v verilog/controller.v verilog/hyperion_top.v simulation/hyperion_top_test.v && vvp /tmp/t5" \
    "This is Hyperion"

# test 6: Full chip 8x8 pipeline
run_test "Full chip 8x8 pipeline" \
    "iverilog -o /tmp/t6 verilog/mac_unit.v verilog/sram.v verilog/systolic_array_8x8.v verilog/controller.v verilog/hyperion_top_8x8.v simulation/hyperion_8x8_test.v && vvp /tmp/t6" \
    "This is Hyperion v0.6"

echo ""
echo "======================================="
echo "Results: $PASS passed, $FAIL failed"
if [ $FAIL -eq 0 ]; then
    echo "All tests passed. Hyperion is working."
else
    echo "Some tests failed. Check output above."
fi
echo "======================================="
