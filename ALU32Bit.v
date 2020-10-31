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

module ALU32Bit(ALUControl, A, B, regWrite, rs, LogicalOffset, ALUResult, Zero, HI_Output, LO_Output);

	input [4:0] ALUControl; 	// Control bits for ALU operation
    input [4:0] rs, LogicalOffset;                            // you need to adjust the bitwidth as needed
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
			5'b00111: ALUResult <= ($signed(A) < $signed(B)) ? 1 : 0; // check to make sure this is right
			
			//SLTIU, SLTU 
			5'b11001: ALUResult <= ($unsigned(A) < $unsigned(B)) ? 1 : 0;
			
//			5'b11010: ;
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
		endcase

		if (ALUResult == 0) begin
			Zero <= 1;
		end
		
		
	end
	
	
endmodule
