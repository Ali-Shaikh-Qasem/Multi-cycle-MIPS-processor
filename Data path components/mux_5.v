module mux_5(a,b,c,d,e,s0,s1,s2,y);
    input [15:0] a, b, c, d, e;
    output reg [15:0] y;
    input s2, s1, s0;

    initial 
        y <= 0;

    always @(*) begin
        if (s2 == 0 && s1 == 0 && s0 == 0)
            y <= a;
        else if (s2 == 0 && s1 == 0 && s0 == 1)
            y <= b;
        else if (s2 == 0 && s1 == 1 && s0 == 0)
            y <= c;
        else if (s2 == 0 && s1 == 1 && s0 == 1)
            y <= d;
        else if (s2 == 1 && s1 == 0 && s0 == 0)
            y <= e;
        else
            y <= 16'b0;  // Default case
    end
endmodule
