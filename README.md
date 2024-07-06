# 6 Stage RISC Pipeline

## Overview

This repository contains VHDL files that implement a 6-stage RISC pipeline. The stages of the pipeline are Instruction Fetch (IF), Instruction Decode/Register Read (IR/RR), Execute (EX), Memory Access (MEM), and Write Back (WB). Note that the provided VHDL files do not compile into a complete pipeline and require further modifications. The pipeline includes a forwarding unit and a hazard mitigation unit for handling stalling, flushing instructions, and dealing with dependencies.


## RISC (Reduced Instruction Set Computer)

RISC stands for Reduced Instruction Set Computer. It is a type of microprocessor architecture that utilizes a small, highly-optimized set of instructions. The main characteristics of RISC architectures are:

- **Simple Instructions**: Each instruction is designed to be executed in a single clock cycle.
- **Load/Store Architecture**: Instructions operate on registers, with separate instructions for loading from and storing to memory.
- **Pipeline**: RISC architectures often use pipelines to improve performance by executing multiple instructions simultaneously at different stages of completion.

## Pipeline Stages

1. **Instruction Fetch (IF)**: 
    - The first stage of the pipeline.
    - Fetches the instruction from memory.
    - Updates the Program Counter (PC).

2. **Instruction Decode/Register Read (IR/RR)**: 
    - Decodes the fetched instruction.
    - Reads the necessary registers.
    - Determines the operation to be performed.

3. **Execute (EX)**:
    - Performs the arithmetic or logical operation specified by the instruction.
    - Calculates the address for memory operations.

4. **Memory Access (MEM)**:
    - Accesses the data memory for load and store instructions.
    - Fetches data for load instructions.
    - Writes data for store instructions.

5. **Write Back (WB)**:
    - Writes the result back to the register file.

## Project Details

### Forwarding Unit
The forwarding unit is responsible for handling data hazards by forwarding data from later stages of the pipeline to earlier stages when necessary.

### Hazard Mitigation Unit
The hazard mitigation unit manages control hazards and data hazards. It handles stalling the pipeline, flushing instructions, and resolving dependencies to ensure correct execution order.

### Repository Contents

- **VHDL Files**: Contains all the relevant VHDL files for the 6-stage RISC pipeline.
- **Netlist.pdf**: A PDF document containing the final netlist of the project.
- **Report.pdf**: A report explaining the findings and results of the project.

## Getting Started

To use the VHDL files in this repository, you will need a VHDL simulator. Note that the provided VHDL files require further modifications to compile into a complete pipeline.

### Prerequisites

- VHDL simulator (e.g., ModelSim, GHDL)

### Compilation

1. Clone the repository:
    ```bash
    git clone https://github.com/Kshitij-Vaidya/RISC_Pipelining.git
    cd RISC_Pipelining
    ```

2. Open the VHDL files in your VHDL simulator.

3. Compile the VHDL files. Note that you may need to make modifications to the files to resolve compilation issues.

4. Simulate the pipeline and observe the behavior.

## Contributing

Contributions are welcome! If you have any improvements or fixes, please fork the repository, make your changes, and submit a pull request.

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Open a pull request.

## Acknowledgements

- Course Instructor: Prof. Virendra Singh
- FPGA Development Environment: Intel Quartus Prime
- Contributers to the Project: Kshitij Vaidya, Jay Mehta, Adit Srivastave, Jainam Ravani

---

Feel free to reach out if you have any questions or need further assistance. Happy coding!