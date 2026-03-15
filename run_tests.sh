#!/bin/bash
# ─────────────────────────────────────────
# HYPERION MASTER TEST SUITE
# runs every module test in order
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
echo "HYPERION TEST SUITE"
echo "======================================="
echo ""

# test 1: MAC unit
run_test "MAC unit" \
    "iverilog -o /tmp/t1 verilog/mac_unit.v simulation/mac_unit_test.v && vvp /tmp/t1" \
    "MAC unit working correctly"

# test 2: Systolic array
run_test "Systolic array" \
    "iverilog -o /tmp/t2 verilog/mac_unit.v verilog/systolic_array.v simulation/systolic_test.v && vvp /tmp/t2" \
    "16 MAC units running in parallel"

# test 3: SRAM
run_test "SRAM" \
    "iverilog -o /tmp/t3 verilog/sram.v simulation/sram_test.v && vvp /tmp/t3" \
    "Hyperion SRAM working"

# test 4: Controller
run_test "Controller" \
    "iverilog -o /tmp/t4 verilog/controller.v simulation/controller_test.v && vvp /tmp/t4" \
    "Hyperion controller test complete"

# test 5: Full chip
run_test "Full chip (hyperion_top)" \
    "iverilog -o /tmp/t5 verilog/mac_unit.v verilog/sram.v verilog/systolic_array.v verilog/controller.v verilog/hyperion_top.v simulation/hyperion_top_test.v && vvp /tmp/t5" \
    "This is Hyperion"

echo ""
echo "======================================="
echo "Results: $PASS passed, $FAIL failed"
if [ $FAIL -eq 0 ]; then
    echo "All tests passed. Hyperion is working."
else
    echo "Some tests failed. Check output above."
fi
echo "======================================="
