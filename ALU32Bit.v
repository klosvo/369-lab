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
// ADDITION       | 0000 | ALUResult = A + B
// SUBRACTION     | 0001 | ALUResult = A - B
// MULTIPLICATION | 0010 | ALUResult = A * B        (see notes below)
// AND            | 0011 | ALUResult = A and B
// OR             | 0100 | ALUResult = A or B
// SET LESS THAN  | 0101 | ALUResult =(A < B)? 1:0  (see notes below)
// SET EQUAL      | 0110 | ALUResult =(A=B)  ? 1:0
// SET NOT EQUAL  | 0111 | ALUResult =(A!=B) ? 1:0
// LEFT SHIFT     | 1000 | ALUResult = A << B       (see notes below)
// RIGHT SHIFT    | 1001 | ALUResult = A >> B	    (see notes below)
// COUNT ONES     | 1010 | ALUResult = A CLO        (see notes below)
// COUNT ZEROS    | 1011 | ALUResult = A CLZ        (see notes below)
//
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero, HI_Output, LO_Output);

	input [4:0] ALUControl; 	// Control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input [31:0] A, B;	    	// Inputs
	
    
	output reg [31:0] ALUResult;	// 32 bit outputs
	output reg Zero;	
	
	reg [31:0] RegOutput;
	
	reg [63:0] MultResult;
	reg regWrite;
	
	reg [31:0] HI_Input, LO_Input;
	output wire [31:0] HI_Output, LO_Output;
	
	HiLoRegs hilo(HI_Input, LO_Input,regWrite, HI_Output, LO_Output);
	
    initial begin
        MultResult = 0;
        regWrite = 0;
    end

    always @ (ALUControl, A, B) begin
		Zero <= 0;
		HI_Input <= HI_Output;
		LO_Input <= LO_Output;
		regWrite = 0;

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
			 regWrite = 1;
			 MultResult <= A * B;
			 #5;
			 HI_Input <= MultResult[63:32];
			 LO_Input <= MultResult[31:0];
            end
			// SUBTRACTION, BEQ, BNE          
			5'b00110: begin  
					ALUResult[31:0] <= A - B;	 
				  end 

			// SET LESS THAN, BLTZ, BGEZ, SLTIU, SLTU  
			5'b00111: ALUResult <= (A < B) ? 1'd1 : 64'b0; // check to make sure this is right

			// NOR 		 
			5'b01000: begin
					ALUResult <= ~(A | B);	
				  end

			// XOR, XORI        
			5'b01001: begin 
					ALUResult[31:0] <= A ^ B;	
				  end 

			// ROTR, ROTRV         
			//5'b01010: ALUResult <= {32'b0, {B[A-1:0] | B[31:A]}}; // need to check   

//			// DIVIDE                            
//			5'b01011: begin						
//					ALUResult <= A / B;	// quotient
//					HIReg <= A % B;	// remainder
//				  end 

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
			5'b10010: begin 
			     ALUResult <= LO_Output;
			     end

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

		if (ALUResult == 0) begin
			Zero <= 1;
		end
		
		
	end
	
	
endmodule

