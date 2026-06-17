# Hyperion on FPGA - Arty A7-35T

This folder contains everything needed to run Hyperion on a real FPGA board.

## What's here

| File | What it does |
|------|--------------|
| hyperion_fpga_top.v | Top-level wrapper - the module loaded onto the FPGA |
| uart.v | Serial communication - lets the chip talk to your computer over USB |
| hyperion_arty_a7.xdc | Constraints - maps chip signals to physical board pins |

## What you need

- Arty A7-35T FPGA board (~$130)
- Xilinx Vivado (free WebPACK edition)
- A USB cable (USB-A to micro-USB)

## How it works

Your computer -> USB -> UART RX -> Hyperion -> UART TX -> USB -> Your computer

1. You send a starting token byte over USB
2. Hyperion runs its language model in hardware
3. Hyperion sends the generated token back over USB
4. The 4 LEDs show what the chip is doing:
   - LED0 = ready
   - LED1 = thinking
   - LED2 = sending
   - LED3 = byte received

## Steps to run on hardware

1. Install Vivado (free WebPACK edition from Xilinx)
2. Create a new project, target part xc7a35ticsg324-1L (Arty A7-35T)
3. Add the three files in this folder
4. Set hyperion_fpga_top as the top module
5. Run Synthesis -> Implementation -> Generate Bitstream
6. Connect the Arty board via USB
7. Open Hardware Manager -> Program Device
8. Open a serial terminal (115200 baud) and send a byte

## Status

- UART: verified in simulation
- Top-level wrapper: verified in simulation
- Constraints: written for Arty A7-35T
- Hardware test: pending board purchase

Built at age 12.
