`include "Parameters.v"
module ALU ( A, B, AluOp, Output, zero_flag, negative_flag);
	
	//define inputs
	input [15:0] A, B;
	input [1:0] AluOp;
    //define outputs 
	output reg [15:0] Output;
	output reg zero_flag, negative_flag;
	
	// output flags logic
	assign zero_flag = (Output == 0);
	assign negative_flag = (Output[15] == 1); 	
	
	// perfrm ALU operations
	always @(*) 
	  begin
		case (AluOp)
			ALU_Add:  Output <= A + B;
			ALU_Sub:  Output <= A - B;
			ALU_And:  Output <= A & B;
			default: Output <= 0;
		endcase
	  end 
	  
endmodule  

// --------------------------------- Test Bench ------------------------------------------ //	  

module ALU_test_bench ();																			

	// define inputs and outputs
    reg [15:0] A, B; 
	reg [1:0] sig_alu_op;
    wire [15:0] Output;
    wire flag_zero;
    wire flag_negative;

  


    ALU a(A, B, sig_alu_op, Output, flag_zero, flag_negative);
	

    initial begin

        #0
        A <= 16'd5;
        B <= 16'd3;
        sig_alu_op <= ALU_Add;

        #10
        $display("(%0t) > %0d + %0d => Output=%0d | zero_flag=%0b | negative_flag=%0b", $time, A, B, Output, flag_zero, flag_negative);

        A <= 16'd30;
        B <= 16'd20;
        sig_alu_op <= ALU_Sub;

        #10
        $display("(%0t) > %0d - %0d => Output=%0d | zero_flag=%0b | negative_flag=%0b", $time, A, B, Output, flag_zero, flag_negative);

        A <= 16'hF;
        B <= 16'hA;
        sig_alu_op <= ALU_And;

        #10
  		$display("(%0t) > %0b & %0b => Output=%0b | zero_flag=%0b | negative_flag=%0b", $time, A, B, $signed(Output), flag_zero, flag_negative);   
		  
        A <= 16'd50;
        B <= 16'd100;
        sig_alu_op <= ALU_Sub;

        #10
        $display("(%0t) > %0d - %0d => Output=%0d | zero_flag=%0b | negative_flag=%0b", $time, A, B, $signed(Output), flag_zero, flag_negative); 
		
		A <= 16'd14;
        B <= 16'd14;
        sig_alu_op <= ALU_Sub;

        #10
        $display("(%0t) > %0d - %0d => Output=%0d | zero_flag=%0b | negative_flag=%0b", $time, A, B, $signed(Output), flag_zero, flag_negative);


        #5 $finish;
    end

endmodule