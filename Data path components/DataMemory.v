module DataMemory(Address,MemWrite,MemRead,Clk,CTRLBW,CTRLM,WriteData,Data);
	input [15:0] Address,WriteData;
	input MemWrite,MemRead,Clk,CTRLBW,CTRLM;
	output reg [15:0] Data;
	
	reg [7:0] register[63:0];
				 
	
	initial
		begin
		register[0] = 8'h00;
		register[1] = 8'h08;
		register[2] = 8'h78;
		register[3] = 8'hF6;
		register[4] = 8'h82;
		register[5] = 8'h80;
		register[6] = 8'h90;
		register[7] = 8'hEC;
		register[8] = 8'h96;
		register[9] = 8'h8E;
		register[10] = 8'h07;
		register[11] = 8'h00;
		register[12] = 8'hA6;
		register[13] = 8'hA0;
		register[14] = 8'h02;
		register[15] = 8'h10;
		register[16] = 8'h76;
		register[17] = 8'hF0;
		register[18] = 8'h84;
		register[19] = 8'h16;
		register[20] = 8'hA8;
		register[21] = 8'h64;
		register[22] = 8'h68;
		register[23] = 8'h0E;
		register[24] = 8'hB6;
		register[25] = 8'h08;
		register[26] = 8'h8A;
		register[27] = 8'h84; 
		register[28] = 8'hE8;
		register[29] = 8'hE0;
		register[30] = 8'h14;
		register[31] = 8'h0;	 
		end	   
		//---------------------Read in Memory--------------------------------
		always@(negedge Clk)
			begin
				if(MemRead)	 
					if(CTRLBW) 
						if(CTRLM)  	   						//For LBu
							if(register[Address][7] == 1)
							Data <= {8'hff , register[Address]};
						    else 
							Data <= {8'h00 , register[Address]}; 
						else 
						   Data <= {8'h00 , register[Address]};
				     else 
					 	 Data <= {register[Address + 1], register[Address]};	 //for any 
			end	 
			
			
			 //---------------------Wtire in Memory--------------------------------
			always@(posedge Clk)
			begin
				if(MemWrite) 
					begin	 
					register[Address] <= WriteData[7:0];	 //Store the First Byte
					register[Address+1] <= WriteData[15:8]; 
					end
			end
		
endmodule
