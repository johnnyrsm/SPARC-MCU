/*
 * Verilog module for Decoders used in SPARC Architecture.
 * Written by Johnny Sanchez - Github username:johnnyrsm
 */

//*****************************
//	Decoder Modules
//*****************************
module Decoder_5x32(output reg [31:0] Eout, input [4:0] Ein, input Ld);
always@(Ein)
	if(!Ld)
		Eout = 0;
	else
		case(Ein)
		5'b00000: 
			Eout = 32'h00000001;
		5'b00001: 
			Eout = 32'h00000002;
		5'b00010: 
			Eout = 32'h00000004;
		5'b00011: 
			Eout = 32'h00000008;

		5'b00100: 
			Eout = 32'h00000010;
                5'b00101:
			Eout = 32'h00000020;
                5'b00110: 
			Eout = 32'h00000040;
                5'b00111: 
			Eout = 32'h00000080;

		5'b01000: 
			Eout = 32'h00000100;
                5'b01001: 
			Eout = 32'h00000200;
                5'b01010: 
			Eout = 32'h00000400;
                5'b01011: 
			Eout = 32'h00000800;

                5'b01100:
			Eout = 32'h00001000;
                5'b01101:
			Eout = 32'h00002000;
                5'b01110:
			Eout = 32'h00004000;
                5'b01111:
			Eout = 32'h00008000;

		5'b10000:
			Eout = 32'h00010000;
                5'b10001:
			Eout = 32'h00020000;
                5'b10010:
			Eout = 32'h00040000;
                5'b10011:
			Eout = 32'h00080000;

                5'b10100:
			Eout = 32'h00100000;
                5'b10101:
			Eout = 32'h00200000;
                5'b10110:
			Eout = 32'h00400000;
                5'b10111:
			Eout = 32'h00800000;

                5'b11000:
			Eout = 32'h01000000;
                5'b11001:
			Eout = 32'h02000000;
                5'b11010:
			Eout = 32'h04000000;
                5'b11011:
			Eout = 32'h08000000;

                5'b11100:
			Eout = 32'h10000000;
                5'b11101:
			Eout = 32'h20000000;
                5'b11110:
			Eout = 32'h40000000;
                5'b11111:
			Eout = 32'h80000000;
	
		endcase
endmodule


module Decoder_2x4(output reg [3:0] Eout, input [1:0] Ein, input Ld);
always@(Ein)
        if(!Ld)
                Eout = 0;
        else
                case(Ein)
		
		2'b00:
			Eout = 4'b0001; 
		2'b01:
			Eout = 4'b0010;
		2'b10:
			Eout = 4'b0100;
		2'b11:
			Eout = 4'b1000;
		endcase
endmodule
