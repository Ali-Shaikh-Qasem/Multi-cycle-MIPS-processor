//-----------------------------------------------------------------------------
//
// Title       : Register_file
// Design      : werwer
// Author      : a-ahmad2016@outlook.com
// Company     : Bierzet
//
//-----------------------------------------------------------------------------
//
// File        : C:/Users/a-ahm/Documents/Design/qweqwe/werwer/src/Register_file.v
// Generated   : Fri Jun 14 22:49:03 2024
// From        : Interface description file
// By          : ItfToHdl ver. 1.0
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

`timescale 1ps / 1ps

//{{ Section below this comment is automatically maintained
//    and may be overwritten
//{module {Register_file}}

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);

	input [2:0] ReadRegister1,ReadRegister2,WriteRegister;
	input [15:0] WriteData;
	input RegWrite,Clk;
	
	output reg [15:0] ReadData1,ReadData2;
	
	
	reg [15:0] Registers [0:7];
	
	initial begin
		Registers[0] <= 16'h0000;
		Registers[1] <= 16'h0005;
		Registers[2] <= 16'hF000;
		Registers[3] <= 16'h0007;
		Registers[4] <= 16'h0001;
		Registers[5] <= 16'h0006;
		Registers[6] <= 16'h0016;
		Registers[7] <= 16'h0027;
	end
	
	
	always @(posedge Clk)
	begin
		
		if (RegWrite == 1) 
		begin 
		 if(WriteRegister == 3'b0) 
			 Registers[0] <= 3'b0;
    	  else 
			Registers[WriteRegister] <= WriteData;
		end
	end
	
	always @(negedge Clk)
	begin
		ReadData1 <= Registers[ReadRegister1];
		ReadData2 <= Registers[ReadRegister2];
	end
	
	

endmodule
