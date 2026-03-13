# Hyperion Architecture

## Overview

Hyperion is built around three core components connected by
a central controller. The design follows the same architectural
pattern used in Google's TPU and Nvidia's H100 — just at a
smaller scale.

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

### Systolic Array (systolic_array.v)
16 MAC units arranged in a 4×4 grid. Each row shares the
same input, each column shares the same weight. All 16
multiply-accumulate operations happen simultaneously in
one clock cycle.
```
     b0   b1   b2   b3
a0 [MAC][MAC][MAC][MAC]
a1 [MAC][MAC][MAC][MAC]
a2 [MAC][MAC][MAC][MAC]
a3 [MAC][MAC][MAC][MAC]
```

A real TPU has a 128×128 systolic array — 16,384 MAC units.
Hyperion has 16. Same architecture, different scale.

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

| State   | Duration    | What happens                        |
|---------|-------------|-------------------------------------|
| IDLE    | until start | waiting for work                    |
| LOAD    | 20 cycles   | weights captured into snapshots     |
| COMPUTE | 16 cycles   | systolic array accumulates          |
| OUTPUT  | 5 cycles    | results latched before reset fires  |
| DONE    | 1 cycle     | done signal pulses high             |

One start pulse triggers the full pipeline. The controller
handles all timing automatically — no manual intervention needed.

### Hyperion Top (hyperion_top.v)
Connects all components. The key engineering challenge solved
here was timing — the systolic array resets between operations,
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

## Verified output

Input `a=[1,2,3,4]` weights `w=[1,2,3,4]`:

```
Row 0:   3   6   9  12
Row 1:   6  12  18  24
Row 2:   9  18  27  36
Row 3:  12  24  36  48
```

Row ratios 1:2:3:4 ✓  Column ratios 1:2:3:4 ✓  All 16 outputs correct ✓

## Performance

At 16 MAC units running in parallel, Hyperion performs
16 multiply-accumulate operations per clock cycle.

| Clock speed | Operations/second |
|-------------|-------------------|
| 1 MHz       | 16 million (16 MOPS) |
| 100 MHz     | 1.6 billion (1.6 GOPS) |
| 1 GHz       | 16 billion (16 GOPS) |

1 GHz is achievable on a modern FPGA. A real TPU v4 performs
275 trillion operations per second (275 TOPS). The path from
Hyperion to TPU is the same path from the Wright Brothers to
Boeing — same principles, more engineering.

## Known limitations and next steps

| Limitation | Next step |
|------------|-----------|
| Single weight per column | Full SRAM-fed weight matrix |
| 4×4 array | Scale to 8×8 or 16×16 |
| No activation function | Add ReLU/tanh in hardware |
| No bias terms | Add bias registers per row |
| Simulation only | Synthesize onto FPGA |
| Software weights | Connect to real trained model |

## Files

| File | Description |
|------|-------------|
| `verilog/mac_unit.v` | Multiply-accumulate unit |
| `verilog/systolic_array.v` | 4×4 grid of MAC units |
| `verilog/sram.v` | On-chip weight storage |
| `verilog/controller.v` | FSM pipeline sequencer |
| `verilog/hyperion_top.v` | Full chip integration |
| `simulation/*_test.v` | Testbenches for each module |
| `python/hyperion_main_v2.ipynb` | Python simulation + benchmarks |