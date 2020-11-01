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

module ALU32Bit(ALUControl, A, B, regWrite, rs, LogicalOffset, ALUResult, Zero, MultResult, HI_in, LO_in);

	input [4:0] ALUControl; 	// Control bits for ALU operation
    input [4:0] rs, LogicalOffset;                            // you need to adjust the bitwidth as needed
	input [31:0] A, B, HI_in, LO_in;	 
	input regWrite;   	// Inputs
	
    
	output reg [31:0] ALUResult;	// 32 bit outputs
	output reg Zero;	
	
	reg [31:0] RegOutput;
	
	output reg [63:0] MultResult;	
	
    initial begin
        MultResult = 0;
    end

    always @ (ALUControl, A, B) begin
		Zero <= 1;

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
			5'b00100: begin   // srl and rotr
			case (rs)
			     5'b00001: ALUResult <= (B >> LogicalOffset) | (B << (32 - LogicalOffset));
			     5'b00000: ALUResult <= B >> LogicalOffset;
			endcase 		
            end
			
			5'b11110: begin   // srlv and rotrv
			case (LogicalOffset)
			     5'b00001: ALUResult <=  B >> A | B << (32 - A);
			     5'b00000: ALUResult <= B >> A;
			endcase 		
            end
			// MULTIPLICATION -> MUL, MULT, MULTU		
			5'b00101: begin // mult
			 MultResult <= $signed(A) * $signed(B);
			
            end
            5'b11000: begin // mul
                MultResult <= A * B;
            end
            5'b01100: begin // MULTU
			 MultResult <= $unsigned(A) * $unsigned(B);
            end
			// SUBTRACTION, BEQ, BNE          
			5'b00110: begin  
					ALUResult[31:0] <= A - B;	 
				  end 

			// SET LESS THAN, BLTZ, BGEZ,  
			5'b00111: ALUResult <= ($signed(A) < $signed(B)) ? 1 : 0; // check to make sure this is right
			
			//SLTIU, SLTU 
			5'b11001: ALUResult <= ($unsigned(A) < $unsigned(B)) ? 1 : 0;
			
//			5'b11100: ;


			// NOR 		 
			5'b01000: begin
					ALUResult <= ~(A | B);	
				  end

			// XOR, XORI        
			5'b01001: begin 
					ALUResult[31:0] <= A ^ B;	
				  end 
            5'b11111:  ALUResult <= ((B >> LogicalOffset) & {32{~B[31]}}) | (~(~B >> LogicalOffset) & {32{B[31]}}); //sra
            5'b01010: ALUResult <= ((B >> A) & {32{~B[31]}}) | (~(~B >> A) & {32{B[31]}});

//			// DIVIDE                            
//			5'b01011: begin						
//					ALUResult <= A / B;	// quotient
//					HIReg <= A % B;	// remainder
//				  end 

			// MADD         
			5'b11010: begin 
			MultResult = {HI_in, LO_in} + (A * B);
            end
			// MSUB         
			5'b01101: begin 
			MultResult = {HI_in, LO_in} - (A * B);
            end

			// MOVZ         
			5'b01110: begin 
			     ALUResult <= A; 
			     Zero <= (B == 0);
            end
			// MOVN         
			5'b01111: begin
			      ALUResult <= A; 
			     Zero <= ~(B == 0);
            end
			// MFHI           
			5'b10000: ALUResult <= HI_in;

			// MTHI              
			5'b10001: MultResult[63:32] <= A;

			// MFLO
			5'b10010: begin 
			     ALUResult <= LO_in;
			     end

			// MTLO
			5'b10011: MultResult[31:0] <= A;

			// LUI
			5'b10100: begin						
					ALUResult[31:16] <= B[15:0];
					ALUResult[15:0] <= 16'b0;
				  end 

			// SEB -> which is faster, concatenating or assigning?         
			// SEH                 
			5'b10110: begin		
			case (LogicalOffset)
			     5'b11000: ALUResult = { {16{B[15]}}, B[15:0] };
			     5'b10000: ALUResult = { {24{B[7]}}, B[7:0] };
			endcase				
		    end 
		endcase
		
		
	end
	
	
endmodule
