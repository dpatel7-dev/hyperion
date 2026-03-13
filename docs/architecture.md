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

### Controller (controller.v)
A finite state machine with 5 states:
```
IDLE ──► LOAD ──► COMPUTE ──► OUTPUT ──► DONE ──► IDLE
```

One start pulse triggers the full pipeline. The controller
handles all timing automatically — no manual intervention.

### Hyperion Top (hyperion_top.v)
Connects all components. Adds output latches that capture
results at the exact moment COMPUTE transitions to OUTPUT,
before the reset signal wipes the accumulators.

## Design decisions

**Why 8-bit weights?**
Most modern AI chips use low precision arithmetic. Google's
TPU uses INT8 and BF16. Lower precision = smaller circuits =
faster computation = less power. 8-bit is a natural starting
point.

**Why a systolic array?**
Data flows through the array in waves — each value passes
through multiple MAC units without going back to memory.
This eliminates the memory bottleneck that makes CPUs slow
at matrix multiply.

**Why a separate controller?**
Real chips are pipelined — while one layer is computing,
the next layer's weights are already being loaded. A
separate controller makes this possible without changing
the compute or memory modules.

## Performance

At 16 MAC units running in parallel, Hyperion performs
16 multiply-accumulate operations per clock cycle. At
1MHz that is 16 million operations per second (16 MOPS).
At 1GHz (achievable on FPGA) that is 16 billion operations
per second (16 GOPS).

A real TPU v4 performs 275 trillion operations per second
(275 TOPS). The path from Hyperion to TPU is the same path
from Wright Brothers to Boeing — same principles, more
engineering.
