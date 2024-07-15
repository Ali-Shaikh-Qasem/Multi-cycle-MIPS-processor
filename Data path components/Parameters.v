
parameter

// levels
    Zero = 1'b0,
    One = 1'b1,


// instruction types
 
    R_Type = 2'b00, 
    I_Type = 2'b01, 
    J_Type = 2'b10, 
    S_Type = 2'b11,

// instruction function code
// 5-bit instruction function code
								   	
    // R-Type Instructions
    AND = 4'b0000, // Reg(Rd) = Reg(Rs1) & Reg(Rs2)  Tested
    ADD = 4'b0001, // Reg(Rd) = Reg(Rs1) + Reg(Rs2)  Tested
    SUB = 4'b0010, // Reg(Rd) = Reg(Rs1) - Reg(Rs2)  Tested

    // I-Type Instructions
    ADDI = 4'b0011, // Reg(Rd) = Reg(Rs1) & Immediate5				 Tested
    ANDI = 4'b0100,// Reg(Rd) = Reg(Rs1) + Immediate5				Tested
    LW   = 4'b0101, // Reg(Rd) = Mem(Reg(Rs1) + Imm_5)			   Tested
    LBu  = 4'b0110, // Reg(Rd) = Mem(Reg(Rs1) + Imm_5)			   Teseted
	LBs  = 4'b0110, // Reg(Rd) = Mem(Reg(Rs1) + Imm_5)				Tested
    SW   = 4'b0111, // Mem(Reg(Rs1) + Imm_15) = Reg(Rd)
	//if (Reg(Rd) > Reg(Rs1))Next PC = PC + sign_extended (Imm)
	//else PC = PC + 2	
     BGT  = 4'b1000, 											//	 Tested
	//if (Reg(Rd) > Reg(R0))Next PC = PC + sign_extended (Imm)		
	//else PC = PC + 2	
	BGTZ  = 4'b1000,
	//if (Reg(Rd) < Reg(Rs1))Next PC = PC + sign_extended (Imm)
	//else PC = PC + 2
	BLT  = 4'b1001,												 //Tested
	//if (Reg(Rd) < Reg(R0))Next PC = PC + sign_extended (Imm)
	//else PC = PC + 2
	BLTZ  = 4'b1001, 											  //Tested
	//if (Reg(Rd) == Reg(Rs1))Next PC = PC + sign_extended (Imm) 
	//else PC = PC + 2												Tested
	BEQ  = 4'b1010, 
	//if (Reg(Rd) == Reg(R0))Next PC = PC + sign_extended (Imm) 
	//else PC = PC + 2
	BEQZ  = 4'b1010, 											//Tested
	//if (Reg(Rd) != Reg(Rs1))Next PC = PC + sign_extended (Imm)  
	//else PC = PC + 2
	BNE   =	4'b1011,  
	//if (Reg(Rd) != Reg(R0))Next PC = PC + sign_extended (Imm)  
    //else PC = PC + 2
	BNEZ   =4'b1011,
																  //Tested
    // J-Type Instructions
    JUMP    = 4'b1100, // Next PC = {PC[15:13], Immediate}			 Tested
	//Next PC = {PC[15:10], Immediate} PC + 4 is saved on r15
    CALL  = 4'b1101,											// Tested
	//Next PC = r7
	RET  = 4'b1110, 											//Tested
    // S-Type Instructions
    SV  = 4'b1111, // M[rs] = imm								Tested


// ALU function code signal
// 2-bit chip-select for ALU

    ALU_Add = 2'b00, // used in ADD, ADDI, LW, SW
    ALU_Sub = 2'b01, // used in SUB, branches
    ALU_And = 2'b10, // used in AND, ANDI


// PC source signal
// 2-bit source select for next PC value

    PC_Src_2 = 2'b00, // PC = PC + 2
    PC_Src_buff  = 2'b01, // return address from ALU buffer
    PC_Src_Jmp = 2'b10, // jump address
    PC_Src_RET = 2'b11, // RET target address

// ALUSRCB
// 3-bit source select for next PC value
    ALU_Src_B = 3'b000, // Operand B
    ALU_Src_2  = 3'b001, // Operand equals 2
    PC_Src_sext = 3'b010, // Sign extend 
    ALU_Src_shift = 3'b011, // shift Sign extend
    ALU_Src_ZERO = 3'b100, // Zero


// 8 registers
    R0 = 3'd0, // zero register
    R1 = 3'd1, // general purpose register
    R2 = 3'd2, // general purpose register
    R3 = 3'd3, // general purpose register
    R4 = 3'd4, // general purpose register
    R5 = 3'd5, // general purpose register
    R6 = 3'd6, // general purpose register
    R7 = 3'd7; // general purpose register	
	
	