# Hyperion Architecture — v0.6

## Overview

Hyperion is built around three core components connected by
a central controller. The design follows the same architectural
pattern used in Google's TPU and Nvidia's H100 — just at a
smaller scale.

As of v0.6, Hyperion runs a verified 8×8 systolic array with
64 MAC units operating in parallel through a fully autonomous
pipeline.

## Components

### MAC Unit (mac_unit.v)
The atomic building block. Takes two 8-bit inputs, multiplies
them, and accumulates the result into a 16-bit register on
every clock edge.
```
a (8-bit) ──►┐
             ├── multiply ──► accumulate ──► out (16-bit)
b (8-bit) ──►┘
```

### Systolic Array — 4×4 (systolic_array.v)
16 MAC units arranged in a 4×4 grid. Built first as a
foundation for the 8×8 design.
```
     b0   b1   b2   b3
a0 [MAC][MAC][MAC][MAC]
a1 [MAC][MAC][MAC][MAC]
a2 [MAC][MAC][MAC][MAC]
a3 [MAC][MAC][MAC][MAC]
```

### Systolic Array — 8×8 (systolic_array_8x8.v) ← current
64 MAC units arranged in an 8×8 grid. Each row shares the
same input, each column shares the same weight. All 64
multiply-accumulate operations happen simultaneously in
one clock cycle.
```
     b0   b1   b2   b3   b4   b5   b6   b7
a0 [MAC][MAC][MAC][MAC][MAC][MAC][MAC][MAC]
a1 [MAC][MAC][MAC][MAC][MAC][MAC][MAC][MAC]
a2 [MAC][MAC][MAC][MAC][MAC][MAC][MAC][MAC]
a3 [MAC][MAC][MAC][MAC][MAC][MAC][MAC][MAC]
a4 [MAC][MAC][MAC][MAC][MAC][MAC][MAC][MAC]
a5 [MAC][MAC][MAC][MAC][MAC][MAC][MAC][MAC]
a6 [MAC][MAC][MAC][MAC][MAC][MAC][MAC][MAC]
a7 [MAC][MAC][MAC][MAC][MAC][MAC][MAC][MAC]
```

A real TPU has a 128×128 systolic array — 16,384 MAC units.
Hyperion v0.6 has 64. Same architecture, different scale.

### SRAM (sram.v)
64 locations of 8-bit on-chip storage. Holds the neural
network weights close to the compute units so they don't
need to be fetched from slow external memory every cycle.

Write mode: data_in is stored at address on rising clock edge.
Read mode:  data_out reflects value at address one cycle later.

### Controller (controller.v)
A finite state machine with 5 states:
```
IDLE ──► LOAD ──► COMPUTE ──► OUTPUT ──► DONE ──► IDLE
```

| State   | Duration    | What happens                       |
|---------|-------------|------------------------------------|
| IDLE    | until start | waiting for work                   |
| LOAD    | 20 cycles   | weights captured into snapshots    |
| COMPUTE | 16 cycles   | systolic array accumulates         |
| OUTPUT  | 5 cycles    | results latched before reset fires |
| DONE    | 1 cycle     | done signal pulses high            |

One start pulse triggers the full pipeline. The controller
handles all timing automatically — no manual intervention needed.

### Hyperion Top — 4×4 (hyperion_top.v)
First full chip integration. Connects controller, SRAM, and
4×4 systolic array. Solved the core timing challenge that
became the foundation for the 8×8 design.

### Hyperion Top — 8×8 (hyperion_top_8x8.v) ← current
Current full chip integration. Connects controller, SRAM, and
8×8 systolic array. The key engineering challenge solved here
was timing — the systolic array resets between operations,
which wipes the accumulated results before they can be read.

The fix: output latches that capture results at the exact
clock cycle when COMPUTE transitions to OUTPUT, before the
reset signal fires.
```
COMPUTE state                OUTPUT state
    │                            │
    │  results accumulating      │  reset fires
    │  ──────────────────►       │  ──────────────►
    │                            │
    └──── latch captures here ───┘
```

## Design decisions

**Why 8-bit weights?**
Most modern AI chips use low precision arithmetic. Google's
TPU uses INT8 and BF16. Lower precision = smaller circuits =
faster computation = less power. 8-bit is a natural starting
point for a first chip design.

**Why a systolic array?**
Data flows through the array in waves — each value passes
through multiple MAC units without going back to memory.
This eliminates the memory bottleneck that makes CPUs slow
at matrix multiply. The same principle is used in every
major AI chip built today.

**Why a separate controller?**
Real chips are pipelined — while one layer is computing,
the next layer's weights are already being loaded. A
separate controller makes this possible without changing
the compute or memory modules. It also makes the design
modular — each component can be tested independently.

**Why output latches?**
The systolic array resets between operations to clear
accumulated values. Without latches, the reset fires before
the host can read the results. Latches decouple the compute
timing from the output timing — a standard technique in
real chip design called output buffering.

**Why scale from 4×4 to 8×8?**
The same reason Google scaled from TPU v1 to v4 — more MAC
units means more operations per clock cycle without changing
the fundamental architecture. Scaling by 2× in each dimension
gives 4× the compute. The path to a commercial chip is
repeated scaling of a proven design.

## Verified output — v0.6

Input `a=[1,2,3,4,5,6,7,8]` weights `w=[1,2,3,4,5,6,7,8]`:
```
Row 0:   3   6   9  12  15  18  21  24
Row 1:   6  12  18  24  30  36  42  48
Row 2:   9  18  27  36  45  54  63  72
Row 3:  12  24  36  48  60  72  84  96
Row 4:  15  30  45  60  75  90 105 120
Row 5:  18  36  54  72  90 108 126 144
Row 6:  21  42  63  84 105 126 147 168
Row 7:  24  48  72  96 120 144 168 192
```

Row ratios 1:2:3:4:5:6:7:8 ✓
Column ratios 1:2:3:4:5:6:7:8 ✓
All 64 outputs correct ✓

## Performance

At 64 MAC units running in parallel, Hyperion v0.6 performs
64 multiply-accumulate operations per clock cycle — 4× the
compute power of v0.5.

| Version | Array | MAC units | Ops/cycle |
|---------|-------|-----------|-----------|
| v0.5    | 4×4   | 16        | 16        |
| v0.6    | 8×8   | 64        | 64        |
| TPU v4  | 128×128 | 16,384  | 16,384    |

| Clock speed | Ops/second (v0.6) |
|-------------|-------------------|
| 1 MHz       | 64 million (64 MOPS) |
| 100 MHz     | 6.4 billion (6.4 GOPS) |
| 1 GHz       | 64 billion (64 GOPS) |

1 GHz is achievable on a modern FPGA. A real TPU v4 performs
275 trillion operations per second (275 TOPS). The path from
Hyperion to TPU is the same path from the Wright Brothers to
Boeing — same principles, more engineering.

## Known limitations and next steps

| Limitation | Next step |
|------------|-----------|
| No activation function | Add ReLU/tanh unit in Verilog |
| No bias terms | Add bias registers per row |
| Simulation only | Synthesize onto FPGA (Arty A7) |
| 8×8 array | Scale to 16×16 — 256 MAC units |
| Software weights | Connect to real trained model |
| Single chip | Submit to Google OpenMPW for silicon |

## Files

| File | Description |
|------|-------------|
| `verilog/mac_unit.v` | Multiply-accumulate unit |
| `verilog/systolic_array.v` | 4×4 grid — 16 MAC units |
| `verilog/systolic_array_8x8.v` | 8×8 grid — 64 MAC units |
| `verilog/sram.v` | On-chip weight storage |
| `verilog/controller.v` | FSM pipeline sequencer |
| `verilog/hyperion_top.v` | 4×4 full chip integration |
| `verilog/hyperion_top_8x8.v` | 8×8 full chip integration |
| `simulation/*_test.v` | Testbenches for each module |
| `python/hyperion_main_v2.ipynb` | Python simulation + benchmarks |
| `run_tests.sh` | Master test suite — 6 tests |
