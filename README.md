# Multi-Cycle RISC Processor Design
![Screenshot 2024-06-06 194223](https://github.com/user-attachments/assets/f8ab0b5f-afa8-473f-b15d-f32ef1528e99)


## Project Overview
This project involves designing and implementing a multi-cycle five-stage RISC processor. The processor supports a specific subset of RISC instructions, complete with individual components like ALU, register file, data memory, and control unit. It also includes extensive simulation and testing to verify functionality.

## Project Goals
- Analyze and implement a specific RISC instruction set architecture (ISA).
- Design modular components, including ALU, Register File, Instruction Memory, Data Memory, and Control Unit.
- Assemble the components into a functional datapath.
- Develop a finite state machine-based Control Unit to manage instruction execution.
- Simulate and validate the processor through various test programs.

## Components and Design
### 1. Instruction Memory
- Byte-addressable storage for instructions.

### 2. Data Memory
- Byte-addressable, with additional signals for byte/word operations (LBu, LBs).

### 3. Extender
- Supports zero and sign extension for immediate values.

### 4. ALU
- Performs ADD, SUB, AND operations.
- Outputs include result, zero flag, and negative flag.

### 5. Register File
- Contains eight registers (R0-R7), with R7 used specifically for CALL/RET instructions.

### 6. Branch Control
- Logic gates to determine branch conditions based on ALU flags.

### 7. Datapath
- Integrated modular components forming a multi-cycle pipeline (fetch, decode, execute, memory access, and write-back stages).

### 8. Control Unit
- Finite state machine handling all control signals for each instruction stage.
- Boolean equations derived for all control signals.

## Instructions Supported
- R-type: AND, ADD, SUB
- I-type: ADDI, ANDI, LW, LBu, LBs, SW
- Branch: BLT, BGTZ
- CALL, RET
- JUMP, SV

## Testing and Simulation
- Conducted comprehensive tests with different instruction sets (arithmetic, logic, load/store, branching, call/return, jump, store value).
- Simulation performed using waveforms to validate correctness at each pipeline stage.

## Project Deliverables
- Modular RTL design using Verilog.
- Testbench environment.
- Documentation (truth tables, Boolean equations, and detailed design descriptions).

## How to Run the Project
1. Clone this repository.
2. Load the provided Verilog files into a simulation environment (e.g., ModelSim, Quartus).
3. Run the testbench to simulate and validate the processor operation.

## Contributors
- Abdalrahman Juber (ID: 1211769)
- Ali Shaikh Qasem (ID: 1212171)


## Supervisors
- Dr. Ayman Hroub
- Dr. Aziz Qaroush

## University
Birzeit University, Faculty of Engineering and Technology, Department of Electrical and Computer Engineering.

## Date
June 20, 2024

