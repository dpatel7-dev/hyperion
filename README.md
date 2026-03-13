# Hyperion — AI Training Chip

> A fully functional AI accelerator chip designed from scratch in Verilog.
> Built at age 12.

## What is Hyperion?

Hyperion is a custom AI chip architecture designed to accelerate
matrix multiplication — the core operation behind every neural
network. It was built from scratch without any chip design templates
or tutorials, starting from a single multiply-accumulate unit and
growing into a complete autonomous inference pipeline.

## Benchmark results

| Matrix size | CPU time | Hyperion time | Speedup |
|-------------|----------|---------------|---------|
| 4×4 | 0.40ms | 0.0069ms | 58× |
| 8×8 | 1.98ms | 0.0051ms | 389× |
| 16×16 | 25.61ms | 0.1287ms | 199× |
| 32×32 | 93.94ms | 0.0083ms | 11,289× |
| 64×64 | 289.30ms | 0.0227ms | **12,746×** |

## Architecture
```
┌─────────────────────────────────────────────┐
│                HYPERION CHIP                │
│                                             │
│  ┌────────────┐      ┌───────────────────┐  │
│  │ Controller │─────►│  Systolic Array   │  │
│  │   (FSM)    │      │   (16 MAC units)  │  │
│  └─────┬──────┘      └───────────────────┘  │
│        │                      ▲             │
│        ▼                      │             │
│  ┌────────────┐               │             │
│  │    SRAM    │───────────────┘             │
│  │  (weights) │                             │
│  └────────────┘                             │
└─────────────────────────────────────────────┘
```

**Pipeline:** IDLE → LOAD → COMPUTE → OUTPUT → DONE

One start signal triggers the full pipeline automatically.

## Key results

- **12,746×** faster than CPU at 64×64 matrix multiply
- **100% improvement** solving XOR — the problem that caused
  the 1969 AI winter
- **0.0001 final loss** — four perfect predictions
- **Correct 4×4 matrix multiply** verified in hardware:
  inputs [1,2,3,4] × weights [1,2,3,4] produces exact output

## What I learned building this

Three real AI training problems hit and solved personally:

1. **Dying ReLU** — gradients zeroed out, chip stopped learning.
   Fixed by switching to tanh activation.
2. **Learning rate sensitivity** — too high caused overshoot.
   Tuned manually through experimentation.
3. **Weight initialization** — bad random seed caused network
   to get stuck. Fixed by testing different initializations.
4. **Hardware timing** — race conditions between SRAM and
   systolic array. Fixed with output latches and state tracking.

## Repository structure
```
hyperion/
├── verilog/              # chip design files
│   ├── mac_unit.v        # multiply-accumulate unit (compute atom)
│   ├── systolic_array.v  # 16 MAC units in parallel
│   ├── sram.v            # on-chip weight storage
│   ├── controller.v      # autonomous FSM sequencer
│   ├── hyperion_top.v    # full chip integration
│   └── hyperion.v        # earlier integration version
├── simulation/           # testbenches
│   ├── mac_unit_test.v
│   ├── systolic_test.v
│   ├── sram_test.v
│   ├── controller_test.v
│   ├── hyperion_top_test.v
│   └── hyperion_test.v
├── python/               # simulation and benchmarks
│   └── hyperion_main_v2.ipynb
├── docs/                 # architecture documentation
└── README.md
```

## How to run
```bash
# install simulator
sudo apt-get install -y iverilog

# run full chip test
iverilog -o top_test verilog/mac_unit.v verilog/sram.v \
  verilog/systolic_array.v verilog/controller.v \
  verilog/hyperion_top.v simulation/hyperion_top_test.v \
  && vvp top_test
```

## Versions

| Version | What was added |
|---------|---------------|
| v0.1 | MAC unit + 4×4 systolic array in Verilog |
| v0.2 | SRAM on-chip memory connected |
| v0.3 | Autonomous controller state machine |
| v0.4 | Full pipeline verified, timing fixed |
| v0.5 | Full 4×4 weight matrix, correct matrix multiply |

## Next steps

- [ ] Synthesize onto FPGA (Arty A7)
- [ ] Measure real clock speed and power consumption
- [ ] Submit to Google OpenMPW for silicon fabrication
- [ ] Add pipelining for higher throughput
- [ ] Support full neural network layer with bias and activation

## Built with

Verilog · Python · NumPy · Google Colab · GitHub Codespaces

---
*Hyperion is an ongoing chip design project. Goal: fabricate
real silicon through Google OpenMPW by 2026.*
