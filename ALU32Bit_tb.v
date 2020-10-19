`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [4:0] ALUControl;          // control bits for ALU operation
	reg [31:0] A, B;	          // inputs

	wire [63:0] ALUResult;	        // answer
	wire Zero;	                    // Zero=1 if ALUResult == 0

    
    ALU32Bit u0(ALUControl, A, B, ALUResult, Zero);

	initial begin
        
        //AND - working
        #200 ALUControl <= 5'b00000;	A <= 32'hFFFF0000;	B <= 32'h1000000F;
        #200 ALUControl <= 5'b00000;	A <= 32'hFFFFFFFF;	B <= 32'h00000001;
        #200 ALUControl <= 5'b00000;	A <= 32'hFFFFFFFF;	B <= 32'hFFFFFFFF;

		// OR, ORI - working         
        #200 ALUControl <= 5'b00001;	A <= 32'hFFFF0000;	B <= 32'h0000000F;
        #200 ALUControl <= 5'b00001;	A <= 32'hFFFFFFFF;	B <= 32'h00000001;
        #200 ALUControl <= 5'b00001;	A <= 32'hFFFFFFFF;	B <= 32'hFFFFFFFF;

		// ADDITION, add, addi, lw, sw, lb, sb, lh, sh   -working   
		//5'b00010
		#200 ALUControl <= 5'b00010;	A <= 32'hF00003E8;	B <= 32'h00000112;
        #200 ALUControl <= 5'b00010;	A <= 32'h00000112;	B <= 32'h000003E8;

		// ADDITION, addu, addui   - working (need overflow?) 
		//5'b00011
		#200 ALUControl <= 5'b00011;	A <= 32'hF00003E8;	B <= 32'h00000112;            
		#200 ALUControl <= 5'b00011;	A <= 32'hA0000112;	B <= 32'hA00003E8;

		// SUBTRACTION, SUB, BEQ, BNE       - problem with trial 3, all only work if radix is unsigned dec   
		//5'b00100
		#200 ALUControl <= 5'b00100;	A <= 32'hFFFF0000;	B <= 32'h0000000F;
		#200 ALUControl <= 5'b00100;	A <= 32'hF00003E8;	B <= 32'h00000112;            
		#200 ALUControl <= 5'b00100;	A <= 32'hA0000112;	B <= 32'hA00003E8;
		#200 ALUControl <= 5'b00100;	A <= 32'h00000008;	B <= 32'h00000004;

			
		// SUBTRACTION, SUBU       - problem with, some only work if radix is unsigned dec   
		// 5'b00101
        #200 ALUControl <= 5'b00101;	A <= 32'hFFFF0000;	B <= 32'h0000000F;
		#200 ALUControl <= 5'b00101;	A <= 32'hF00003E8;	B <= 32'h00000112;            
		#200 ALUControl <= 5'b00101;	A <= 32'hA0000112;	B <= 32'hA00003E8;
		
	
		// LEFT SHIFT, SLL, SLLV	- working
		// 5'b00110 	
		#200 ALUControl <= 5'b00110;	A <= 32'h0FFF0000;	B <= 32'h00000002;
		#200 ALUControl <= 5'b00110;	A <= 32'h000003E8;	B <= 32'h00000001;            
		#200 ALUControl <= 5'b00110;	A <= 32'h00000012;	B <= 32'h00000021;  	   

		// RIGHT SHIFT, SRL, SRLV, SRA, SRAV	-NEED TO CHECK	 
		// 5'b00111  
		#200 ALUControl <= 5'b00111;	A <= 32'h0FFF0000;	B <= 32'h00000002;
		#200 ALUControl <= 5'b00111;	A <= 32'h000003E8;	B <= 32'h00000001;            
		#200 ALUControl <= 5'b00111;	A <= 32'h00000012;	B <= 32'h00000021;      		

		// MULTIPLICATION -> MUL, MULT	-working
		// 5'b01000
		#200 ALUControl <= 5'b01000;	A <= 32'hFFFF0000;	B <= 32'h0000000F;
		#200 ALUControl <= 5'b01000;	A <= 32'hF00003E8;	B <= 32'h00000112;            
		#200 ALUControl <= 5'b01000;	A <= 32'hA0000112;	B <= 32'hA00003E8;

		// MULTIPLICATION -> MULTU      -working
		// 5'b01001
		#200 ALUControl <= 5'b01001;	A <= 32'hFFFF0000;	B <= 32'h0000000F;
		#200 ALUControl <= 5'b01001;	A <= 32'hF00003E8;	B <= 32'h00000112;            
		#200 ALUControl <= 5'b01001;	A <= 32'hA0000112;	B <= 32'hA00003E8;
			 
		// SET LESS THAN, BLTZ, BGEZ      -working
		// 5'b01010
		#200 ALUControl <= 5'b01010;	A <= 32'hFFFF0000;	B <= 32'h0000000F;
		#200 ALUControl <= 5'b01010;	A <= 32'h000000E8;	B <= 32'h00000112;            
		#200 ALUControl <= 5'b01010;	A <= 32'h00000112;	B <= 32'h00000112;
		#200 ALUControl <= 5'b01010;	A <= -1000;	B <= 32'h00000112;            
		#200 ALUControl <= 5'b01010;	A <= -32'h00000112;	B <= 32'h00000112;
			
		// SET LESS THAN, SLTIU, SLTU     -working
		// 5'b01011
		#200 ALUControl <= 5'b01011;	A <= 32'hFFFF0000;	B <= 32'h0000000F;
		#200 ALUControl <= 5'b01011;	A <= 32'h000000E8;	B <= 32'h00000112;            
		#200 ALUControl <= 5'b01011;	A <= 32'h00000112;	B <= 32'h00000112;
			
		// NOR 	    -working	 
		// 5'b01100
        #200 ALUControl <= 5'b01100;	A <= 32'hFFFF0000;	B <= 32'h1000000F;
        #200 ALUControl <= 5'b01100;	A <= 32'hFFFFFFFF;	B <= 32'h00000001;
        #200 ALUControl <= 5'b01100;	A <= 32'hFFFFFFFF;	B <= 32'hFFFFFFFF;
        #200 ALUControl <= 5'b01100;	A <= 32'h00000000;	B <= 32'h00000000;

		// XOR, XORI       -working 
		// 5'b01101
        #200 ALUControl <= 5'b01101;	A <= 32'hFFFF0000;	B <= 32'h1000000F;
        #200 ALUControl <= 5'b01101;	A <= 32'hFFFFFFFF;	B <= 32'h00000001;
        #200 ALUControl <= 5'b01101;	A <= 32'hFFFFFFFF;	B <= 32'hFFFFFFFF;
        #200 ALUControl <= 5'b01101;	A <= 32'h00000000;	B <= 32'h00000000;

		// ROTR, ROTRV     -working    
		//5'b01110:
		#200 ALUControl <= 5'b01110;	A <= 32'h00000002;	B <= 32'h1000000F;
        #200 ALUControl <= 5'b01110;	A <= 32'h00000018;	B <= 32'h00000001;
        #200 ALUControl <= 5'b01110;	A <= 32'h00000001;	B <= 32'hFFFFFFFF;
        #200 ALUControl <= 5'b01110;	A <= 32'h00000008;	B <= 32'h00000002;
        #200 ALUControl <= 5'b01110;	A <= 32'h00000009;	B <= 32'h00000002;

		// DIVIDE, DIV    -working                       
		// 5'b01111
        #200 ALUControl <= 5'b01111;	A <= 32'hFFFF0000;	B <= 32'h1000000F;
        #200 ALUControl <= 5'b01111;	A <= 32'hFFFFFFFF;	B <= 32'h00000001;
        #200 ALUControl <= 5'b01111;	A <= 32'hFFFFFFFF;	B <= 32'hFFFFFFFF;
        #200 ALUControl <= 5'b01111;	A <= 32'h00000008;	B <= 32'h00000002;
        #200 ALUControl <= 5'b01111;	A <= 32'h00000009;	B <= 32'h00000002;
			
		// DIVIDE, DIVU      -working           
		// 5'b10000
        #200 ALUControl <= 5'b10000;	A <= 32'hFFFF0000;	B <= 32'h1000000F;
        #200 ALUControl <= 5'b10000;	A <= 32'hFFFFFFFF;	B <= 32'h00000001;
        #200 ALUControl <= 5'b10000;	A <= 32'hFFFFFFFF;	B <= 32'hFFFFFFFF;
        #200 ALUControl <= 5'b10000;	A <= 32'h00000008;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10000;	A <= 32'h00000009;	B <= 32'h00000002;
			
		// MADD      -working   
		// 5'b10001
        #200 ALUControl <= 5'b10001;	A <= 32'h00000008;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10001;	A <= 32'h00000009;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10001;	A <= 32'h00000008;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10001;	A <= 32'h00000010;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10001;	A <= 32'h00000008;	B <= 32'h00000003;
        #200 ALUControl <= 5'b10001;	A <= -32'h00000009;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10001;	A <= 32'hFFFF0000;	B <= 32'h1000000F;
        #200 ALUControl <= 5'b10001;	A <= 32'hFFFFFFFF;	B <= 32'h00000001;
        
        
		// MSUB         -working
		// 5'b10010
        #200 ALUControl <= 5'b10010;	A <= 32'h00000008;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10010;	A <= 32'h00000009;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10010;	A <= 32'h00000008;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10010;	A <= 32'h00000010;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10010;	A <= 32'h00000008;	B <= 32'h00000003;
        #200 ALUControl <= 5'b10010;	A <= -32'h00000009;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10010;	A <= 32'hFFFF0000;	B <= 32'h1000000F;
        #200 ALUControl <= 5'b10010;	A <= 32'hFFFFFFFF;	B <= 32'h00000001;
        #200 ALUControl <= 5'b10010;	A <= 32'h00000008;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10010;	A <= 32'h00000009;	B <= 32'h00000002;

		// MOVZ         -working
		// 5'b10011
        #200 ALUControl <= 5'b10011;	A <= 32'h00000008;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10011;	A <= 32'h00000009;	B <= 32'h00000000;
        #200 ALUControl <= 5'b10011;	A <= 32'h00000008;	B <= 32'h00000000;
        #200 ALUControl <= 5'b10011;	A <= 32'h00000009;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10011;	A <= 32'hFFFF0000;	B <= 32'h00000000;
        #200 ALUControl <= 5'b10011;	A <= 32'hFFFFFFFF;	B <= 32'h00000000;

		// MOVN         -working
		// 5'b10100
        #200 ALUControl <= 5'b10100;	A <= 32'h00000008;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10100;	A <= 32'h00000009;	B <= 32'h00000001;
        #200 ALUControl <= 5'b10100;	A <= 32'h00000008;	B <= 32'h00000000;
        #200 ALUControl <= 5'b10100;	A <= 32'h00000009;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10100;	A <= 32'hFFFF0000;	B <= 32'h00000000;
        #200 ALUControl <= 5'b10100;	A <= 32'hFFFFFFFF;	B <= 32'h00000001;

		// MFHI           -working, but unsure i'm doing it right
		// 5'b10101
        #200 ALUControl <= 5'b10100;	A <= 32'h05550000;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10100;	A <= 32'hFFFF0000;	B <= 32'h00000001;
        #200 ALUControl <= 5'b01000;	A <= 32'hFFFFFFFF;	B <= 32'h00000002;
		#200 ALUControl <= 5'b01000;	A <= 32'hF00003E8;	B <= 32'h00000112;            
		#200 ALUControl <= 5'b01000;	A <= 32'hA0000112;	B <= 32'hA00003E8;
        
        // 5'b10101:
        #200 ALUControl <= 5'b10101;	A <= 32'h00000008;	B <= 32'h00000000;
        #200 ALUControl <= 5'b10101;	A <= 32'h00000009;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10101;	A <= 32'h0FFF0000;	B <= 32'h00000000;
        #200 ALUControl <= 5'b10101;	A <= 32'h0FFFFFFF;	B <= 32'h00000001;

		// MTHI              -working
		// 5'b10110
        #200 ALUControl <= 5'b10110;	A <= 32'h00000008;	B <= 32'h00000000;
        #200 ALUControl <= 5'b10110;	A <= 32'h00000009;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10110;	A <= 32'h0FFF0000;	B <= 32'h00000000;
        #200 ALUControl <= 5'b10110;	A <= 32'h0FFFFFFF;	B <= 32'h00000001;

		// MFLO             -working, but unsure i'm doing it right (should be lo register into A or B?
		// 5'b10111
        #200 ALUControl <= 5'b10100;	A <= 32'h05550000;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10100;	A <= 32'hFFFF0000;	B <= 32'h00000801;
        #200 ALUControl <= 5'b10111;	A <= 32'h00000008;	B <= 32'h00000000;
        #200 ALUControl <= 5'b10111;	A <= 32'h00000009;	B <= 32'h00000002;
        #200 ALUControl <= 5'b10111;	A <= 32'h0FFF0000;	B <= 32'h00000000;
        #200 ALUControl <= 5'b10111;	A <= 32'h0FFFFFFF;	B <= 32'h00000001;

		// MTLO             -working
		// 5'b11000
        #200 ALUControl <= 5'b11000;	A <= 32'h00000008;	B <= 32'h00000000;
        #200 ALUControl <= 5'b11000;	A <= 32'h00000009;	B <= 32'h00000002;
        #200 ALUControl <= 5'b11000;	A <= 32'h0FFF0000;	B <= 32'h00000000;
        #200 ALUControl <= 5'b11000;	A <= 32'h0FFFFFFF;	B <= 32'h00000001;

		// LUI          -working
		// 5'b11001
        #200 ALUControl <= 5'b11001;	A <= 32'h00000008;	B <= 32'hFFFFFFFF;
        #200 ALUControl <= 5'b11001;	A <= 32'h00000009;	B <= 32'h00007777;
        #200 ALUControl <= 5'b11001;	A <= 32'h0FFF0000;	B <= 32'h00000111;
        #200 ALUControl <= 5'b11001;	A <= 32'h0FFFFFFF;	B <= 32'h00005150;

		// SEB -> which is faster, concatenating or assigning?         -working
		// 5'b11010
        #200 ALUControl <= 5'b11010;	A <= 32'h00000008;	B <= 32'hFFFFFFFF;
        #200 ALUControl <= 5'b11010;	A <= 32'h00000009;	B <= 32'h00007777;
        #200 ALUControl <= 5'b11010;	A <= 32'h0FFF0000;	B <= 32'h00000111;
        #200 ALUControl <= 5'b11010;	A <= 32'h0FFFFFFF;	B <= 32'h00005150;
        
		// SEH                 -working
		// 5'b11011
        #200 ALUControl <= 5'b11011;	A <= 32'h00000008;	B <= 32'hFFFFFFFF;
        #200 ALUControl <= 5'b11011;	A <= 32'h00000009;	B <= 32'h00007777;
        #200 ALUControl <= 5'b11011;	A <= 32'h0FFF0000;	B <= 32'h00000111;
        #200 ALUControl <= 5'b11011;	A <= 32'h0FFFFFFF;	B <= 32'h00005150;        

        
        
//        #200 ALUControl <= 4'b1010;	A <= 32'b11111111111111111111111111110001;
//        #200 ALUControl <= 4'b1010;	A <= 32'b11111111111111111111111111111111;
//        #200 ALUControl <= 4'b1010;	A <= 32'b11000000000000000000000000000011;
//        #200 ALUControl <= 4'b1010;	A <= 32'b00000000000000000000000000000011;
        
//        #200 ALUControl <= 4'b1011;	A <= 32'b00000000000000000000000000000011;
//        #200 ALUControl <= 4'b1011;	A <= 32'b00001000000000000000000000000011;
//        #200 ALUControl <= 4'b1011;	A <= 32'b11000000000000000000000000000011;
//        #200 ALUControl <= 4'b1011;	A <= 0;
	end
endmodule

