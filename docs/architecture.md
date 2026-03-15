# Hyperion Architecture — v0.8

## Overview

Hyperion is built around a layered pipeline of components that
together implement a complete neural network inference engine.
The design follows the same architectural pattern used in
Google's TPU and Nvidia's H100 — just at a smaller scale.

As of v0.8, Hyperion runs a verified 2-layer deep neural network
with 256 MAC units per layer, bias addition, and ReLU activation —
512 MAC operations per inference pass, synthesized to 296,650
logic gates and verified by Yosys.

## Full pipeline
```
                    HYPERION DEEP (v0.8)
────────────────────────────────────────────────────────
 inputs (16 × 8-bit)
     │
     ▼
┌─────────────────────────────────────────────────────┐
│                     LAYER 1                         │
│                                                     │
│  ┌──────────────────┐   ┌──────────┐   ┌────────┐  │
│  │ 16×16 Systolic   │──►│  Bias    │──►│  ReLU  │  │
│  │ Array (256 MACs) │   │  Unit    │   │  Unit  │  │
│  └──────────────────┘   └──────────┘   └────────┘  │
│                                                     │
│  formula: output = ReLU(input × weight + bias)      │
└───────────────────────────┬─────────────────────────┘
                            │ 16 × 16-bit values
                            ▼
┌─────────────────────────────────────────────────────┐
│                     LAYER 2                         │
│                                                     │
│  ┌──────────────────┐   ┌──────────┐   ┌────────┐  │
│  │ 16×16 Systolic   │──►│  Bias    │──►│  ReLU  │  │
│  │ Array (256 MACs) │   │  Unit    │   │  Unit  │  │
│  └──────────────────┘   └──────────┘   └────────┘  │
│                                                     │
│  formula: output = ReLU(layer1 × weight + bias)     │
└───────────────────────────┬─────────────────────────┘
                            │
                     final output
                    (16 × 16-bit values)
```

**State machine:** IDLE → LOAD → COMPUTE → OUTPUT → DONE

Layer 2 starts automatically when layer 1 fires done.
One start signal runs the entire 2-layer pipeline.

## Components

### MAC Unit (mac_unit.v)
The atomic building block. Takes two 8-bit inputs, multiplies
them, and accumulates the result into a 16-bit register on
every clock edge. Synthesizes to 571 logic gates.
```
a (8-bit) ──►┐
             ├── multiply ──► accumulate ──► out (16-bit)
b (8-bit) ──►┘
```

### Systolic Array — 4×4 (systolic_array.v)
16 MAC units in a 4×4 grid. First implementation —
foundation for all later designs.
```
     b0   b1   b2   b3
a0 [MAC][MAC][MAC][MAC]
a1 [MAC][MAC][MAC][MAC]
a2 [MAC][MAC][MAC][MAC]
a3 [MAC][MAC][MAC][MAC]
```

### Systolic Array — 8×8 (systolic_array_8x8.v)
64 MAC units in an 8×8 grid. Used in the autonomous
full-chip pipeline (hyperion_top_8x8.v).
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

### Systolic Array — 16×16 (systolic_array_16x16.v) ← current
256 MAC units in a 16×16 grid. Synthesizes to 146,176 gates.
Generated using Python to avoid naming conflicts.
```
      b0  b1  b2 ... b15
a0  [MAC][MAC][MAC]...[MAC]
a1  [MAC][MAC][MAC]...[MAC]
...
a15 [MAC][MAC][MAC]...[MAC]
```

A real TPU has a 128×128 systolic array — 16,384 MAC units.
Hyperion v0.8 has 256. Same architecture, different scale.

### SRAM (sram.v)
64 locations of 8-bit on-chip storage. Holds weights close
to compute units so they don't need to be fetched from slow
external memory every cycle.

Write mode: data_in stored at address on rising clock edge.
Read mode:  data_out reflects value at address one cycle later.

### Controller (controller.v)
A finite state machine with 5 states that sequences the
entire pipeline automatically from one start pulse.
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

### ReLU Unit (relu_unit.v)
Applies ReLU activation to all 16 column outputs.
Synthesizes to 272 gates — extremely lightweight.
```
input ──► if negative → 0
          if positive → unchanged
```

ReLU is implemented as a single combinational check of the
sign bit (bit 15). No clock needed — pure logic.

### Bias Unit (bias_unit.v)
Adds a learnable bias value to each of the 16 outputs.
Synthesizes to 1,824 gates. Runs between the systolic
array and ReLU in the layer pipeline.
```
output = input + bias
```

Bias shifts each neuron's activation threshold independently.
Without bias, the network can only learn scaled versions of
the input. With bias, it can learn arbitrary functions.

### Hyperion Layer (hyperion_layer.v)
One complete neural network layer. Connects systolic array,
bias unit, and ReLU into a single pipeline module.
Synthesizes to 148,320 gates.

Formula: `output = ReLU(input × weight + bias)`

This is mathematically identical to one layer of GPT, BERT,
or any transformer model.

### Hyperion Deep (hyperion_deep.v) ← current top module
Two stacked hyperion_layer modules. Layer 2 starts
automatically when layer 1 signals done. Synthesizes to
296,650 gates total.

The output of layer 1 is quantized from 16-bit to 8-bit
before feeding into layer 2 — the same technique used in
real quantized inference on TPUs and mobile chips.

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

**Why scale from 4×4 to 8×8 to 16×16?**
The same reason Google scaled from TPU v1 to v4 — more MAC
units means more operations per clock cycle without changing
the fundamental architecture. Scaling by 2× in each dimension
gives 4× the compute. Each generation proved the design before
scaling to the next.

**Why stack two layers?**
A single layer can only learn linear transformations. Stacked
layers with non-linear activations between them can learn
arbitrary functions — this is the mathematical reason deep
networks are powerful. GPT has 96 stacked layers. Hyperion
has 2. Same principle, different scale.

**Why quantize between layers?**
Layer 1 outputs 16-bit values but layer 2 accepts 8-bit
inputs. Truncating to the lower 8 bits is a form of
quantization — trading some precision for hardware
efficiency. This is standard practice in production AI
chips including Google's TPU.

## Hardware timing — the hardest problem solved

The most difficult engineering challenge in Hyperion was
timing. The systolic array resets between operations, which
wipes accumulated results before they can be read.
```
COMPUTE state                OUTPUT state
    │                            │
    │  results accumulating      │  reset fires
    │  ──────────────────►       │  ──────────────►
    │                            │
    └──── latch captures here ───┘
```

The fix was output latches that capture results at the exact
clock cycle when COMPUTE transitions to OUTPUT. This required
tracking the previous state explicitly and triggering the
latch on the state transition edge — not on the state itself.

## Synthesis results — v0.8

Synthesized with Yosys 0.33.

| Module | Logic gates | Notes |
|--------|-------------|-------|
| mac_unit | 571 | compute atom |
| relu_unit | 272 | pure combinational |
| bias_unit | 1,824 | 16 adders |
| systolic_array_16x16 | 146,176 | 256 MACs |
| hyperion_top_8x8 | 36,966 | full 8×8 pipeline |
| hyperion_layer | 148,320 | complete layer |
| hyperion_deep | 296,650 | 2-layer full chip |

### Context

| Chip | Logic gates |
|------|-------------|
| Intel 4004 — 1971 first CPU | 2,300 |
| Hyperion v0.6 (8×8) | 36,966 |
| Hyperion v0.8 (2-layer deep) | 296,650 |
| Arty A7 FPGA capacity | 533,000 |
| Apple M1 — 2020 | 16,000,000,000 |

Hyperion v0.8 uses ~56% of an Arty A7 FPGA.
Hyperion v0.6 used ~7%. The design has grown 8× in two
versions — the same scaling trajectory as real chip generations.

### Flip flop breakdown

8,196 total flip flops = 2 layers × 256 MACs × 16 bits each.
No wasted registers. The design is mathematically clean.

## Performance

| Version | Array | MACs | Ops/inference |
|---------|-------|------|---------------|
| v0.5 | 4×4 | 16 | 16 |
| v0.6 | 8×8 | 64 | 64 |
| v0.7 | 16×16 | 256 | 256 |
| v0.8 | 16×16 × 2 | 512 | 512 |
| TPU v4 | 128×128 | 16,384 | 16,384+ |

| Clock speed | Ops/second (v0.8) |
|-------------|-------------------|
| 1 MHz | 512 million (512 MOPS) |
| 100 MHz | 51.2 billion (51.2 GOPS) |
| 1 GHz | 512 billion (512 GOPS) |

1 GHz is achievable on a modern FPGA. A real TPU v4 performs
275 trillion operations per second (275 TOPS). The path from
Hyperion to TPU is the same path from the Wright Brothers to
Boeing — same principles, more engineering.

## Known limitations and next steps

| Limitation | Next step |
|------------|-----------|
| 2 layers | Add more layers — go deeper |
| INT8 precision | Upgrade to BF16 |
| Simulation only | Synthesize onto FPGA (Arty A7) |
| No real model weights | Connect to trained PyTorch model |
| Single chip | Submit to Google OpenMPW for silicon |

## Files

| File | Description |
|------|-------------|
| `verilog/mac_unit.v` | Multiply-accumulate unit — 571 gates |
| `verilog/systolic_array.v` | 4×4 grid — 16 MAC units |
| `verilog/systolic_array_8x8.v` | 8×8 grid — 64 MAC units |
| `verilog/systolic_array_16x16.v` | 16×16 grid — 256 MAC units |
| `verilog/sram.v` | On-chip weight storage |
| `verilog/controller.v` | FSM pipeline sequencer |
| `verilog/relu_unit.v` | ReLU activation — 272 gates |
| `verilog/bias_unit.v` | Bias addition — 1,824 gates |
| `verilog/hyperion_top.v` | 4×4 full chip |
| `verilog/hyperion_top_8x8.v` | 8×8 full chip |
| `verilog/hyperion_layer.v` | Complete layer — 148,320 gates |
| `verilog/hyperion_deep.v` | 2-layer deep — 296,650 gates |
| `simulation/*_test.v` | Testbenches — 10 simulation tests |
| `python/hyperion_main_v2.ipynb` | Python simulation + benchmarks |
| `run_tests.sh` | Master test suite — 17 tests |
