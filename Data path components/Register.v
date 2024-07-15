module DFF(clock,D,Q,EN);
	input clock;   
	input EN;
	input [15:0]D;	  
	
		output reg [15:0]Q; 	
		initial
			Q=0;
		
			always @(posedge clock) // perform actions whenever the clock rises	  
				if(EN)
					Q = D;//Blocking assignment will do nothing here!!
endmodule