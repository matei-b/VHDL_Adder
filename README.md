# 4-bit and 16-bit Carry-Lookahead Adders in VHDL

This repository contains VHDL implementations of two Carry-Lookahead Adders (CLAs):

1. A **4-bit CLA adder** constructed using 1-bit sum units and a carry-generation unit (commonly referred to as a TAU).
2. A **16-bit CLA adder** built hierarchically using 4-bit CLA units and a higher-level carry-generation unit (TAU).

## Project Overview
The main goal of this project is to demonstrate the modular design and hierarchical implementation of CLA circuits in VHDL. By using smaller components to construct larger systems, this approach highlights the scalability and efficiency of carry-lookahead logic.

### Features
- **4-bit CLA Adder**: Implements a 4-bit adder using 1-bit sum modules and a TAU for carry generation and propagation.
- **16-bit CLA Adder**: Implements a 16-bit adder by reusing the 4-bit CLA as building blocks, combined with a higher-level TAU for efficient carry management.

### File Structure
```
.
|-- carry_lookahead_4bit_adder/             # Code and components for the 4-bit CLA
|   |-- src/
|   |   |-- 1bit_adder_unit.vhd                 # 1-bit sum unit implementation
|   |   |-- carry_lookahead_4bit_adder.vhd      # Top-level 4-bit CLA entity
|   |   |-- transport_anticipation_unit.vhd     # Carry-generation and propagation logic for 4 bits
|   |-- test                                    
|   |   |-- tb_4bit_cla_adder.vhd               # Testbench for the 4-bit CLA
|
|-- carry_lookahead_16bit_adder/            # Code and components for the 16-bit CLA
|   |-- src/
|   |   |-- carry_lookahead_4bit_adder.vhd      # Reused 4-bit CLA module
|   |   |-- carry_lookahead_16bit_adder.vhd     # Top-level 16-bit CLA entity
|   |   |-- transport_anticipation_unit.vhd     # Carry-generation and propagation logic for 16 bits
|   |-- test                                    
|   |   |-- tb_cla_16bit_adder.vhd              # Testbench for the 16-bit CLA
|
|-- README.md                               # Project documentation
```

### Key Concepts
1. **Carry-Lookahead Logic**:
   - The carry-lookahead mechanism optimizes addition by calculating carry signals in parallel rather than sequentially.
   - This reduces the critical path delay, especially for larger bit-width adders.

2. **Hierarchical Design**:
   - The 16-bit CLA uses 4-bit CLAs as building blocks, showcasing modularity and code reuse.
   - A higher-level TAU coordinates the carry signals between the 4-bit blocks.

## Getting Started

### Prerequisites
To work with this project, you will need:
- A VHDL simulator and synthesis tool (e.g Vivado).
- Basic knowledge of VHDL syntax and digital design concepts.

### Simulation Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/matei.b/VHDL_Adders.git
   cd cla_adders
   ```
2. Open your preferred VHDL simulation tool.
3. Compile the necessary VHDL files:
   - For the 4-bit CLA: Compile all files in `carry_lookahead_4bit_adder/`.
   - For the 16-bit CLA: Compile all files in `carry_lookahead_16bit_adder/`.
4. Compile and run the corresponding testbench from `preferred_adder/test/`.
5. Observe the waveform or simulation output to verify the correctness of the designs.

### Example
For the 4-bit CLA, the simulation output should demonstrate correct sum and carry-out values for all input combinations. Similarly, the 16-bit CLA testbench should verify functionality for larger inputs.

## Results
The designs have been verified in simulation to:
- Accurately compute sum and carry values.
- Maintain low critical path delay compared to ripple-carry adders of equivalent size.
