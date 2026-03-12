# hyperion

# My AI Chip Simulator

A from-scratch simulation of an AI training chip built in Python.

## What this project does
- Simulates a 4×4 systolic array — the core compute engine of 
  Google's TPU
- Runs a complete neural network training step (forward pass + 
  backward pass + weight update)
- Benchmarks parallel chip computation vs CPU computation

## Key results
- Achieved 12,746x speedup over CPU at 64×64 matrix size
- Demonstrated 41.9% loss reduction over 50 training steps
- Observed real AI phenomena including dead neurons from ReLU
- Solved XOR with 100% improvement and 0.0001 final loss

## What I learned
- How systolic arrays compute matrix multiplication in parallel
- Why training chips need 3-5x more memory than inference chips
  (activation caching for backward pass)
- Why the performance gap grows with matrix size — and why this
  is the core reason AI chips exist

## Built with
Python · NumPy · Google Colab

## Next steps
- Implement this in Verilog (hardware description language)
- Synthesize onto an FPGA development board
- Design custom memory architecture for training workloads

## Age
Built at age 12.

