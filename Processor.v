`include "parameters.v"
module Processor (clk);
	
	input clk; // only one input, no outputs
	
	// control unit wires
	wire  PcWrite, CtrlRet, RegDst, MemRead, MemWrite, IRwrite, RegWrite, AluSrcA, CtrlBranch, ExtOp, MemDataSrc, CtrlBW, CtrlM;
	wire [1:0] PcSource, AluOp , MemToReg;
	wire [2:0] AluSrcB;
	wire Mbit;
	wire [3:0] opcode; 
	
	// define the needed wires 
	
	// fetch stage wires 
	wire [15:0] pc_input ;
	reg [15:0] pc_output;
	wire pc_enable;
	reg [15:0] IM_output; // output of insturcion memory 
	reg [15:0] IR_output; // output of instruction regsiter
	
	// decode stage	wires
	reg [2:0] Rs1_mux_input, Rs2_mux_input, Rd_mux_input;
	reg [11:0] jump_offset; 
	reg [4:0] Itype_imm; 
	reg [15:0] Stype_imm; 
	wire [2:0] regFile_rs1, regFile_rs2, regFile_rd;
	wire [15:0] regFile_write_data;
	reg [15:0] regFile_out1, regFile_out2, regFile_buffer_out1, regFile_buffer_out2;
	
	// ALU stage wires
	reg [15:0] ALU_in_A,  ALU_in_B, extender_output; 
	wire [15:0] branch_shifter_output; 
	wire [15:0] ALU_output;
	reg [15:0] ALU_buffer_output;
	wire ALU_zero, ALU_negative;
	
	// memory and WB stages wires
	wire [15:0] data_memory_input_data;
	reg [15:0]  data_memory_output, WB_buffer_output;
	wire [15:0] j_target_address; 
	
	// branch logic ( and, or gates ) wires
	wire  w_BEQ, w_BEQZ, w_BGT, w_BGTZ, w_BLT, w_BLTZ, w_BNE, w_BNEZ; 
	wire or1_out, or2_out, or3_out, or4_out;
	wire and1_out, and2_out, and3_out, and4_out; 
	
	// assign opcode and mbit
	assign opcode = IR_output[15:12];
	assign Mbit = IR_output[11];
	
	
	// branch logic assingment 	
	assign w_BEQ = (opcode == BEQ); 
	assign w_BEQZ = (opcode == BEQZ);
	assign w_BGT = (opcode == BGT);
	assign w_BGTZ = (opcode == BGTZ);
	assign w_BLT = (opcode == BLT); 
	assign w_BLTZ = (opcode == BLTZ);
	assign w_BNE = (opcode == BNE);
	assign w_BNEZ = (opcode == BNEZ);	 
	assign or1_out = w_BNE | w_BNEZ;
	assign or2_out = w_BEQ | w_BEQZ;
	assign or3_out = w_BLT | w_BLTZ;
	assign or4_out = w_BGT | w_BGTZ; 
	assign and1_out = or1_out & ~(ALU_zero)& ~(CtrlBranch); 
	assign and2_out = or2_out & ALU_zero & ~(CtrlBranch);
	assign and3_out = or3_out & ~(ALU_negative) & ~(CtrlBranch) ;
	assign and4_out = or4_out & ALU_negative & ~(CtrlBranch);
	assign pc_enable = PcWrite | and1_out | and2_out | and3_out | and4_out;
	
	// decode stage assignment 
	
	// determine the first source register based on instruction type
	assign Rs1_mux_input = ( opcode < 3)?  IR_output[8:6]:   // R-type
	( (opcode >= 8 &&  opcode <= 11 && Mbit == 0) || (opcode >= 3 &&  opcode <= 5 ) || opcode == 7)? IR_output[7:5]:
	( opcode >= 8 &&  opcode <= 11 && Mbit == 1)? 3'b000: IR_output[11:9]; // I-type, S-type
						
	assign Rs2_mux_input =( opcode == SW)? IR_output[10:8]: IR_output[5:3]; // second source register
	assign Rd_mux_input =  ( opcode < 3)?  IR_output[11:9]:  IR_output[10:8]; // first case for R type and second one for I type
	assign jump_offset = IR_output[11:0];
	assign Itype_imm = IR_output[4:0];
	assign Stype_imm = {IR_output[8]?8'b1:8'b0,IR_output[8:1]}; 
	
	// assign branch and jump target offsets
	assign branch_shifter_output = extender_output << 1;
	assign j_target_address =  {pc_output[15:13], jump_offset << 1};
	
	// invoke modules and connect wires to them	
	
	// pc module
	DFF PC (.clock(clk), .D(pc_input), .Q(pc_output), .EN(pc_enable));   
	
	// instruction memory
	instructionMemory IM (.Address(pc_output), .Instruction(IM_output)); 
	
    // instruction register
	DFF IR (.clock(clk), .D(IM_output), .Q(IR_output), .EN(IRwrite)); 
	
	// rs1 selection mux
	mux_2 Rs1_selection ( .a(Rs1_mux_input), .b(7), .s(CtrlRet), .y(regFile_rs1));  
	
	// rs2 selection mux
	mux_2 Rs2_selection ( .a(Rs2_mux_input), .b(Rd_mux_input), .s(CtrlBranch), .y(regFile_rs2)); 
	
	// rd selection mux
	mux_2 Rd_selection ( .a(Rd_mux_input), .b(7), .s(RegDst), .y(regFile_rd)); 
	
	
	// register file write data mux
	
	mux_4 regWrite_data_selection (.a(ALU_buffer_output), .b(WB_buffer_output), .c(ALU_output), .d(0),.s1(MemToReg[1]), .s0(MemToReg[0]),.y(regFile_write_data)); 
	
	
	// extender
	sign_extension extender (.out(extender_output), .in(Itype_imm), .ExtOpM(ExtOp)); 
	
    // register file
	RegisterFile regFile (.ReadRegister1(regFile_rs1), 
	.ReadRegister2(regFile_rs2), 
	.WriteRegister(regFile_rd), 
	.WriteData(regFile_write_data),
	.RegWrite(RegWrite),
	.Clk(clk), 
	.ReadData1(regFile_out1),
	.ReadData2(regFile_out2)); 
	
	
	
	// register file buffer	
	DFF first_operand_reg (.clock(clk), .D(regFile_out1), .Q(regFile_buffer_out1), .EN(1));	// operand 1
	DFF second_operand_reg (.clock(clk), .D(regFile_out2), .Q(regFile_buffer_out2), .EN(1)); // operand 2
	
	//AluSrcA mux
	mux_2 Alu_src_A_selection (.a(pc_output), .b(regFile_buffer_out1), .s(AluSrcA), .y(ALU_in_A));
	
	//AluSrcB mux
	mux_5 Alu_src_B_selection (.a(regFile_buffer_out2), .b(2), .c(extender_output), .d(branch_shifter_output), .e(16'b0), .s2(AluSrcB[2]), .s1(AluSrcB[1]), .s0(AluSrcB[0]), .y(ALU_in_B));
	
	// mem data src mux
	mux_2 mem_data_src_selection (.a(regFile_buffer_out2), .b(Stype_imm), .s(MemDataSrc), .y(data_memory_input_data));
	
	//ALU
	ALU alu (.A(ALU_in_A),
	.B(ALU_in_B),
	.AluOp(AluOp),
	.Output(ALU_output),
	.zero_flag(ALU_zero),
	.negative_flag(ALU_negative));
	
	// ALU output buffer
	DFF ALU_output_buffer (.clock(clk), .D(ALU_output), .Q(ALU_buffer_output), .EN(1));
	
	// Data memory
	DataMemory data_memory (.Address(ALU_buffer_output), 
	.MemWrite(MemWrite), 
	.MemRead(MemRead), 
	.Clk(clk), 
	.CTRLBW(CtrlBW), 
	.CTRLM(CtrlM),
	.WriteData(data_memory_input_data),
	.Data(data_memory_output));	 
	
	//writeBack register
	DFF WB_register (.clock(clk), .D(data_memory_output), .Q(WB_buffer_output), .EN(1));
	
	//PcSrc mux
	mux_4 pcSrc_selection (.a(ALU_output), 
	.b(ALU_buffer_output), 
	.c(j_target_address), 
	.d(regFile_buffer_out1),
	.s1(PcSource[1]), .s0(PcSource[0]),
	.y(pc_input)); 
	
	// control unit
	Control_unit control_unit (.Clk(clk),
	.opcode(opcode),
	.mbit(Mbit),
	.PcWrite(PcWrite),
	.MemRead(MemRead),
	.MemWrite(MemWrite),
	.IRwrite(IRwrite),
	.RegDst(RegDst),
	.MemToReg(MemToReg),
	.RegWrite(RegWrite),
	.AluSrcA(AluSrcA),
	.AluSrcB(AluSrcB),
	.AluOp(AluOp),
	.PcSource(PcSource),
	.CtrlBranch(CtrlBranch),
	.ExtOp(ExtOp),
	.MemDataSrc(MemDataSrc),	
	.CtrlBW(CtrlBW),
	.CtrlM(CtrlM),
	.CTRLRET(CtrlRet));
				 			  
						
endmodule 	
