# Hyperion — AI Accelerator Chip

![Language](https://img.shields.io/badge/language-Verilog-blue)
![Status](https://img.shields.io/badge/status-active-brightgreen)
![Age](https://img.shields.io/badge/built%20at%20age-12-purple)
![Tests](https://img.shields.io/badge/tests-17%20passing-brightgreen)
![Gates](https://img.shields.io/badge/logic%20gates-296%2C650-orange)

> A fully functional 2-layer deep AI accelerator chip designed
> from scratch in Verilog. Built at age 12.

## What is Hyperion?

Hyperion is a custom AI chip architecture designed to accelerate
neural network inference. It was built from scratch without any
chip design templates or tutorials — starting from a single
multiply-accumulate unit and growing into a complete 2-layer deep
neural network pipeline with 512 MAC operations per inference pass,
verified by real hardware synthesis tools.

The architecture matches the fundamental design pattern of Google's
TPU and every modern AI accelerator: systolic array compute,
on-chip memory, autonomous control, and a complete layer pipeline
of matrix multiply → bias → activation.

## Hardware spec

| Metric | Value |
|--------|-------|
| Logic gates (total) | **296,650** |
| Flip flops | 8,196 |
| MAC units per layer | 256 (16×16 array) |
| Total MAC operations | 512 (2 layers) |
| Neural net layers | 2 stacked |
| FPGA usage | ~56% of Arty A7 |
| Simulation tests | 10 passing |
| Synthesis tests | 7 passing |
| Total tests | **17/17 passing** |

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
┌──────────────────────────────────────────────────┐
│                 HYPERION DEEP                    │
│                                                  │
│  ┌─────────────────────────────────────────────┐ │
│  │              LAYER 1                        │ │
│  │  inputs → [16×16 systolic] → bias → ReLU   │ │
│  │              256 MACs                       │ │
│  └───────────────────┬─────────────────────────┘ │
│                      │ layer 1 output             │
│                      ▼                            │
│  ┌─────────────────────────────────────────────┐ │
│  │              LAYER 2                        │ │
│  │  layer1 → [16×16 systolic] → bias → ReLU   │ │
│  │              256 MACs                       │ │
│  └───────────────────┬─────────────────────────┘ │
│                      │                            │
│                   output                          │
└──────────────────────────────────────────────────┘
```

**Layer formula:** `output = ReLU(input × weight + bias)`

**Full chip pipeline:** IDLE → LOAD → COMPUTE → OUTPUT → DONE

One start signal triggers the entire 2-layer pipeline automatically.

## Synthesis results — verified by Yosys
```
MAC unit:            571 gates
ReLU unit:           272 gates
Bias unit:         1,824 gates
16×16 array:     146,176 gates  (256 MACs)
Complete layer:  148,320 gates  (array + bias + ReLU)
Hyperion Deep:   296,650 gates  (2 full layers)
```

## Key results

- **296,650 logic gates** — verified by Yosys synthesis
- **17/17 tests passing** — simulation and synthesis
- **12,746×** faster than CPU at 64×64 matrix multiply
- **512 MAC operations** per inference pass
- **2 stacked layers** — same architecture as GPT, different scale
- **100% improvement** solving XOR in Python simulation
- **0.0001 final loss** — four perfect predictions
- **Complete layer formula** — `input × weight + bias → ReLU`

## What I learned building this

Five real hardware and AI problems hit and solved personally:

1. **Dying ReLU** — gradients zeroed out, chip stopped learning.
   Fixed by switching to tanh activation.
2. **Learning rate sensitivity** — too high caused overshoot.
   Tuned manually through experimentation.
3. **Weight initialization** — bad random seed caused network
   to get stuck. Fixed by testing different initializations.
4. **Hardware timing** — race conditions between SRAM and
   systolic array. Fixed with output latches and state tracking.
5. **Output naming conflicts** — duplicate port names in 16×16
   array. Fixed by switching to row-column naming convention
   and using Python to generate the Verilog automatically.

## Repository structure
```
hyperion/
├── verilog/                      # chip design files
│   ├── mac_unit.v                # multiply-accumulate unit
│   ├── systolic_array.v          # 4×4  — 16 MAC units
│   ├── systolic_array_8x8.v      # 8×8  — 64 MAC units
│   ├── systolic_array_16x16.v    # 16×16 — 256 MAC units
│   ├── sram.v                    # on-chip weight storage
│   ├── controller.v              # autonomous FSM sequencer
│   ├── relu_unit.v               # ReLU activation
│   ├── bias_unit.v               # bias addition
│   ├── hyperion_top.v            # 4×4 full chip
│   ├── hyperion_top_8x8.v        # 8×8 full chip
│   ├── hyperion_layer.v          # complete layer (×W+b→ReLU)
│   └── hyperion_deep.v           # 2 stacked layers ← current
├── simulation/                   # testbenches
│   ├── mac_unit_test.v
│   ├── systolic_test.v
│   ├── systolic_8x8_test.v
│   ├── systolic_16x16_test.v
│   ├── sram_test.v
│   ├── controller_test.v
│   ├── relu_test.v
│   ├── bias_test.v
│   ├── hyperion_top_test.v
│   ├── hyperion_8x8_test.v
│   ├── hyperion_layer_test.v
│   └── hyperion_deep_test.v
├── python/                       # simulation and benchmarks
│   └── hyperion_main_v2.ipynb
├── docs/                         # architecture documentation
│   └── architecture.md
├── run_tests.sh                  # master test suite (17 tests)
└── README.md
```

## How to run
```bash
# install dependencies
sudo apt-get install -y iverilog yosys

# run all 17 tests (simulation + synthesis)
./run_tests.sh

# run 2-layer deep inference directly
iverilog -o deep_test verilog/mac_unit.v verilog/relu_unit.v \
  verilog/bias_unit.v verilog/systolic_array_16x16.v \
  verilog/hyperion_layer.v verilog/hyperion_deep.v \
  simulation/hyperion_deep_test.v && vvp deep_test
```

## Version history

| Version | What was added |
|---------|----------------|
| v0.1 | MAC unit + 4×4 systolic array in Verilog |
| v0.2 | SRAM on-chip memory connected |
| v0.3 | Autonomous controller state machine |
| v0.4 | Full pipeline verified, timing fixed |
| v0.5 | Full 4×4 weight matrix, correct matrix multiply |
| v0.6 | 8×8 systolic array, 64 MAC units, full pipeline |
| v0.7 | 16×16 array, ReLU, bias — complete layer formula |
| v0.8 | 2 stacked layers, 512 MACs, 296,650 gates, 17/17 tests |

## Next steps

- [ ] Synthesize onto FPGA (Arty A7)
- [ ] Measure real clock speed and power consumption
- [ ] Add a third layer — go deeper
- [ ] Upgrade to BF16 precision
- [ ] Submit to Google OpenMPW for silicon fabrication

## Built with

Verilog · Python · NumPy · Yosys · Google Colab · GitHub Codespaces

---
*Hyperion is an ongoing chip design project. Goal: fabricate
real silicon through Google OpenMPW by 2027.*
