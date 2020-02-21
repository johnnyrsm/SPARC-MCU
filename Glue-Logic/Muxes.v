/*
 * Verilog module for 32-Bit Muxes based on SPARC Architecture.
 * Written by Johnny Sanchez - Github username:johnnyrsm
 */

//********************************
//	Multiplexer Modules
//********************************


/*
 * Each of the mux inputs is 32-Bits wide
 */
module Mux32_2x1(output reg [31:0] Out, input [31:0] A, B, input S);
always@(S,A,B)
begin
        if(S)
                Out = B;
        else
                Out = A;
end
endmodule


/*
 * Each of the mux inputs is 32-Bits wide
 */
module Mux32_4x1(output reg [31:0] Out, input [31:0] A, B, C, D, input [1:0] S);
always@(S,A,B,C,D)
begin
        case(S)
		2'b00:
		        Out = A;
		2'b01:
		        Out = B;
		2'b10:
		        Out = C;
		2'b11:
		        Out = D;
        endcase
end
endmodule


/*
 * Each of the mux inputs is 32-Bits wide
 */
module Mux32_8x1(output [31:0] Out, input [31:0] In0, In1, In2, In3, In4, In5, In6, In7,
                input [2:0] S);
        wire [31:0] w1, w2;

        Mux32_4x1 MuxA(w1, In0, In1, In2, In3, S[1:0]);
        Mux32_4x1 MuxB(w2, In4, In5, In6, In7, S[1:0]);
        Mux32_2x1 MuxC(Out, w1, w2, S[2]);

endmodule


/*
 * Each of the mux inputs is 32-Bits wide
 */
module Mux32_32x1(output [31:0] Out, input [31:0] In0, In1, In2, In3,
        In4, In5, In6, In7, In8, In9, In10, In11, In12, In13, In14, In15, In16,
        In17, In18, In19, In20, In21, In22, In23, In24, In25, In26, In27, In28,
        In29, In30, In31, input [4:0] S);

        wire [31:0] w1, w2, w3, w4;

        Mux32_8x1 MuxA(w1, In0, In1, In2, In3, In4, In5, In6, In7, S[2:0]);
        Mux32_8x1 MuxB(w2, In8, In9, In10, In11, In12, In13, In14, In15, S[2:0]);
        Mux32_8x1 MuxC(w3, In16, In17, In18, In19, In20, In21, In22, In23, S[2:0]);
        Mux32_8x1 MuxD(w4, In24, In25, In26, In27, In28, In29, In30, In31, S[2:0]);

        Mux32_4x1 MuxE(Out, w1, w2, w3, w4, S[4:3]);

endmodule

