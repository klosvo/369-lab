`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2020 05:39:46 PM
// Design Name: 
// Module Name: ALUControl_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALUControl_tb();

	reg [1:0] ALUOp; 	// Control bits for ALU operation
	reg [5:0] funct;
	wire [4:0] ALUCtl;

    ALUControl aluCtrl(ALUOp, funct, ALUCtl);
    // Note: expected values have now changed - the expected values in the comments need to be updated
	initial begin
        // lw, sw, lb, sb, lh, sh - expect 00010
        #200 ALUOp <= 2'b00;	funct <= 6'b000000;
        
        // beq - expect 00110
        #200 ALUOp <= 2'b01;	funct <= 6'b0000000;
        
        // R-type
        #200 ALUOp <= 2'b10;
        
        // sll  6 - expect 00100
        funct <= 6'b000000;
        
        // srl  7 - expect 00101
        #200 funct <= 6'b000010;
        
        // sra - expect 00101
        #200 funct <= 6'b000011;
        
        // lui  25 - expect 10100
        #200 funct <= 6'b000100;
        
        // seb  26 - expect 10101
        #200 funct <= 6'b000101;
        
        // seh  27 - expect 10110
        #200 funct <= 6'b000110;
        
        // rotr, rotrv  14 - expect 01010
        #200 funct <= 6'b000111;
        
        // movz  19 - expect 00111
        #200 funct <= 6'b001010;
        
        // movn  20 - expect 01111
        #200 funct <= 6'b001011;
        
        // mfhi  21 - expect 10000
        #200 funct <= 6'b010000;
        
        // mthi  22 - expect 10001
        #200 funct <= 6'b010001;
        
        // mflo  23 - expect 10010
        #200 funct <= 6'b010010;
        
        // mtlo  24 - expect 10011
        #200 funct <= 6'b010011;
        
        // mult   8 - expect 00110
        #200 funct <= 6'b011000;
        
        // multu  9 - expect 00111
        #200 funct <= 6'b011001;
        
        // div    15 - expect 01011
        #200 funct <= 6'b011010;
        
        // divu   16 - expect 01100
        #200 funct <= 6'b011011;
        
        // add/addi	2 - expect 00010
        #200 funct <= 6'b100000;
        
        // addu/addiu  3 - expect 00011
        #200 funct <= 6'b100001;
        
        // sub 4 - expect 00110
        #200 funct <= 6'b100010;
        
        // subu 5 - expect 00110
        #200 funct <= 6'b100011;
       
       // and/andi 0 - expect 00000
        #200 funct <= 6'b100100;
        
        // or/ori  1 - expect 00001
        #200 funct <= 6'b100101;
        
        // xor/xori 13 - expect 01001
        #200 funct <= 6'b100110;
        
        // nor 12 - expect 01000
        #200 funct <= 6'b100111;
        
        // slt 10 - expect 00111
        #200 funct <= 6'b101010;
        
        // sltu 11 - expect 00111
        #200 funct <= 6'b101011;
        
        // madd 17 - expect 01100
        #200 funct <= 6'b101100;   
        
        // msub 18 - expect 01101
        #200 funct <= 6'b101101;
        
        //do nothing - expect 11111; //
        #200 ALUOp <= 2'b11;	funct <= 6'b000000;
    end
endmodule
