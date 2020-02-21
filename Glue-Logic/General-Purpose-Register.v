/*
 * Verilog module for 32-Bit General Purpose Register based on SPARC Architecture.
 * Written by Johnny Sanchez - Github username:johnnyrsm
 */


//*****************************
//	Register Module
//*****************************
module Register_32Bits(output reg [31:0] Q, input [31:0] D, input Clk, Clr, Le);
always@(posedge Clk, Clr) 
begin
if(Clr) //Asynchronous clear
        Q <= 32'h00000000;
else if(Le) //Synchronous Load Enable
        Q <= D;
else
        Q <= Q;
end
endmodule
