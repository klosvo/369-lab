`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 64-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
// 
// The 'ALUResult' will output the corresponding result of the operation 
// based on the 32-Bit inputs, 'A', and 'B'. 
// The 'Zero' flag is high when 'ALUResult' is '0'. 
// The 'ALUControl' signal should determine the function of the ALU 
// You need to determine the bitwidth of the ALUControl signal based on the number of 
// operations needed to support. 
//
// Op|'ALUControl' value | Description | Notes
// ==========================
// AND, ANDI            			| 00000 | ALUResult = A and B
// OR, ORI, SEB, SEH    			| 00001 | ALUResult = A or B
// ADDITION, lw, sw, lb, sb, lh, sh     	| 00010 | ALUResult = A + B
// LEFT SHIFT, SLL, SLLV	    		| 00011 | ALUResult = A << B
// RIGHT SHIFT, SRL, SRLV, SRA, SRAV     	| 00100 | ALUResult = A >> B
// MULTIPLICATION, MUL, MULT, MULTU 		| 00101 | ALUResult = A * B
// SUBRACTION, BEQ, BNE       			| 00110 | ALUResult = A - B
// SET LESS THAN, BLTZ, BGEZ, SLTIU, SLTU  	| 00111 | ALUResult =(A < B)? 1:0
// NOR   					| 01000 | ALUResult = ~(A or B)
// XOR, XORI					| 01001 | ALUResult = A xor B
// ROTR, ROTRV					| 01010 | Rotate B Right
// DIVIDE					| 01011 | ALUResult = A / B
// MADD						| 01100 | ALUResult = ALUResult + A * B
// MSUB						| 01101 | ALUResult = ALUResult - A * B
// MOVZ						| 01110 | if (B == 0), ALUResult = A, else ALUResult = 0;
// MOVN						| 01111 | if (B == 0), ALUResult = 0, else ALUResult = A;
// MFHI						| 10000 | Move ALUResultHI into the lower 32 bits of ALUResult;
// MTHI						| 10001 | Move A into the upper 32 bits of ALUResult;
// MFLO						| 10010 | Move ALUResultLO into the lower 32 bits of ALUResult;
// MTLO						| 10011 | Move A into the lower 32 bits of ALUResult;
// LUI						| 10100 | Move lowest 16 bits of B into bits [31:16] of ALUResult;
// SEB						| 10101 | Move lowest 8 bits of B into lowest 8 bits of ALUResult;
// SEH						| 10110 | Move lowest 16 bits of B into lowest 16 bits of ALUResult; 
//
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [3:0] ALUControl; 	// Control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input [31:0] A, B;	    	// Inputs
    
	output reg [31:0] ALUResult;	// 32 bit outputs
	output reg Zero;	
	(* mark_debug = "true" *) wire [31:0] Debug_HI, Debug_LO; 
	
	reg [63:0] MultResult;

	reg [31:0] HIReg, LOReg;  
          		// Zero=1 if ALUResult == 0

    always @ (ALUControl, A, B) begin
		Zero <= 0;
		ALUResult = 32'h0; // ALUResult <= 32'h0;
		HIReg <= 0;
		LOReg <= 0;

		case(ALUControl)

			// AND, ANDI
			5'b00000: begin 
					ALUResult <= A & B;	
				  end 

			// OR, ORI, SEB, SEH???          
			5'b00001: begin
					ALUResult[31:0] <= A | B;	
				  end 

			// ADDITION, add, lw, sw, lb, sb, lh, sh         
			5'b00010: begin 
					ALUResult[31:0] <= A + B;	
				  end 

			// LEFT SHIFT, SLL, SLLV	
			5'b00011: ALUResult <= A << B;  		   

			// RIGHT SHIFT, SRL, SRLV, SRA, SRAV		 
			5'b00100: ALUResult <= A >> B;         		

			// MULTIPLICATION -> MUL, MULT, MULTU		
			5'b00101: begin
			 MultResult <= A * B;
			 ALUResult <= MultResult[31:0];
			 HIReg <= MultResult[63:32];	
            end
			// SUBTRACTION, BEQ, BNE          
			5'b00110: begin  
					ALUResult[31:0] <= A - B;	 
				  end 

			// SET LESS THAN, BLTZ, BGEZ, SLTIU, SLTU  
			5'b00111: ALUResult <= (A < B) ? 1'd1 : 64'b0; // check to make sure this is right

			// NOR 		 
			5'b01000: begin
					ALUResult[31:0] <= ~(A | B);	
				  end

			// XOR, XORI        
			5'b01001: begin 
					ALUResult[31:0] <= A ^ B;	
				  end 

			// ROTR, ROTRV         
			//5'b01010: ALUResult <= {32'b0, {B[A-1:0] | B[31:A]}}; // need to check   

			// DIVIDE                            
			5'b01011: begin						
					ALUResult <= A / B;	// quotient
					HIReg <= A % B;	// remainder
				  end 

			// MADD         
			5'b01100: ALUResult <= ALUResult + A * B; 

			// MSUB         
			5'b01101: ALUResult <= ALUResult - A * B;

			// MOVZ         
			5'b01110: ALUResult <= (B == 32'b0) ? A : 64'b0; // Need to double check that this performs as expected

			// MOVN         
			5'b01111: ALUResult <= (B == 32'b0) ? 64'b0 : A; // Need to double check that this performs as expected

			// MFHI           
			5'b10000: ALUResult <= {32'b0, ALUResult[63:32]};

			// MTHI              
			5'b10001: ALUResult[63:32] <= A;

			// MFLO
			5'b10010: ALUResult <= {32'b0, ALUResult[31:0]};

			// MTLO
			5'b10011: ALUResult[31:0] <= A;

			// LUI
			5'b10100: begin						
					ALUResult[31:16] <= B[15:0];
					ALUResult[15:0] <= 16'b0;
					ALUResult[63:32] <= 16'b0;
				  end 

			// SEB -> which is faster, concatenating or assigning?         
			5'b10101: begin						
					ALUResult[7:0] <= B[7:0];
					ALUResult[63:8] <= 56'b0;
				  end 

			// SEH                 
			5'b10110: begin						
					ALUResult[15:0] <= B[15:0];
					ALUResult[63:16] <= 48'b0;
				  end 
		endcase

        LOReg <= ALUResult;
		if (ALUResult == 0) begin
			Zero <= 1;
		end
		
		
	end
	
	assign Debug_LO = LOReg;
	assign Debug_HI = HIReg;
	
endmodule

