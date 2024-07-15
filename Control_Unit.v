  `include "Parameters.v"
module Control_unit(Clk,opcode
	,mbit
	,PcWrite
	,MemRead
	,MemWrite
	,IRwrite
	,RegDst
	,MemToReg
	,RegWrite
	,AluSrcA
	,AluSrcB
	,AluOp,
	PcSource,
	CtrlBranch,	
	CTRLRET,
	ExtOp,
	MemDataSrc,
	CtrlBW,CtrlM);
	
	input wire[3:0]opcode;
	reg [2:0] N;
	input wire mbit,Clk;
	output reg PcWrite,
	MemRead,
	MemWrite,
	IRwrite,
	RegWrite,
	AluSrcA,
	CtrlBranch,
	ExtOp,
	MemDataSrc,	 
	CTRLRET,
	CtrlBW,
	CtrlM;
	output reg [1:0]RegDst,AluOp,PcSource,MemToReg;
	output reg [2:0]AluSrcB; 
	reg [2:0]Stage;
	/*
	Branch  = 3 cycles
	R-Type = 4 cycles
	Lw,Lbu,Lbs = 5 cycles
	I-Type = 4 cycles
	Jump = 2 Cycles
	CALL = 5 cycles
	RET = 3 cycles
	SW = 4 cycles
	SV = 4 cycles
	*/ 	  
	
	initial	 begin
		N = 3'b001;
		end

		
		//N For getting to next stage
		/*
		N == 1 means fetch stage.
		N == 2 means decode stage.
		N == 3 means execution stage.
		N == 4 means memory or write back stage.
		N == 5 means write on the memory stage.
		*/

	 always@(posedge Clk)
		begin 	 
			
			if(N  == Stage )
					N = 1; 
				else
					N = N + 1;  		
		end	 
			   
		
		always@(opcode or N)
		begin	
			
			
			case(opcode)  
				//Branch
				BGT: Stage = 3;
				BGTZ : Stage = 3;
				BLT: Stage = 3;
				BLTZ : Stage = 3;
				BEQ: Stage = 3;
				BEQZ : Stage = 3;
				BNE: Stage = 3;
				BNEZ : Stage = 3;
				//R-Ttype
				AND : Stage = 4;
				ADD: Stage = 4;
				SUB : Stage = 4;
				//I-Type
				ADDI : Stage = 4;
				ANDI: Stage = 4;
				//Lw,lbu,lbs
				LW : Stage =  5;
				LBu : Stage = 5;
				LBu : Stage = 5;
				//Sw,SV
			    SW : Stage = 4;
				SV : Stage = 4;
				//CALL
				CALL : Stage = 5;
				//RET
				RET : Stage = 3; 
				//jump
				JUMP: Stage = 2; 
				
				 default: N = 1;
				
			endcase
	
			//Boolean eqaution for each signal !!
			PcWrite =  (N==1) | ((N==2)&(opcode==JUMP)) |((N==3)&(opcode==RET))
			|((N==5)&(opcode==CALL)); 
			
			MemRead = (N==4) & ((opcode==LW) | (opcode==LBu)  | (opcode==LBs));	 
			
			MemWrite =  (N==4) & ((opcode == SW ) | (opcode == SV)) ;	 
			
			IRwrite =  (N==1) ;	
			
			RegDst =  (opcode == CALL) & (N==4) ; 
			
			MemToReg[0] =  (N==5) & ((opcode==LW)|(opcode==LBu)|(opcode==LBs));	
			MemToReg[1] =  (N==4) & (opcode==CALL);
			
		    RegWrite =  (N==4) & ((((opcode==AND) | (opcode==ADD) | (opcode==SUB)) 
			| ((opcode==ADDI) | (opcode==ANDI)) | (opcode==CALL))) | ((N==5)&((opcode==LW)
			|(opcode==LBu)|(opcode==LBs)));	
			
			AluSrcA = (((N==2)|(N==3)) & (opcode==CALL)) |(N==3)&(((opcode==BGT) |(opcode==BGTZ)
			|(opcode==BLT)|(opcode==BEQ)|(opcode==BEQZ)|(opcode==BNE)|(opcode==BNEZ))
			|((opcode==AND) | (opcode==ADD) | (opcode==SUB)) 
			| ((opcode==LW)|(opcode==LBu)|(opcode==LBs)
			|(opcode==SW)|((opcode==ADDI) | (opcode==ANDI)| (opcode==SV))));	 
			
			AluSrcB[0] = (N==1) | (((N==2) | (N==3)) & (opcode==CALL)) | ((N==2) & ((opcode==BGT) |(opcode==BGTZ)
			|(opcode==BLT)|(opcode==BEQ)|(opcode==BEQZ)|(opcode==BNE)|(opcode==BNEZ)));		
			
			AluSrcB[1] =  (N==2) & ((opcode==LW)|(opcode==LBu)|(opcode==LBs)
			|(opcode==SV)|(opcode==SW)|((opcode==ADDI) | (opcode==ANDI)) 
			| ((opcode==BGT) |(opcode==BGTZ)|(opcode==BLT)|(opcode==BEQ)
			|(opcode==BEQZ)|(opcode==BNE)|(opcode==BNEZ)))| 
			((N==3)&((opcode==LW)|(opcode==LBu)|(opcode==LBs)|(opcode==SW)
			|((opcode==ADDI) | (opcode==ANDI))));
			
			AluSrcB[2] =  (N==3) & (opcode==SV);	 
			
			AluOp[0] = (N==3) & ((opcode==SUB) | ((opcode==BGT) |(opcode==BGTZ)
			|(opcode==BLT)|(opcode==BEQ)|(opcode==BEQZ)|(opcode==BNE)|(opcode==BNEZ)));	
			
			AluOp[1] = (N==3) & ((opcode==AND) | (opcode==ANDI));
			
			PcSource[0] = (N==3) & ((opcode==RET) | ((opcode==BGT) |(opcode==BGTZ)
			|(opcode==BLT)|(opcode==BEQ)|(opcode==BEQZ)|(opcode==BNE)|(opcode==BNEZ)));
			
			PcSource[1]	=   ((N==2) & (opcode==JUMP)) |( (N==5) & (opcode==CALL)) | ((N==3)&(opcode==RET))  ;	 
			
			CtrlBranch =  (N==2) & ((opcode==BGT) |(opcode==BGTZ)
			|(opcode==BLT)|(opcode==BEQ)|(opcode==BEQZ)|(opcode==BNE)|(opcode==BNEZ));
			
			ExtOp = (N==3) & ((opcode==LW)|(opcode==LBu)|(opcode==LBs)
			|(opcode==SW)|(opcode==SV)|(opcode==ADDI)) 
			| (N==2) & ((opcode==JUMP)|((opcode==BGT) |(opcode==BGTZ)
			|(opcode==BLT)|(opcode==BEQ)|(opcode==BEQZ)
			|(opcode==BNE)|(opcode==BNEZ))) | (N==5)&(opcode==CALL);   
			
			MemDataSrc = (N==4) & (opcode==SV);	  
			
			
	     	CTRLRET =  (N==2)&(opcode==RET);
			
			CtrlBW = (N==4) & ((opcode==LBu)|(opcode==LBs));   
			
			CtrlM = (N==4) & mbit & (opcode==LBu);  
		end

		
endmodule