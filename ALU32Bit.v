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
// AND, ANDI            			     | 00000 | ALUResult = A and B
// OR, ORI, SEB, SEH    			     | 00001 | ALUResult = A or B
// ADDITION, lw, sw, lb, sb, lh, sh      | 00010 | ALUResult = A + B
// ADDITION, ADDU, ADDUI                 | 00011 | ALUResult = A + B
// SUBRACTION, BEQ, BNE       			 | 00100 | ALUResult = A - B
// SUBRACTION, SUBU       			     | 00101 | ALUResult = A - B
// LEFT SHIFT, SLL, SLLV	    		 | 00110 | ALUResult = A << B
// RIGHT SHIFT, SRL, SRLV, SRA, SRAV     | 00111 | ALUResult = A >> B
// MULTIPLICATION, MUL, MULT 		     | 01000 | ALUResult = A * B
// MULTIPLICATION, MULTU 		         | 01001 | ALUResult = A * B
// SET LESS THAN, BLTZ, BGEZ  	         | 01010 | ALUResult =(A < B)? 1:0
// SET LESS THAN, SLTIU, SLTU  	         | 01011 | ALUResult =(A < B)? 1:0
// NOR   					             | 01100 | ALUResult = ~(A or B)
// XOR, XORI					         | 01101 | ALUResult = A xor B
// ROTR, ROTRV					         | 01110 | Rotate B Right
// DIVIDE					             | 01111 | ALUResult = A / B
// DIVIDE, DIVU					         | 10000 | ALUResult = A / B
// MADD						             | 10001 | ALUResult = ALUResult + A * B
// MSUB						             | 10010 | ALUResult = ALUResult - A * B
// MOVZ						             | 10011 | if (B == 0), ALUResult = A, else ALUResult = 0;
// MOVN						             | 10100 | if (B == 0), ALUResult = 0, else ALUResult = A;
// MFHI						             | 10101 | Move ALUResultHI into the lower 32 bits of ALUResult;
// MTHI						             | 10110 | Move A into the upper 32 bits of ALUResult;
// MFLO						             | 10111 | Move ALUResultLO into the lower 32 bits of ALUResult;
// MTLO						             | 11000 | Move A into the lower 32 bits of ALUResult;
// LUI						             | 11001 | Move lowest 16 bits of B into bits [31:16] of ALUResult;
// SEB						             | 11010 | Move lowest 8 bits of B into lowest 8 bits of ALUResult;
// SEH						             | 11011 | Move lowest 16 bits of B into lowest 16 bits of ALUResult; 
//
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [4:0] ALUControl; 	// Control bits for ALU operation
	input [31:0] A, B;	    	// Inputs

	output reg [63:0] ALUResult = 64'h0000000000000000;	// 64 bit output
	output Zero;	    		// Zero=1 if ALUResult == 0
    assign Zero = (ALUResult == 64'h0000000000000000) ? 1 : 0; 
    
	always @(A, B, ALUControl) begin
		case(ALUControl)
			// AND, ANDI
			5'b00000: begin 
					ALUResult[31:0] <= A & B;	
					ALUResult[63:32] <= 0;
				  end 

			// OR, ORI          
			5'b00001: begin
					ALUResult[31:0] <= A | B;	
					ALUResult[63:32] <= 0;
				  end 

			// ADDITION, add, addi, lw, sw, lb, sb, lh, sh         
			5'b00010: begin 
					ALUResult <= $signed(A) + $signed(B);	
					//ALUResult[63:32] <= 0;
				  end 

			// ADDITION, addu, addui   
			5'b00011: begin 
					ALUResult[31:0] <= $unsigned(A) + $unsigned(B);	
					ALUResult[63:32] <= 0;
				  end 

			// SUBTRACTION, SUB, BEQ, BNE          
			5'b00100: begin  
					ALUResult[31:0] <= $signed(A-B);	 
					ALUResult[63:32] <= 0;
				  end 
			// SUBTRACTION, SUBU       
			5'b00101: begin  
					ALUResult[31:0] <= $unsigned(A - B);	 
					ALUResult[63:32] <= 0;
				  end

			// LEFT SHIFT, SLL, SLLV	
			5'b00110: ALUResult <= A << B;  		   

			// RIGHT SHIFT, SRL, SRLV, SRA, SRAV		 
			5'b00111: ALUResult <= A >> B;         		

			// MULTIPLICATION -> MUL, MULT	
			5'b01000: ALUResult <= $signed(A) * $signed(B);	

			// MULTIPLICATION -> MULTU
			5'b01001: ALUResult <= $unsigned(A) * $unsigned(B);	

			// SET LESS THAN, BLTZ, BGEZ  
			5'b01010: ALUResult <= ($signed(A) < $signed(B)) ? 1'd1 : 64'b0;

			// SET LESS THAN, SLTIU, SLTU
			5'b01011: ALUResult <= ($unsigned(A) < $unsigned(B)) ? 1'd1 : 64'b0; 

			// NOR 		 
			5'b01100: begin
					ALUResult[31:0] <= ~(A | B);	
					ALUResult[63:32] <= 0;
				  end

			// XOR, XORI        
			5'b01101: begin 
					ALUResult[31:0] <= A ^ B;	
					ALUResult[63:32] <= 0;
				  end 

			// ROTR, ROTRV      
			5'b01110: ALUResult <= {32'b0, {(B >> A) | (B << (32 - A))}};

			// DIVIDE, DIV                           
			5'b01111: begin					
					ALUResult[31:0] <= $signed(A) / $signed(B);	// quotient
					ALUResult[63:32] <= $signed(A) % $signed(B);	// remainder
				  end 
			
			// DIVIDE, DIVU                 
			5'b10000: begin					
					ALUResult[31:0] <= $unsigned(A) / $unsigned(B);	// quotient
					ALUResult[63:32] <= $unsigned(A) % $unsigned(B);	// remainder
				  end 
			
			// MADD         
			5'b10001: ALUResult <=  $signed(ALUResult) + $signed(A) * $signed(B); 

			// MSUB         
			5'b10010: ALUResult <= $signed(ALUResult) - $signed(A) * $signed(B);

			// MOVZ         
			5'b10011: ALUResult <= (B == 32'b0) ? A : 64'b0;

			// MOVN         
			5'b10100: ALUResult <= (B == 32'b0) ? 64'b0 : A;

			// MFHI           
			5'b10101: ALUResult <= {32'b0, ALUResult[63:32]};    //does this need to have an input HI? or is it supposed to be the hi of ALUResult

			// MTHI              
			5'b10110: ALUResult[63:32] <= A;

			// MFLO
			5'b10111: ALUResult <= {32'b0, ALUResult[31:0]};

			// MTLO
			5'b11000: ALUResult[31:0] <= A;

			// LUI
			5'b11001: begin						
					ALUResult[31:16] <= B[15:0];
					ALUResult[15:0] <= 16'b0;
					ALUResult[63:32] <= 16'b0;
				  end 

			// SEB -> which is faster, concatenating or assigning?         
			5'b11010: begin						
					ALUResult[7:0] <= B[7:0];
					ALUResult[63:8] <= 56'b0;
				  end 

			// SEH                 
			5'b11011: begin						
					ALUResult[15:0] <= B[15:0];
					ALUResult[63:16] <= 48'b0;
				  end 
			
			//NOP	  
			5'b11111: begin						
					ALUResult <= 64'b0;
				  end 
		endcase
	end
endmodule