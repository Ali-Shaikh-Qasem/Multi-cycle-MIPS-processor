
module sign_extension(out,in,ExtOpM);

    output  [15:0] out;
    input   [4:0] in;
    input ExtOpM;
	reg [15:0] out;

    always@(in,ExtOpM)
	 begin
		if (ExtOpM == 0) 
			out <= {11'b00000000000 , in};
		 else if (in[4] == 1)
			 out <= {11'b11111111111, in};
			else 
			 out <= in;
	 end
endmodule