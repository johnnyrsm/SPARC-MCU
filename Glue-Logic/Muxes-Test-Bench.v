/*
 * Test Bench for SPARC Multiplexers
 * Written by Johnny Sanchez - Github username:johnnyrsm
 *
 */

`include "Muxes.v"

module TestMux;

//***********************************
//	Inputs
//***********************************

reg [31:0] In0, In1, In2, In3, In4, In5, In6, 
	In7, In8, In9, In10, In11, In12, In13, 
	In14, In15, In16, In17, In18, In19, In20, 
	In21, In22, In23, In24, In25, In26, In27, 
	In28, In29, In30, In31;

reg [4:0] S;

//***********************************
//	Outputs
//***********************************

wire [31:0] Out;

//***********************************
//	Misc Parameters
//***********************************

parameter sim_time = 500;

Mux32_32x1	myMux32x1(Out, In0, In1, In2, In3, In4, In5, 
			In6, In7, In8, In9, In10, In11, In12, 
			In13, In14, In15, In16, In17, In18, In19, 
			In20, In21, In22, In23, In24, In25, In26, 
			In27, In28, In29, In30, In31, S);

initial #sim_time $finish;

initial fork

	In0 <= 32'h00000001;
	In1 <= 32'h00000002;
	In2 <= 32'h00000004;
	In3 <= 32'h00000008;

	In4 <= 32'h00000010;
	In5 <= 32'h00000020;
	In6 <= 32'h00000040;
	In7 <= 32'h00000080;

	In8 <= 32'h00000100;
	In9 <= 32'h00000200;
	In10 <= 32'h00000400;
	In11 <= 32'h00000800;

	In12 <= 32'h00001000;
	In13 <= 32'h00002000;
	In14 <= 32'h00004000;
	In15 <= 32'h00008000;

	In16 <= 32'h00010000;
	In17 <= 32'h00020000;
	In18 <= 32'h00040000;
	In19 <= 32'h00080000;

	In20 <= 32'h00100000;
	In21 <= 32'h00200000;
	In22 <= 32'h00400000;
	In23 <= 32'h00800000;

	In24 <= 32'h01000000;
	In25 <= 32'h02000000;
	In26 <= 32'h04000000;
	In27 <= 32'h08000000;

	In28 <= 32'h10000000;
	In29 <= 32'h20000000;
	In30 <= 32'h40000000;
	In31 <= 32'h80000000;

	S = 5'b00000;

	repeat (32) #5 S = S + 1'b1;	
	
join


initial begin

	#1 $display("\nIn0:%h\nIn1:%h\nIn2:%h\nIn3:%h\n", In0, In1, In2, In3);
	#1 $display("\nIn4:%h\nIn5:%h\nIn6:%h\nIn7:%h\n", In4, In5, In6, In7);
	#1 $display("\nIn8:%h\nIn9:%h\nIn10:%h\nIn11:%h\n", In8, In9, In10, In11);
	#1 $display("\nIn12:%h\nIn13:%h\nIn14:%h\nIn15:%h\n", In12, In13, In14, In15);
	
	#1 $display("\nIn16:%h\nIn17:%h\nIn18:%h\nIn19:%h\n", In16, In17, In18, In19);
	#1 $display("\nIn20:%h\nIn21:%h\nIn22:%h\nIn23:%h\n", In20, In21, In22, In23);
	#1 $display("\nIn24:%h\nIn25:%h\nIn26:%h\nIn27:%h\n", In24, In25, In26, In27);
	#1 $display("\nIn28:%h\nIn29:%h\nIn30:%h\nIn31:%h\n", In28, In29, In30, In31);

	$monitor("\n----------------\n\nS:%b\n\nOut:%h\n\n----------------\n", S, Out);

end

endmodule
