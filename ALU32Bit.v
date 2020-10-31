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
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
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

module ALU32Bit(ALUControl, A, B, regWrite, LogicalOffset, ALUResult, Zero, HI_Output, LO_Output);

	input [4:0] ALUControl; 	// Control bits for ALU operation

    input [4:0] LogicalOffset;                            // you need to adjust the bitwidth as needed
	input [31:0] A, B;	 
	input regWrite;   	// Inputs
	
    
	output reg [31:0] ALUResult;	// 32 bit outputs
	output reg Zero;	
	
	reg [31:0] RegOutput;
	
	reg [63:0] MultResult;
	
	
	reg [31:0] HI_Input, LO_Input;
	output wire [31:0] HI_Output, LO_Output;
	
	HiLoRegs hilo(HI_Input, LO_Input, regWrite, HI_Output, LO_Output);
	
    initial begin
        MultResult = 0;
    end

    always @ (ALUControl, A, B) begin
		Zero <= 0;
		HI_Input <= HI_Output;
		LO_Input <= LO_Output;


		case(ALUControl)
			// AND, ANDI
			5'b00000: begin 
					ALUResult <= A & B;	
					
				  end 

			// OR, ORI          
			5'b00001: begin
					ALUResult[31:0] <= A | B;
						
				  end 

			// ADDITION, add, lw, sw, lb, sb, lh, sh         
			5'b00010: begin 
			        ALUResult = $signed(A) + $signed(B);
				  end 
				  
		    // addu
            5'b10111: begin
                ALUResult = $unsigned(A) + $unsigned(B);
            end
			// LEFT SHIFT, SLL	
			5'b00011: begin
			     ALUResult = B << LogicalOffset;
			end
			5'b11101: ALUResult <= B << A;	   

			// RIGHT SHIFT, SRL, SRLV, SRA, SRAV		 
			5'b00100: ALUResult <= B >> LogicalOffset; 
			5'b11110: ALUResult <= B >> A;        		

			// MULTIPLICATION -> MUL, MULT, MULTU		
			5'b00101: begin // mult
			 MultResult <= $signed(A) * $signed(B);
			 #5;
			 HI_Input <= MultResult[63:32];
			 LO_Input <= MultResult[31:0];
            end
            5'b11000: begin // mul
                MultResult <= A * B;
                #5;
                ALUResult <= MultResult[31:0];
            end
            5'b01100: begin // MULTU
			 MultResult <= $unsigned(A) * $unsigned(B);
			 #5;
			 HI_Input <= MultResult[63:32];
			 LO_Input <= MultResult[31:0];
            end
			// SUBTRACTION, BEQ, BNE          
			5'b00110: begin  
					ALUResult[31:0] <= A - B;	 
				  end 

			// SET LESS THAN, BLTZ, BGEZ,  
			5'b00111: ALUResult <= ($signed(A) < $signed(B)) ? 1'd1 : 64'b0; // check to make sure this is right
			
			//SLTIU, SLTU 
			5'b11110: ALUResult <= ($unsigned(A) < $unsigned(B)) ? 1'd1 : 64'b0;

			// NOR 		 
			5'b01000: begin
					ALUResult <= ~(A | B);	
				  end

			// XOR, XORI        
			5'b01001: begin 
					ALUResult[31:0] <= A ^ B;	
				  end 

			// ROTR, ROTR 
			     
			5'b01010: ALUResult <= {((B << LogicalOffset) >> LogicalOffset) | ((B >> LogicalOffset) << LogicalOffset)}; // need to check   
			
			 5'b11100: ALUResult <= {((B << A) >> A) | ((B >> A) << A)}; // ROTRV


//			// DIVIDE                            
//			5'b01011: begin						
//					ALUResult <= A / B;	// quotient
//					HIReg <= A % B;	// remainder
//				  end 

			// MADD         
			5'b01100: begin 
			MultResult = {HI_Output, LO_Output} + A * B;
			#5;
			LO_Input = MultResult [31:0];
			HI_Input = MultResult [63:32];
            end
			// MSUB         
      
			5'b01101: begin 
			MultResult = {HI_Output, LO_Output} - A * B;
			#5;
			LO_Input = MultResult [31:0];
			HI_Input = MultResult [63:32];
            end

			// MOVZ         
			5'b01110: ALUResult <= (B == 32'b0) ? A : 64'b0; // Need to double check that this performs as expected

			// MOVN         
			5'b01111: ALUResult <= (B == 32'b0) ? 64'b0 : A; // Need to double check that this performs as expected

			// MFHI           
			5'b10000: ALUResult <= HI_Output;

			// MTHI              
			5'b10001: HI_Input <= A;

			// MFLO
			5'b10010: begin 
			     ALUResult <= LO_Output;
			     end

			// MTLO
			5'b10011: LO_Input <= A;

			// LUI
			5'b10100: begin						
					ALUResult[31:16] <= B[15:0];
					ALUResult[15:0] <= 16'b0;
				  end 

			// SEB -> which is faster, concatenating or assigning?         
			5'b10101: begin						
					ALUResult[7:0] <= B[7:0];
					ALUResult[31:8] <= 56'b0;
				  end 

			// SEH                 
			5'b10110: begin						
					ALUResult[15:0] <= B[15:0];
					ALUResult[31:16] <= 48'b0;
				  end 
			
			//NOP	  
			5'b11111: begin						
					ALUResult <= 64'b0;
				  end 
		endcase

		if (ALUResult == 0) begin
			Zero <= 1;
		end
		
		
	end
	
	
endmodule

