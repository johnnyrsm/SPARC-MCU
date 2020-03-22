/*
 * Verilog module for 32-Bit ALU based on SPARC Architecture.
 * Written by Johnny Sanchez - Github username:johnnyrsm
 */


//*************************************
//	Instruction Format
//*************************************

/*
	Bits		Value
*	31-30 		op
*	29-25 		rd
*	24-19 		op3
*	18-14 		rs1
*	13 		0
*	12-5 		00000000
*	4-0 		rs2

	Bits		Value
*	31-30 		op
*	29-25 		rd
*	24-19 		op3
*	18-14 		rs1
*	13 		1
*	12-0 		simm13

*/

//*************************************
//	OpCode definitions
//*************************************

//*************************************
//	Basic Arithmetic
//	Instructions
//*************************************

`define ADD 			6'b000000		//rd <=	rs1 + (rs2 or simm13)
`define ADDCC 			6'b010000		//rd <=	rs1 + (rs2 or simm13), modify icc
`define ADDX 			6'b001000		//rd <=	rs1 + (rs2 or simm13) + Carry
`define ADDXCC 			6'b011000		//rd <=	rs1 + (rs2 or simm13) + Carry, modify	icc
`define SUB 			6'b000100		//rd <=	rs1 - (rs2 or simm13)
`define SUBCC 			6'b010100		//rd <=	rs1 - (rs2 or simm13), modify icc
`define SUBX 			6'b001100		//rd <=	rs1 - (rs2 or simm13) - Carry
`define SUBXCC 			6'b011100		//rd <=	rs1 - (rs2 or simm13) - Carry, modify icc

//************************************
//	Logical
//	Instructions
//************************************

`define AND 			6'b000001		//rd <=	rs1 bitwise AND	(rs2 or	simm13)
`define ANDCC 			6'b010001		//rd <=	rs1 bitwise AND	(rs2 or simm13), modify	icc
`define ANDN 			6'b000101		//rd <=	rs1 bitwise AND	(NOT(rs2 or simm13))
`define ANDNCC 			6'b010101		//rd <=	rs1 bitwise AND	(NOT(rs2 or simm13)), modify icc
`define OR 			6'b000010		//rd <=	rs1 bitwise OR (rs2 or simm13)
`define ORCC 			6'b010010		//rd <=	rs1 bitwise OR (rs2 or simm13),	modify icc
`define ORN 			6'b000110		//rd <=	rs1 bitwise OR (NOT(rs2	or simm13))
`define ORNCC 			6'b010110		//rd <=	rs1 bitwise OR (NOT(rs2	or simm13)),	modify	icc
`define XOR 			6'b000011		//rd <=	rs1 bitwise XOR (rs2 or simm13)
`define XORCC 			6'b010011		//rd <=	rs1 bitwise XOR	(rs2 or simm13), modify	icc
`define XORN 			6'b000111		//rd <=	rs1 bitwise XNOR (rs2 or simm13)
`define XORNCC 			6'b010111		//rd <=	rs1 bitwise XNOR (rs2 or simm13), modify icc

//************************************
//	Shift Instructions
//************************************

`define SLL 			6'b100101		//shift	left logical rs1 count positions
`define SRL 			6'b100110		//shift	right logical rs1 count positions
`define SRA 			6'b100111		//shift	right arithmetic rs1 count positions rd = MSB of rs1)

//***********************************
//	Load/Store
//	Instructions
//***********************************

`define LSB 			6'b001001		//Load sign byte
`define LDSH 			6'b001010		//Load sign halfword
`define LD 			6'b001000		//Load word
`define LDUB 			6'b000001		//Load unsigned	byte
`define LDUH 			6'b000010		//Load unsigned	halfword
`define LDD 			6'b000011		//Load double
`define STB 			6'b000101		//Store	byte
`define STH 			6'b000110		//Store	halfword
`define ST 			6'b000100		//Store	word
`define STD 			6'b000111		//Store	double


module ALU(output reg [31:0] Out, output reg C, N, V, Z, input [31:0] A, B, input [5:0] OpCode, input Cin);
always@(OpCode, A, B)
begin
        case(OpCode)
//-----------------------------------
//---Basic-Arithmetic-Instructions---
//-----------------------------------

        `ADD:
        begin
                Out = A + B;
        end

        `ADDCC:
        begin
                Out = A + B;
                N = Out[31];

                if(A + B > 32'hFFFFFFFF)
                        C = 1'b1;
                else
                        C = 1'b0;

                if(Out == 0)
                        Z = 1'b1;
                else
                        Z = 1'b0;

                if((A[31] == B[31]) && (A[31] != Out[31]))
                        V = 1'b1;
                else
                        V = 1'b0;
	end

	`ADDX:
	begin
		Out = A + B + Cin;
	end
	
	`ADDXCC:
	begin
		Out = A + B + Cin;
                N = Out[31];

                if(A + B + Cin > 32'hFFFFFFFF)
                        C = 1'b1;
                else
                        C = 1'b0;

                if(Out == 0)
                        Z = 1'b1;
                else
                        Z = 1'b0;

                if((A[31] == B[31]) && (A[31] != Out[31]))
                        V = 1'b1;
                else
                        V = 1'b0;
	end

	`SUB:
	begin
		Out = A - B;
	end

	`SUBCC:
	begin
		Out = A - B;
		N = Out[31];

		if(B > A)
                        C = 1'b1;
                else
                        C = 1'b0;

                if(Out == 0)
                        Z = 1'b1;
                else
                        Z = 1'b0;

                if((A[31] != B[31]) && (A[31] != Out[31]))
                        V = 1'b1;
                else
                        V = 1'b0;

	end
	
	`SUBX:
	begin
		Out = A - B - Cin;
	end

	`SUBXCC:
	begin
		Out = A - B - Cin;
		N = Out[31];

                if(B > A)
                        C = 1'b1;
                else
                        C = 1'b0;

                if(Out == 0)
                        Z = 1'b1;
                else
                        Z = 1'b0;

                if((A[31] != B[31]) && (A[31] != Out[31]))
                        V = 1'b1;
                else
                        V = 1'b0;

	end

//-----------------------------
//---Logical-Instructions------
//-----------------------------
	
	`AND:
	begin
		Out = A & B;
	end

	`ANDCC:
	begin
		Out = A & B;
		N = Out[31];

                if(Out == 0)
                        Z = 1'b1;
                else
                        Z = 1'b0;
		
		C = ~Z;
		V = 0;
		
	end
	
	`ANDN:
	begin
		Out = A & (~B);
	end

	`ANDNCC:
	begin
		Out = A & (~B);
		N = Out[31];

                if(Out == 0)
                        Z = 1'b1;
                else
                        Z = 1'b0;
		
		C = ~Z;
		V = 0;
		
	end
	
	`OR:
	begin
		Out = A | B;
	end

	`ORCC:
	begin
		Out = A | B;
		N = Out[31];

                if(Out == 0)
                        Z = 1'b1;
                else
                        Z = 1'b0;
               
                C = ~Z;
                V = 0;
              
	end

	`ORN:
	begin
		Out = A | (~B); 
	end

	`ORNCC:
	begin
		Out = A | (~B);
		N = Out[31];

                if(Out == 0)
                        Z = 1'b1;
                else
                        Z = 1'b0;
               
                C = ~Z;
                V = 0;
                
	end

	`XOR:
	begin
		Out = A ^ B; 
	end
	
	`XORCC:
	begin
		Out = A ^ B;
		N = Out[31];

                if(Out == 0)
                        Z = 1'b1;
                else
                        Z = 1'b0;
                
                C = ~Z;
                V = 0;
                
	end

	`XORN:
	begin
		Out = A ^ (~B);
	end

	`XORNCC:
	begin
		Out = A ^ (~B);
		N = Out[31];

                if(Out == 0)
                        Z = 1'b1;
                else
                        Z = 1'b0;
                
                C = ~Z;
                V = 0;
                
	end

//--------------------------
//---Shift-Instructions-----
//--------------------------

	`SLL:
	begin
		Out = A << (B & 32'h0000001F);
                N = Out[31];
 
                if(Out == 0)
                        Z = 1'b1;
                else
                        Z = 1'b0;
                 
                C = ~Z;
                V = 0;  
	end
		
	`SRL:
	begin
		Out = A >> (B & 32'h0000001F);
                N = Out[31];

                if(Out == 0)
                        Z = 1'b1;
                else
                        Z = 1'b0;
                
                C = ~Z;
                V = 0;  
	end

	`SRA:
	begin
		Out = A >>> (B & 32'h0000001F);
                N = Out[31];

                if(Out == 0)
                        Z = 1'b1;
                else
                        Z = 1'b0;
                 
                C = ~Z;
                V = 0;  
	end

//------------------------------
//---Load/Store-Instructions----
//------------------------------

/*
 * Load instructions produce an Effective
 * Address from the sum of its operands
 */
	`LSB:
	begin
		Out = A + B;		
	end

	`LDSH:
	begin
		Out = A + B;
	end

	`LD:
	begin
		Out = A + B;
	end

	`LDUB:
	begin
		Out = A + B;
	end

	`LDUH:
	begin
		Out = A + B;
	end

	`LDD:
	begin
		Out = A + B;
	end

/*
 * Store instructions produce an Effective
 * Address from the sum of its operands
 */
	`STB:
	begin
		Out = A + B;
	end

	`STH:
	begin
		Out = A + B;
	end
	
	`ST:
	begin
		Out = A + B;
	end

	`STD:
	begin
		Out = A + B;
	end
	
	endcase

end
endmodule
