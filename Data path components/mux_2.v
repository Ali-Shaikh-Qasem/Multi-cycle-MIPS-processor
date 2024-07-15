module mux_2(a,b,s,y);
	input [15:0] a,b;
	output [15:0]y;
	input s;
	
	assign y = (s)? b:a; //when s=1 y=b;when s=0 y=a 
	
	
	
endmodule