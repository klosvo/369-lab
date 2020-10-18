`timescale 1ns / 1ps


//INCOMPLETE
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
////////////////////////////////////////////////////////////////////////////////

module ALUControl(ALUOp, funct, ALUCtl
);

	input [4:0] ALUOp; 	// Control bits for ALU operation
	input [5:0] funct;
	output reg [4:0] ALUCtl;
	

    always @ (ALUOp, funct) begin case (ALUOp)
            5'b00010:    // lw, sw, lb, sb, lh, sh
                begin
                    ALUCtl <= 5'b00010;  // add
                end  
//            2'b01:  // beq
//                begin
//                    ALUCtl <= 4'b0110;   // subtract 
//                end 
            5'b00000: // R-type
                begin
                    case(funct)
                          6'b000000: ALUCtl <= 5'b00011; // sll
//                        2'd02: ALUCtl <= 5'b00100; // srl
//                        2'd03: ALUCtl <= 5'b00100; // sra

//                        2'd04: ALUCtl <= 5'b10100; // lui
//                        2'd05: ALUCtl <= 5'b10101; // seb
//                        2'd06: ALUCtl <= 5'b10110; // seh

//                        2'd07: ALUCtl <= 5'b01010; // rotr, rotrv
//                        // 2'd08: ALUCtl <= 5'b10110; // rotrv

//                        2'd10: ALUCtl <= 5'b00111; // movz
//                        2'd11: ALUCtl <= 5'b01111; // movn  


//                        2'd16: ALUCtl <= 5'b10000; // mfhi
//                        2'd17: ALUCtl <= 5'b10001; // mthi 
                            6'b010010: ALUCtl <= 5'b10010; // mflo
//                        2'd19: ALUCtl <= 5'b10011; // mtlo

 
                            6'b011000: ALUCtl <= 5'b00101; // mult   
//                        // 2'd25: ALUCtl <= 5'b00101; // multu
//                        2'd26: ALUCtl <= 5'b01011; // div
//                        // 2'd27: ALUCtl <= 5'b01011; // divu  


                            6'b100000: ALUCtl <= 5'b00010; // add/addi	
//                        // 2'd33: ALUCtl <= 5'b00010; // addu/addiu  
                            6'b100010: ALUCtl <= 5'b00110; // sub
//                        // 2'd35: ALUCtl <= 5'b00110; // subu

                          6'b100100: ALUCtl <= 5'b00000; // and/andi
                          6'b100101: ALUCtl <= 5'b00001; // or/ori
                          6'b100110: ALUCtl <= 5'b01001; // xor
                          6'b100111: ALUCtl <= 5'b01000; // nor

                          6'b101010: ALUCtl <= 5'b00111; // slt
//                        // 2'd43: ALUCtl <= 5'b00111; // sltu 

//                        2'd44: ALUCtl <= 5'b01100; // madd
//                        2'd45: ALUCtl <= 5'b01101; // msub 
                    endcase
                end   
//            default: ALUCtl <= 1'd7; // do nothing?//should not happen
        endcase
    end
    
endmodule
