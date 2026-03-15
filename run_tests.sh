#!/bin/bash
# ─────────────────────────────────────────
# HYPERION TEST SUITE — v0.8
# ─────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
DIM='\033[2m'
BOLD='\033[1m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m'

PASS=0
FAIL=0
SIM_PASS=0
SIM_FAIL=0
SYN_PASS=0
SYN_FAIL=0
START_TIME=$(date +%s)

section() {
    echo ""
    echo -e "  ${CYAN}${BOLD}$1${NC}"
    echo -e "  ${DIM}$(printf '─%.0s' {1..50})${NC}"
}

run_test() {
    local NAME=$1
    local CMD=$2
    local EXPECT=$3
    printf "  %-40s" "$NAME"
    OUTPUT=$(eval "$CMD" 2>&1)
    if echo "$OUTPUT" | grep -q "$EXPECT"; then
        echo -e "${GREEN}✓ pass${NC}"
        PASS=$((PASS + 1))
        SIM_PASS=$((SIM_PASS + 1))
    else
        echo -e "${RED}✗ fail${NC}"
        echo -e "  ${DIM}  expected: $EXPECT${NC}"
        FAIL=$((FAIL + 1))
        SIM_FAIL=$((SIM_FAIL + 1))
    fi
}

run_synth() {
    local NAME=$1
    local TOP=$2
    local FILES=$3
    printf "  %-40s" "$NAME"
    OUTPUT=$(yosys -p "
read_verilog $FILES
synth -top $TOP
stat
" 2>&1)
    local CELLS=$(echo "$OUTPUT" | grep "Number of cells:" | tail -1 | awk '{print $NF}')
    if [ -n "$CELLS" ]; then
        echo -e "${GREEN}✓ pass${NC}  ${DIM}${CELLS} gates${NC}"
        PASS=$((PASS + 1))
        SYN_PASS=$((SYN_PASS + 1))
    else
        echo -e "${RED}✗ fail${NC}"
        FAIL=$((FAIL + 1))
        SYN_FAIL=$((SYN_FAIL + 1))
    fi
}

print_results() {
    END_TIME=$(date +%s)
    ELAPSED=$((END_TIME - START_TIME))
    TOTAL=$((PASS + FAIL))
    echo ""
    echo -e "  ${DIM}$(printf '═%.0s' {1..60})${NC}"
    echo ""
    if [ $FAIL -eq 0 ]; then
        echo -e "  ${GREEN}${BOLD}  ✓  All $TOTAL tests passed${NC}"
    else
        echo -e "  ${RED}${BOLD}  ✗  $FAIL of $TOTAL tests failed${NC}"
    fi
    echo ""
    if [ $((SIM_PASS + SIM_FAIL)) -gt 0 ]; then
        echo -e "  ${DIM}  Simulation   ${NC}${GREEN}$SIM_PASS passed${NC}  ${DIM}/  ${NC}${RED}$SIM_FAIL failed${NC}"
    fi
    if [ $((SYN_PASS + SYN_FAIL)) -gt 0 ]; then
        echo -e "  ${DIM}  Synthesis    ${NC}${GREEN}$SYN_PASS passed${NC}  ${DIM}/  ${NC}${RED}$SYN_FAIL failed${NC}"
    fi
    echo -e "  ${DIM}  Time         ${NC}${WHITE}${ELAPSED}s${NC}"
    echo ""
    echo -e "  ${DIM}$(printf '─%.0s' {1..60})${NC}"
    echo -e "  ${DIM}  Hyperion v0.8  ·  296,650 gates  ·  512 MACs  ·  2 layers${NC}"
    echo -e "  ${DIM}$(printf '─%.0s' {1..60})${NC}"
    echo ""
}

run_sim_tests() {
    section "Simulation tests"
    run_test "MAC unit" \
        "iverilog -o /tmp/t1 verilog/mac_unit.v simulation/mac_unit_test.v && vvp /tmp/t1" \
        "MAC unit working correctly"
    run_test "SRAM" \
        "iverilog -o /tmp/t2 verilog/sram.v simulation/sram_test.v && vvp /tmp/t2" \
        "Hyperion SRAM working"
    run_test "Controller" \
        "iverilog -o /tmp/t3 verilog/controller.v simulation/controller_test.v && vvp /tmp/t3" \
        "Hyperion controller test complete"
    run_test "Systolic array 8x8" \
        "iverilog -o /tmp/t4 verilog/mac_unit.v verilog/systolic_array_8x8.v simulation/systolic_8x8_test.v && vvp /tmp/t4" \
        "64 MAC units running in parallel"
    run_test "Systolic array 16x16" \
        "iverilog -o /tmp/t5 verilog/mac_unit.v verilog/systolic_array_16x16.v simulation/systolic_16x16_test.v && vvp /tmp/t5" \
        "256 MAC units running in parallel"
    run_test "ReLU unit" \
        "iverilog -o /tmp/t6 verilog/relu_unit.v simulation/relu_test.v && vvp /tmp/t6" \
        "Hyperion ReLU unit working"
    run_test "Bias unit" \
        "iverilog -o /tmp/t7 verilog/bias_unit.v simulation/bias_test.v && vvp /tmp/t7" \
        "Hyperion bias unit working"
    run_test "Full chip 8x8 pipeline" \
        "iverilog -o /tmp/t8 verilog/mac_unit.v verilog/sram.v verilog/systolic_array_8x8.v verilog/controller.v verilog/hyperion_top_8x8.v simulation/hyperion_8x8_test.v && vvp /tmp/t8" \
        "This is Hyperion v0.6"
    run_test "Complete neural net layer" \
        "iverilog -o /tmp/t9 verilog/mac_unit.v verilog/relu_unit.v verilog/bias_unit.v verilog/systolic_array_16x16.v verilog/hyperion_layer.v simulation/hyperion_layer_test.v && vvp /tmp/t9" \
        "Hyperion v0.7 — mathematically complete"
    run_test "2 stacked layers — Hyperion Deep" \
        "iverilog -o /tmp/t10 verilog/mac_unit.v verilog/relu_unit.v verilog/bias_unit.v verilog/systolic_array_16x16.v verilog/hyperion_layer.v verilog/hyperion_deep.v simulation/hyperion_deep_test.v && vvp /tmp/t10" \
        "Hyperion DEEP — 2 stacked layers complete"
}

run_synth_tests() {
    section "Hardware synthesis tests"
    run_synth "MAC unit" \
        "mac_unit" "verilog/mac_unit.v"
    run_synth "ReLU unit" \
        "relu_unit" "verilog/relu_unit.v"
    run_synth "Bias unit" \
        "bias_unit" "verilog/bias_unit.v"
    run_synth "Systolic array 16x16" \
        "systolic_array_16x16" \
        "verilog/mac_unit.v verilog/systolic_array_16x16.v"
    run_synth "Full chip 8x8 pipeline" \
        "hyperion_top_8x8" \
        "verilog/mac_unit.v verilog/sram.v verilog/controller.v verilog/systolic_array_8x8.v verilog/hyperion_top_8x8.v"
    run_synth "Complete neural net layer" \
        "hyperion_layer" \
        "verilog/mac_unit.v verilog/relu_unit.v verilog/bias_unit.v verilog/systolic_array_16x16.v verilog/hyperion_layer.v"
    run_synth "Hyperion Deep — 2 layers" \
        "hyperion_deep" \
        "verilog/mac_unit.v verilog/sram.v verilog/controller.v verilog/relu_unit.v verilog/bias_unit.v verilog/systolic_array_16x16.v verilog/hyperion_layer.v verilog/hyperion_deep.v"
}

# ── header ──
clear
echo ""
echo -e "${PURPLE}${BOLD}"
echo "  ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗ ██╗ ██████╗ ███╗   ██╗"
echo "  ██║  ██║╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██║██╔═══██╗████╗  ██║"
echo "  ███████║ ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║██║   ██║██╔██╗ ██║"
echo "  ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══╝  ██╔══██╗██║██║   ██║██║╚██╗██║"
echo "  ██║  ██║   ██║   ██║     ███████╗██║  ██║██║╚██████╔╝██║ ╚████║"
echo "  ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝"
echo -e "${NC}"
echo -e "  ${DIM}AI Accelerator Chip  ·  Test Suite v0.8  ·  $(date '+%Y-%m-%d %H:%M')${NC}"
echo ""
echo -e "  ${DIM}$(printf '═%.0s' {1..60})${NC}"
echo -e "  ${WHITE}${BOLD}  Modules: 12   MAC units: 512   Layers: 2   Gates: 296,650${NC}"
echo -e "  ${DIM}$(printf '═%.0s' {1..60})${NC}"

# ── deps ──
if ! command -v iverilog &> /dev/null; then
    echo -e "\n  ${YELLOW}⚠ installing iverilog...${NC}"
    sudo apt-get install -y iverilog -q
fi
if ! command -v yosys &> /dev/null; then
    echo -e "\n  ${YELLOW}⚠ installing yosys...${NC}"
    sudo apt-get install -y yosys -q
fi

# ── if argument passed, skip menu ──
if [ "$1" == "all" ]; then
    run_sim_tests
    run_synth_tests
    print_results
    exit 0
fi

if [ "$1" == "sim" ]; then
    run_sim_tests
    print_results
    exit 0
fi

if [ "$1" == "synth" ]; then
    run_synth_tests
    print_results
    exit 0
fi

# ── interactive menu ──
echo ""
echo -e "  ${WHITE}${BOLD}Select tests to run:${NC}"
echo ""
echo -e "  ${CYAN}[1]${NC}  ${WHITE}All tests${NC}             ${DIM}17 tests — simulation + synthesis${NC}"
echo -e "  ${CYAN}[2]${NC}  ${WHITE}Simulation only${NC}       ${DIM}10 tests — verify correct output${NC}"
echo -e "  ${CYAN}[3]${NC}  ${WHITE}Synthesis only${NC}        ${DIM}7 tests  — verify gate counts${NC}"
echo -e "  ${CYAN}[4]${NC}  ${WHITE}Single module${NC}         ${DIM}pick one module to test${NC}"
echo ""
echo -e "  ${DIM}$(printf '─%.0s' {1..60})${NC}"
echo ""
printf "  ${CYAN}›${NC} "
read -r CHOICE

case $CHOICE in
    1)
        run_sim_tests
        run_synth_tests
        ;;
    2)
        run_sim_tests
        ;;
    3)
        run_synth_tests
        ;;
    4)
        echo ""
        echo -e "  ${WHITE}${BOLD}Select module:${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  MAC unit"
        echo -e "  ${CYAN}[2]${NC}  SRAM"
        echo -e "  ${CYAN}[3]${NC}  Controller"
        echo -e "  ${CYAN}[4]${NC}  Systolic array 8x8"
        echo -e "  ${CYAN}[5]${NC}  Systolic array 16x16"
        echo -e "  ${CYAN}[6]${NC}  ReLU unit"
        echo -e "  ${CYAN}[7]${NC}  Bias unit"
        echo -e "  ${CYAN}[8]${NC}  Full chip 8x8 pipeline"
        echo -e "  ${CYAN}[9]${NC}  Complete neural net layer"
        echo -e "  ${CYAN}[10]${NC} Hyperion Deep — 2 layers"
        echo ""
        printf "  ${CYAN}›${NC} "
        read -r MOD
        section "Single module test"
        case $MOD in
            1)  run_test "MAC unit" \
                    "iverilog -o /tmp/t1 verilog/mac_unit.v simulation/mac_unit_test.v && vvp /tmp/t1" \
                    "MAC unit working correctly"
                run_synth "MAC unit (synth)" \
                    "mac_unit" "verilog/mac_unit.v" ;;
            2)  run_test "SRAM" \
                    "iverilog -o /tmp/t2 verilog/sram.v simulation/sram_test.v && vvp /tmp/t2" \
                    "Hyperion SRAM working" ;;
            3)  run_test "Controller" \
                    "iverilog -o /tmp/t3 verilog/controller.v simulation/controller_test.v && vvp /tmp/t3" \
                    "Hyperion controller test complete" ;;
            4)  run_test "Systolic array 8x8" \
                    "iverilog -o /tmp/t4 verilog/mac_unit.v verilog/systolic_array_8x8.v simulation/systolic_8x8_test.v && vvp /tmp/t4" \
                    "64 MAC units running in parallel"
                run_synth "Systolic array 8x8 (synth)" \
                    "systolic_array_8x8" \
                    "verilog/mac_unit.v verilog/systolic_array_8x8.v" ;;
            5)  run_test "Systolic array 16x16" \
                    "iverilog -o /tmp/t5 verilog/mac_unit.v verilog/systolic_array_16x16.v simulation/systolic_16x16_test.v && vvp /tmp/t5" \
                    "256 MAC units running in parallel"
                run_synth "Systolic array 16x16 (synth)" \
                    "systolic_array_16x16" \
                    "verilog/mac_unit.v verilog/systolic_array_16x16.v" ;;
            6)  run_test "ReLU unit" \
                    "iverilog -o /tmp/t6 verilog/relu_unit.v simulation/relu_test.v && vvp /tmp/t6" \
                    "Hyperion ReLU unit working"
                run_synth "ReLU unit (synth)" \
                    "relu_unit" "verilog/relu_unit.v" ;;
            7)  run_test "Bias unit" \
                    "iverilog -o /tmp/t7 verilog/bias_unit.v simulation/bias_test.v && vvp /tmp/t7" \
                    "Hyperion bias unit working"
                run_synth "Bias unit (synth)" \
                    "bias_unit" "verilog/bias_unit.v" ;;
            8)  run_test "Full chip 8x8 pipeline" \
                    "iverilog -o /tmp/t8 verilog/mac_unit.v verilog/sram.v verilog/systolic_array_8x8.v verilog/controller.v verilog/hyperion_top_8x8.v simulation/hyperion_8x8_test.v && vvp /tmp/t8" \
                    "This is Hyperion v0.6"
                run_synth "Full chip 8x8 (synth)" \
                    "hyperion_top_8x8" \
                    "verilog/mac_unit.v verilog/sram.v verilog/controller.v verilog/systolic_array_8x8.v verilog/hyperion_top_8x8.v" ;;
            9)  run_test "Complete neural net layer" \
                    "iverilog -o /tmp/t9 verilog/mac_unit.v verilog/relu_unit.v verilog/bias_unit.v verilog/systolic_array_16x16.v verilog/hyperion_layer.v simulation/hyperion_layer_test.v && vvp /tmp/t9" \
                    "Hyperion v0.7 — mathematically complete"
                run_synth "Neural net layer (synth)" \
                    "hyperion_layer" \
                    "verilog/mac_unit.v verilog/relu_unit.v verilog/bias_unit.v verilog/systolic_array_16x16.v verilog/hyperion_layer.v" ;;
            10) run_test "2 stacked layers — Hyperion Deep" \
                    "iverilog -o /tmp/t10 verilog/mac_unit.v verilog/relu_unit.v verilog/bias_unit.v verilog/systolic_array_16x16.v verilog/hyperion_layer.v verilog/hyperion_deep.v simulation/hyperion_deep_test.v && vvp /tmp/t10" \
                    "Hyperion DEEP — 2 stacked layers complete"
                run_synth "Hyperion Deep (synth)" \
                    "hyperion_deep" \
                    "verilog/mac_unit.v verilog/sram.v verilog/controller.v verilog/relu_unit.v verilog/bias_unit.v verilog/systolic_array_16x16.v verilog/hyperion_layer.v verilog/hyperion_deep.v" ;;
            *)  echo -e "\n  ${RED}Invalid selection${NC}" ;;
        esac
        ;;
    *)
        echo -e "\n  ${RED}Invalid selection${NC}"
        exit 1
        ;;
esac

print_results
