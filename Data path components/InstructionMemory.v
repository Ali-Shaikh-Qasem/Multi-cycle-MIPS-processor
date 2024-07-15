 `include "parameters.v"
module instructionMemory(Address,Instruction);
	input [15:0]Address;	
	output  [15:0] Instruction;
	reg [7:0] register[63:0]; 	  //Byte addressable memory
	
	
	
	assign Instruction = {register[Address+1],register[Address]}; 
	
	initial
		begin
			
			// --------R-type Test-------------------//
		/*
        register[0] <= {2'b10, R1,3'b000};
        register[1] <= {AND,R3,1'b0};
        register[2] <= {2'b10, R3,3'b000};
        register[3] <= {ADD,R4,1'b0};
        register[4] <= {2'b10, R4,3'b000};
        register[5] <= {SUB,R5,1'b0};
        register[6] <= {3'b001, 5'b00001};
        register[7] <= {RET,1'b0, 3'b010 };
        register[8] <= {3'b001, 5'b00001};
		*/
		// ------------Call and return---------------//	 
		/*
		register[0] <= 0; 
        register[1] <= 0;
        register[2] <= {3'b000,5'b00110}; 
        register[3] <= {CALL,1'b0,3'b000};
        register[4] <= {R5,5'b01000};
        register[5] <= {BGTZ,1'b1,R4};
        register[6] <= {2'b10, R4,3'b000};
        register[7] <= {SUB,R5,1'b0};
        register[8] <= {3'b001, 5'b00001};
        register[9] <= {RET,1'b0, 3'b010 };
        register[10] <= {3'b001, 5'b00001};
        register[11] <= {RET,1'b0, 3'b001 };
        register[12] <=  {2'b10, R4,3'b000};;
        register[13] <=  {SUB,R5,1'b0};
        register[14] <= {3'b001, 5'b00001};
        register[15] <=  {RET,1'b0, 3'b001 };
        register[16] <=  {3'b001, 5'b00001};
        register[17] <=   {RET,1'b0, 3'b001 };
        register[18] <=   {3'b001, 5'b00001};
        register[19] <=  {BGT,1'b0, 3'b001 };
		
		*/  
		
			/*
			// ----------------------------- LOAD STORE programm ----------------------------------//
			
			// first instruction (STORE WORD) --> mem[2] = R0 =  5
	    register[0] <= { R1, 5'b00010 } ; 
		register[1] <= {SW, 1'b0, R0} ;
			// second instruction (LOAD WORD) --> R2 = mem[2] = 5
		register[2] <= {R1, 5'b00010  } ;
		register[3] <= { LW, 1'b0, R2} ;
		   // THIRD instruction (LBu) --> R3 = mem[6] = -3 (unsigned extended)
		register[4] <= { R1, 5'b00110 } ;
		register[5] <= {LBu, 1'b0, R3} ;
		   // THIRD instruction (LBs) --> R3 = mem[6] = -3 (signed extended)
		register[6] <= { R1, 5'b00110 } ;
		register[7] <= {LBs, 1'b1, R3} ;
		// first instruction (ADD) R1 = R2 + R3 = 3 + 5 = 8
		register[8] <= { 8'b10011000 } ; 
		register[9] <= {ADD, R1, 1'b0} ;
		// second instruction (SV) MEM[R1] = MEM[8] = 17 
		register[10] <= { 8'b00100010 }  ;
		register[11] <= {SV, R1, 1'b0} ;
		 
		// --------------------------------------------------------------------------------------- //
		  */
		
		/*
		// ----------------------------- I-type logic arithmetic programm ----------------------------------//
		
		// first instruction (ADDI) R3 = R1 + 5 = 3 + 5 = 8
		register[0] <= { R0, 5'b00101 } ; 
		register[1] <= {ADDI, 1'b1, R3} ;
		// second instruction (ANDI) R3 = R1 + 5 = 3 & 5 = 1
		register[2] <= { R0, 5'b00101 }  ;
		register[3] <= {ANDI, 1'b1, R3} ;
		*/	
		
		// -----------------------------  JUMP   programm ----------------------------------//
		  /*
		  register[0] <= { 4'h2, 4'h1 } ; 
		  register[1] <= {JUMP, 4'h2} ;
		  */
		
		// -----------------------------  SV  programm ----------------------------------//
		  /*
		// first instruction (ADD) R1 = R2 + R3 = 3 + 5 = 8
		register[0] <= { 8'b10011000 } ; 
		register[1] <= {ADD, R1, 1'b0} ;
		// second instruction (SV) MEM[R1] = MEM[8] = 17 
		register[2] <= { 8'b00100010 }  ;
		register[3] <= {SV, R1, 1'b0} ;
		*/
		
		//----------------------BLT------------------------------------//
		/*
        Registers[0] <= 16'h0000;
        Registers[1] <= 16'h0005;
        Registers[2] <= 16'h0009;
        Registers[3] <= 16'h0007;
        Registers[4] <= 16'h0001;
        Registers[5] <= 16'h0006;
        Registers[6] <= 16'h0016;
        Registers[7] <= 16'h0027;

        register[0] <= 0; 
        register[1] <= 0;
        register[2] <= {R3,5'b01000};     //Not taken
        register[3] <= {BLT,1'b0,R2};
        register[4] <= {R5,5'b01000};
        register[5] <= {BLT,1'b1,R4};   // taken

		 */


      //-------------------------------BGTZ------------------------------------// 
	  /*
        Registers[0] <= 16'h0000;
        Registers[1] <= 16'h0005;
        Registers[2] <= 16'hF000;
        Registers[3] <= 16'h0007;
        Registers[4] <= 16'h0001;
        Registers[5] <= 16'h0006;
        Registers[6] <= 16'h0016;
        Registers[7] <= 16'h0027;


	 */	
        register[0] <= 0; 
        register[1] <= 0;
        register[2] <= {R3,5'b01000};      //Not taken
        register[3] <= {BGTZ,1'b1,R2};
        register[4] <= {R5,5'b01000};
        register[5] <= {BGTZ,1'b1,R4};    // taken	  
	
	
		register[20] <= 8'h00 ;
		register[21] <= 8'h00 ;
		register[22] <= 8'h00 ;
		register[23] <= 8'h00 ;
		register[24] <= 8'h00 ;
		register[25] <= 8'h00 ;
		register[26] <= 8'h00 ;
		register[27] <= 8'h00 ; 
		register[28] <= 8'h00 ;
		register[29] <= 8'h00 ;
		register[30] <= 8'h00 ;
		register[31] <= 8'h00 ;	 
		end	   
	
			
		
		
endmodule