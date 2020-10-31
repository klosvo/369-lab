`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
////////////////////////////////////////////////////////////////////////////////

module ALUControl(ALUOp, funct, SEH, ALUCtl,  HiLoWrite
);
    
	input [4:0] ALUOp; 	// Control bits for ALU operation
	input [5:0] funct;
	input [4:0] SEH;
	output reg [4:0] ALUCtl;
	output reg HiLoWrite;

    always @ (ALUOp, funct) begin 
            HiLoWrite <= 0;
            case (ALUOp)
            
            5'b00010:    // lw, sw, lb, sb, lh, sh
                begin
                    ALUCtl <= 5'b00010;  // add
                end  
            5'b00001: ALUCtl <= 5'b00000; // andi
            5'b00011: ALUCtl <= 5'b00001; // ori
            5'b00100: ALUCtl <= 5'b01001; // xori
            5'b00101: ALUCtl <= 5'b00111; // slti
            5'b00111: ALUCtl <= 5'b10111; // addui
            5'b01000: begin
                HiLoWrite <= 1;
                case(funct)
                    6'b000000: ALUCtl <= 5'b01100; //madd
                    6'b000010: ALUCtl <= 5'b11000; //mul
                    6'b000100: ALUCtl <= 5'b01101; //msub
                endcase
            end
            5'b01001: begin
                case (SEH)
                5'b10000:  ALUCtl <= 5'b10101; // seb
                5'b11000:  ALUCtl <= 5'b10110; // seh
                endcase
            end
            5'b00000: // R-type
                begin
                    case(funct)
                          6'b000000: ALUCtl <= 5'b00011; // sll
                          6'b000010: ALUCtl <= 5'b00100; // srl
                          6'b000011: ALUCtl <= 5'b11111; // sra

//                          2'd04: ALUCtl <= 5'b10100; // lui

                          6'b000100: ALUCtl <= 5'b11101; // sllv
                          6'b000110: ALUCtl <= 5'b11110; // srlv
                          6'b000111: ALUCtl <= 5'b01010; // srav

                            6'b001010: ALUCtl <= 5'b00111; // movz
                            6'b001011: ALUCtl <= 5'b01111; // movn  


                            6'b010000: ALUCtl <= 5'b10000; // mfhi
                            6'b010001: begin
                                HiLoWrite <= 1;
                                ALUCtl <= 5'b10001; // mthi 
                                end
                            6'b010010: ALUCtl <= 5'b10010; // mflo
                            6'b010011: begin
                                HiLoWrite <= 1;
                                ALUCtl <= 5'b10011; // mtlo
                                end

 
                            6'b011000: begin
                                HiLoWrite <= 1;
                                ALUCtl <= 5'b00101; // mult   
                                end
                            6'b011001: begin
                                HiLoWrite <= 1;
                                ALUCtl <= 5'b01100; // multu
                                end
//                        2'd26: ALUCtl <= 5'b01011; // div
//                        // 2'd27: ALUCtl <= 5'b01011; // divu  


                            6'b100000: ALUCtl <= 5'b00010; // add/addi	
                            6'b100001: ALUCtl <= 5'b10111; // addu/addiu  
                            6'b100010: ALUCtl <= 5'b00110; // sub
//                        // 2'd35: ALUCtl <= 5'b00110; // subu

                          6'b100100: ALUCtl <= 5'b00000; // and/andi
                          6'b100101: ALUCtl <= 5'b00001; // or/ori
                          6'b100110: ALUCtl <= 5'b01001; // xor
                          6'b100111: ALUCtl <= 5'b01000; // nor

                          6'b101010: ALUCtl <= 5'b00111; // slt
//                        // 2'd43: ALUCtl <= 5'b00111; // sltu 

                    endcase
                end   
//            default: ALUCtl <= 1'd7; // do nothing?//should not happen
        endcase
    end
    
endmodule

