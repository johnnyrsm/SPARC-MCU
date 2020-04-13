/*
 * Test Bench for SPARC General Purpose Registers
 * Written by Johnny Sanchez - Github username:johnnyrsm
 *
 */

`include "General-Purpose-Register.v"

module TestRegister;

//***********************************
//	Inputs
//***********************************

reg [31:0] D;
reg Clk, Clr, Le;

//***********************************
//	Outputs
//***********************************

wire [31:0] Q;

//***********************************
//	Misc Parameters
//***********************************

parameter sim_time = 500;

Register_32Bits myReg(Q, D, Clk, Clr, Le);

initial #sim_time $finish;
	
initial begin
	Clk = 1'b0;
	forever #10 Clk = ~Clk;
end

initial fork

	D <= 32'hAAAAAAAA;
	#10 Le = 1'b1;
	#20 Le = 1'b0;

	#50 D <= 32'hABCDEF78;
	#100 Le = 1'b1;
	#110 Le = 1'b0;

	#150 Clr = 1'b1;
	#200 Clr = 1'b0;

	#210 Le = 1'b1;
	#220 Le = 1'b0;

	#250 D <= 32'h77777777;
	#260 Le = 1'b1;
	#270 D <= 32'hAAAAAAAA;	
	#300 Le = 1'b0;

join

initial begin

	$display("D       \tQ       \tClk\tClr\tLe\t\tTime");
	$monitor("%h\t%h\t%b\t%b\t%b", D, Q, Clk, Clr, Le, $time);

end

endmodule
