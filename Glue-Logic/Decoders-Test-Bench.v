/*
 * Test Bench for SPARC Decoders
 * Written by Johnny Sanchez - Github username:johnnyrsm
 *
 */

`include "Decoders.v"

module TestDecoder;

//***********************************
//	Inputs
//***********************************

reg [4:0] Ein5x32;
reg [1:0] Ein2x4;
reg Clk, Ld5x32, Ld2x4;

//***********************************
//	Outputs
//***********************************

wire [31:0] Eout5x32;
wire [3:0] Eout2x4;

//***********************************
//	Misc Parameters
//***********************************

parameter sim_time = 500;

Decoder_2x4	myDecoder2x4(Eout2x4, Ein2x4, Ld2x4);
Decoder_5x32	myDecoder5x32(Eout5x32, Ein5x32, Ld5x32);

initial #sim_time $finish;
	
initial begin
	Clk = 1'b0;
	forever #5 Clk = ~Clk;
end

initial fork

	Ein2x4 <= 2'b00;
	Ld2x4 = 1'b0;

	repeat (4) #5 Ein2x4 = Ein2x4 + 1'b1;
	#20 Ld2x4 = 1'b1;
	#20 repeat (8) #5 Ein2x4 = Ein2x4 + 1'b1;
	#50 Ld2x4 = 1'b0;



	#60 Ein5x32 <= 5'b00000;
	#60 Ld5x32 = 1'b0;

	#60 repeat (32) #5 Ein5x32 = Ein5x32 + 1'b1;
	#220 Ld5x32 = 1'b1;
	#220 repeat (48) #5 Ein5x32 = Ein5x32 + 1'b1;
	#410 Ld5x32 = 1'b0;
	

join

initial begin

	$display("Ein5x32\tEout5x32\tLd5x32\tEin2x4\tEout2x4\tLd2x4\t\tTime");
	$monitor("%b\t%h\t%b\t%b\t%b\t%b", Ein5x32, Eout5x32, Ld5x32, Ein2x4, Eout2x4, Ld2x4, $time);

end

endmodule
