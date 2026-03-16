# Hyperion Architecture — v1.3

## Overview

Hyperion is a custom AI accelerator chip designed and built
from scratch in Verilog. It implements the complete architecture
of a modern AI chip — from a single multiply-accumulate unit
all the way up to a full transformer block with attention,
feed-forward networks, layer normalization, and residual
connections.

As of v1.3, Hyperion contains 20 Verilog modules, 1,024 MAC
units, a verified training loop, and a complete transformer
block — the same architectural unit used in GPT, BERT, and
every major language model.

## Full transformer block pipeline
```
                    HYPERION TRANSFORMER BLOCK (v1.3)
────────────────────────────────────────────────────────────────
 input (8-dim token embedding)
     │
     ▼
┌───────────────────────────────────────────────────────────┐
│  LayerNorm 1 — normalize activations for stable training  │
└───────────────────────────────┬───────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────┐
│  Attention — scaled dot-product                           │
│  score = Q·K / sqrt(d)                                    │
│  output = softmax(score) × V                              │
└───────────────────────────────┬───────────────────────────┘
                                │
                                ▼
                    ┌─────────────────────┐
                    │  Residual add       │ ← input + attn_out
                    └──────────┬──────────┘
                               │
                               ▼
┌───────────────────────────────────────────────────────────┐
│  LayerNorm 2 — normalize before FFN                       │
└───────────────────────────────┬───────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────┐
│  FFN — Feed-Forward Network                               │
│  hidden = ReLU(input × W1 + b1)                           │
│  output = hidden × W2 + b2                                │
└───────────────────────────────┬───────────────────────────┘
                                │
                                ▼
                    ┌─────────────────────┐
                    │  Residual add       │ ← res1 + ffn_out
                    └──────────┬──────────┘
                               │
                           output
```

GPT-3 stacks 96 of these blocks. Hyperion has 1. Same
architecture, different scale.

## Training pipeline
```
                    HYPERION TRAINING LOOP (v1.2)
────────────────────────────────────────────────────────────────

  input + target
       │
       ▼
┌─────────────────┐
│  Forward pass   │  hyperion_layer: input × weight + bias → ReLU
└────────┬────────┘
         │ output
         ▼
┌─────────────────┐
│  Loss compute   │  MSE: (output - target)²
└────────┬────────┘
         │ error signal
         ▼
┌─────────────────┐
│  Backward pass  │  gradient_unit: dL/dW, dL/db, dL/dX
└────────┬────────┘
         │ gradients
         ▼
┌─────────────────┐
│  Weight update  │  weight_update_unit: w = w - lr × dW
└────────┬────────┘
         │ updated weights
         ▼
      repeat

Convergence verified: reaches target in 2 steps, stable forever.
This is the same 4-step loop that trained GPT, BERT, and every
major language model.
```

## Module inventory

| Module | Gates | Description |
|--------|-------|-------------|
| mac_unit.v | 571 | multiply-accumulate atom |
| relu_unit.v | 272 | ReLU activation |
| bias_unit.v | 1,824 | bias addition |
| sram.v | — | on-chip weight storage |
| controller.v | — | FSM pipeline sequencer |
| systolic_array.v | — | 4×4 — 16 MACs |
| systolic_array_8x8.v | — | 8×8 — 64 MACs |
| systolic_array_16x16.v | 146,176 | 16×16 — 256 MACs |
| systolic_array_32x32.v | 584,704 | 32×32 — 1,024 MACs |
| reduction_unit.v | 18,272 | 16×16 output reduction |
| reduction_unit_32x32.v | 74,368 | 32×32 output reduction |
| hyperion_layer.v | 166,859 | complete 16×16 layer |
| hyperion_layer_32x32.v | 664,775 | complete 32×32 layer |
| hyperion_deep.v | 333,718 | 2 stacked layers |
| hyperion_deeper.v | 500,577 | 3 stacked layers |
| gradient_unit.v | 18,403 | backward pass |
| weight_update_unit.v | 4,594 | SGD optimizer |
| attention_unit.v | 14,420 | scaled dot-product attention |
| layernorm_unit.v | 36,808 | layer normalization |
| ffn_unit.v | ~45,000 | feed-forward network |
| transformer_block.v | 165,063 | complete transformer layer |
| hyperion_trainer.v | — | full training pipeline |

## Version history

| Version | What was added | Key milestone |
|---------|----------------|---------------|
| v0.1 | MAC unit + 4×4 systolic array | first hardware |
| v0.2 | SRAM connected | memory |
| v0.3 | Controller FSM | autonomous pipeline |
| v0.4 | Full pipeline, timing fixed | first real chip |
| v0.5 | 4×4 matrix multiply verified | correct output |
| v0.6 | 8×8 array, 64 MACs | 4× scale |
| v0.7 | 16×16 array, ReLU, bias | complete layer formula |
| v0.8 | 2 stacked layers, 296,650 gates | deep network |
| v0.9 | 3 stacked layers, co-simulation | architectural finding |
| v1.0 | Reduction unit, true dot product | fixed co-simulation |
| v1.1 | Gradient unit, weight update | training loop |
| v1.2 | 32×32 array, attention unit | 1,024 MACs |
| v1.3 | LayerNorm, FFN, transformer block | GPT architecture |

## Synthesis results — v1.3

| Chip | Logic gates | Context |
|------|-------------|---------|
| Intel 4004 (1971) | 2,300 | first commercial CPU |
| Hyperion v0.6 | 36,966 | first full pipeline |
| Hyperion v1.0 | 166,859 | complete layer |
| Hyperion v1.2 | 664,775 | 32×32, 1024 MACs |
| Hyperion transformer block | 165,063 | GPT architecture unit |
| Arty A7 FPGA | 533,000 | target FPGA board |
| Apple M1 (2020) | 16,000,000,000 | modern processor |

## Performance

| Config | MACs | Ops at 1GHz |
|--------|------|-------------|
| 16×16 layer | 256 | 256 GOPS |
| 32×32 layer | 1,024 | 1 TOPS |
| Transformer block | 1,024+ | 1+ TOPS |
| Google TPU v4 | 16,384 | 275 TOPS |
| Nvidia H100 | — | 2,000 TOPS |

## Design decisions

**Why a systolic array?**
Data flows through the array in waves — each MAC unit receives
values from its neighbors without going back to memory. This
eliminates the memory bottleneck that makes CPUs slow at
matrix multiplication. Every major AI chip — TPU, H100, Apple
Neural Engine — uses this principle.

**Why output reduction?**
The systolic array computes a full N×N matrix, but a neural
network layer needs a vector output. The reduction unit sums
all row outputs per column, turning the matrix into a vector.
This was the key architectural fix in v1.0 — discovered
through co-simulation.

**Why LayerNorm?**
Without normalization, activations grow or shrink
uncontrollably across layers, making training unstable.
LayerNorm centers each vector to mean=0 and std=1 before
passing it to the next stage. Every transformer uses this.

**Why residual connections?**
Adding the input back to the output of each stage (x + f(x))
allows gradients to flow directly back to early layers during
training. Without residuals, deep networks suffer from
vanishing gradients and stop learning. This was the key
insight of ResNet (2015) that made deep learning practical.

**Why attention?**
Attention allows each position in a sequence to look at every
other position when computing its output. This is what makes
transformers powerful at language — the word "bank" can attend
to "river" or "money" depending on context. The scaled
dot-product formula Q·K/sqrt(d) was introduced in the original
"Attention Is All You Need" paper (2017).

## Next steps

| Target | Description |
|--------|-------------|
| FPGA synthesis | Run Hyperion on real Arty A7 hardware |
| Stack transformer blocks | 2-4 blocks = tiny LLM |
| BF16 precision | Upgrade from INT8 for training |
| Google OpenMPW | Submit for real silicon fabrication |
| MNIST benchmark | Classify handwritten digits on chip |
