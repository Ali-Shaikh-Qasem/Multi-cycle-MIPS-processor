module mux_4(a,b,c,d,s0,s1,y);
	input [15:0] a,b,c,d;
	output reg [15:0]y;
	input s1,s0;
	
	always @(*)
	begin
		 if(s1==0 && s0==0)
			y<=a;		  
			
		else if(s1==0 && s0==1)	
			y<=b; 		
			
		else if(s1==1 && s0==0)	
			y<=c; 
			
		else	
		    y<=d;  
			
	end
	
	
endmodule