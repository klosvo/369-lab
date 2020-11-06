`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
////////////////////////////////////////////////////////////////////////////////

module ALUControl(ALUOp, funct, SEH, ALUCtl,  HiLoWrite, MultBit
);
    
	input [4:0] ALUOp; 	// Control bits for ALU operation
	input [5:0] funct;
	input [4:0] SEH;
	output reg [4:0] ALUCtl;
	output reg HiLoWrite, MultBit;

    always @ (ALUOp, funct) begin 
            HiLoWrite <= 0;
            MultBit <= 0;
            case (ALUOp)
            
            5'b00010:    // lw, sw, lb, sb, lh, sh
                begin
                    ALUCtl <= 5'b00010;  // add
                end  
            5'b00001: ALUCtl <= 5'b00000; // andi
            5'b00011: ALUCtl <= 5'b00001; // ori
            5'b00100: ALUCtl <= 5'b01001; // xori
            5'b00101: ALUCtl <= 5'b00111; // slti
            5'b01011: ALUCtl <= 5'b11001; // sltiu
            5'b00111: ALUCtl <= 5'b10111; // addui
            5'b10100: ALUCtl <= 5'b10100; // lui
            5'b01000: begin
                case(funct)
                    6'b000000: begin
                       ALUCtl <= 5'b11010; //madd
                       HiLoWrite <= 1;
                    end
                    6'b000010: begin
                       ALUCtl <=  5'b11000; //mul
                       MultBit <= 1;
                    end
                    6'b000100: begin
                        ALUCtl <= 5'b01101; //msub
                        HiLoWrite <= 1;
                    end
                endcase
            end
            5'b01001: ALUCtl <= 5'b10110;
            5'b00000: // R-type
                begin
                    case(funct)
                          6'b000000: ALUCtl <= 5'b00011; // sll
                          6'b000010: ALUCtl <= 5'b00100; // srl
                          6'b000011: ALUCtl <= 5'b11111; // sra
                          6'b000100: ALUCtl <= 5'b11101; // sllv
                          6'b000110: ALUCtl <= 5'b11110; // srlv
                          6'b000111: ALUCtl <= 5'b01010; // srav
                          6'b001010: ALUCtl <= 5'b01110; // movz
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
                          6'b100000: ALUCtl <= 5'b00010; // add/addi  
                          6'b100001: ALUCtl <= 5'b10111; // addu/addiu  
                          6'b100010: ALUCtl <= 5'b00110; // sub
                          6'b100100: ALUCtl <= 5'b00000; // and/andi
                          6'b100101: ALUCtl <= 5'b00001; // or/ori
                          6'b100110: ALUCtl <= 5'b01001; // xor
                          6'b100111: ALUCtl <= 5'b01000; // nor
                          6'b101010: ALUCtl <= 5'b00111; // slt
                          6'b101011: ALUCtl <= 5'b11001; // sltu 
                    endcase
                end   
        endcase
    end
    
endmodule



//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//// ECE369 - Computer Architecture
//// 
//////////////////////////////////////////////////////////////////////////////////

//// module ALUControl(ALUOp, op, funct, ALUCtl);
//module ALUControl(ALUOp, funct, ALUCtl);

//	input [1:0] ALUOp; 	// Control bits for ALU operation
//	//input [5:0] op, funct;
//	input [5:0] funct;
//	output reg [4:0] ALUCtl;

//    always @ (ALUOp, op, funct)
//        case (ALUOp)
//            2'b00:  // lw, sw, lb, sb, lh, sh
//                begin
//                    ALUCtl <= 5'b00010;  // add
//                end  
//            2'b01:  // I-TYPE, beq
//                begin
//                    case(funct)
//                    //case(op)
//                        6'b001000: ALUCtl <= 5'b00010; // addi	2    (32)
//                        6'b001001: ALUCtl <= 5'b00010; // addiu	2    (32)
//                        6'b001100: ALUCtl <= 5'b00000; // andi 0    (36)
//                        6'b001101: ALUCtl <= 5'b00001; // ori  1     (37)
//                        6'b001110: ALUCtl <= 5'b01101; // xori 13   (38)
//                        6'b001111: ALUCtl <= 5'b11001; // lui  25 (4)
//                        6'b001010: ALUCtl <= 5'b01010; // slti 10    (42)
//                        6'b001011: ALUCtl <= 5'b01011; // sltiu 11   (43)
                        
//                        6'b000100: ALUCtl <= 5'b00100;   // beq = subtract
//                        6'b000001: ALUCtl <= 5'b00100;   // bgez, bltz = subtract 
//                        6'b000111: ALUCtl <= 5'b00100;   // bgtz = subtract 
//                        6'b000110: ALUCtl <= 5'b00100;   // blez = subtract 
//                        6'b000101: ALUCtl <= 5'b00100;   // bne = subtract 
//                    endcase
//                end    		                            
//            2'b10: // R-type
//                begin
//                    case(funct)
//                        6'b000000: ALUCtl <= 5'b00110; // sll  6 (0)
//                        6'b000010: ALUCtl <= 5'b00111; // srl  7 (2) 
//                        6'b000011: ALUCtl <= 5'b00111; // sra  7 (3)
                        
//                        6'b000101: ALUCtl <= 5'b11010; // seb  26 (5)
//                        6'b000110: ALUCtl <= 5'b11011; // seh  27    (6)
                        
//                        6'b000111: ALUCtl <= 5'b01110; // rotr, rotrv  14   (7)
//                        // 2'd08: ALUCtl <= 5'b10110; // rotrv
//                        //  6'b001000: ALUCtl <= 5'b01110; // jr

//                        6'b001010: ALUCtl <= 5'b10011; // movz  19   (10)
//                        6'b001011: ALUCtl <= 5'b10100; // movn  20   (11)
//                        6'b010000: ALUCtl <= 5'b10101; // mfhi  21   (16)
//                        6'b010001: ALUCtl <= 5'b10110; // mthi  22   (17)
//                        6'b010010: ALUCtl <= 5'b10111; // mflo  23   (18)
//                        6'b010011: ALUCtl <= 5'b11000; // mtlo  24   (19)
 
//                        6'b011000: ALUCtl <= 5'b01000; // mult   8   (24)
//                        6'b011001: ALUCtl <= 5'b01001; // multu  9   (25)
//                        6'b011010: ALUCtl <= 5'b01111; // div    15  (26)
//                        6'b011011: ALUCtl <= 5'b10000; // divu   16  (27)
                        
//                        6'b100000: ALUCtl <= 5'b00010; // add	2    (32)
//                        6'b100001: ALUCtl <= 5'b00011; // addu  3 (33)
//                        6'b100010: ALUCtl <= 5'b00100; // sub 4     (34)
//                        6'b100011: ALUCtl <= 5'b00101; // subu 5    (35)

//                        6'b100100: ALUCtl <= 5'b00000; // and 0    (36)
//                        6'b100101: ALUCtl <= 5'b00001; // or  1     (37)
//                        6'b100110: ALUCtl <= 5'b01101; // xor 13   (38)
//                        6'b100111: ALUCtl <= 5'b01100; // nor 12    (39)

//                        6'b101010: ALUCtl <= 5'b01010; // slt 10    (42)
//                        6'b101011: ALUCtl <= 5'b01011; // sltu 11   (43)
//                        6'b101100: ALUCtl <= 5'b10001; // madd 17   (44)
//                        6'b101101: ALUCtl <= 5'b10010; // msub 18   (45)
//                    endcase
//                end   
//            default: ALUCtl <= 6'b111111; // do nothing?//should not happen  31
//        endcase
//endmodule

