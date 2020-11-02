`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2020 09:48:57 PM
// Design Name: 
// Module Name: Controller
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


module Controller(instruction, controlOut);
    input [5:0] instruction;
//    wire regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite;
//    wire [2:0] BranchJump;
//    wire [4:0] ALUOp;
    output reg [15:0] controlOut;
    
    initial begin
        controlOut <= 16'b0;
    end
    
    always @ (instruction) begin
        case (instruction)
            2'h00: begin // r-type
//        MemDataType <= 2'b00;
//            regDst = 1'b0;
//            ALUSource = 1'b0;
//            MemToReg = 1'b1;
//            regWrite = 1'b1;
//            MemRead = 1'b0;
//            MemWrite = 1'b0;
//            BranchJump = 3'b000;
//            ALUOp = 5'b00000;
                controlOut <= 16'b0000110000000000; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
            end
        6'b001000: begin // addi
//        MemDataType <= 2'b00;
//        regDst <= 1;
//        ALUSource <= 1;
//        MemToReg <= 1;
//        regWrite <= 1;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 0;
//        ALUOp <= 5'b00010; //  add Code
            controlOut <= 16'b0011110000000010; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b001001: begin // addiu
//        MemDataType <= 2'b00;        
//        regDst <= 1;
//        ALUSource <= 1;
//        MemToReg <= 1;
//        regWrite <= 1;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 0;
//        ALUOp <= 5'b00111; // todo: Change to addu Code
            controlOut <= 16'b0011110000000111; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b011100: begin // special2  madd/msub
//        MemDataType <= 2'b00;
//        regDst <= 1;
//        ALUSource <= 0;
//        MemToReg <= 1;
//        regWrite <= 1;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 0;
//        ALUOp <= 5'b01000; 
            controlOut <= 16'b0010110000001000; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b011111: begin // special2  madd/msub
//        MemDataType <= 2'b00;
//        regDst <= 1;
//        ALUSource <= 0;
//        MemToReg <= 1;
//        regWrite <= 1;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 0;
//        ALUOp <= 5'b01000; // 
            controlOut <= 16'b0010110000001000; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        

        
        
        6'b100011: begin // lw
//        MemDataType <= 2'b10;
//        regDst <= 1;
//        ALUSource <= 1;
//        MemToReg <= 0;
//        regWrite <= 1;
//        MemRead <= 1;
//        MemWrite <= 0;
//        BranchJump <= 0;
//        ALUOp <= 5'b00010; // add Code
        controlOut <= 16'b1011011000000010; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp, MemDataType};
        end
        6'b101011: begin // sw
//        MemDataType <= 2'b10;
//        ALUSource <= 1;
//        regWrite <= 0;
//        MemRead <= 0;
//        MemWrite <= 1;
//        BranchJump <= 0;
//        ALUOp <= 5'b000010; // add Code
        controlOut <= 16'b100001000000010; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp, MemDataType};
        end
        6'b100000: begin // lb
//        MemDataType <= 2'b00;
//        regDst <= 1;
//        ALUSource <= 1;
//        MemToReg <= 0;
//        regWrite <= 1;
//        MemRead <= 1;
//        MemWrite <= 0;
//        BranchJump <= 0;
//        ALUOp <= 5'b00010; // add Code
        controlOut <= 16'b0011011000000010; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b100001: begin //lh
//        MemDataType <= 2'b01;
//        regDst <= 1;
//        ALUSource <= 1;
//        MemToReg <= 0;
//        regWrite <= 1;
//        MemRead <= 1;
//        MemWrite <= 0;
//        BranchJump <= 0;
//        ALUOp <= 5'b000010; // add Code

        controlOut <= 16'b0111011000000010; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b101000: begin // sb
//        MemDataType <= 2'b00;
//        ALUSource <= 1;
//        regWrite <= 0;
//        MemRead <= 0;
//        MemWrite <= 1;
//        BranchJump <= 0;
//        ALUOp <= 5'b000010; // add Code

        controlOut <= 16'b0001000100000010;//{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b101001: begin // sh
//        MemDataType <= 2'b01;
//        ALUSource <= 1;
//        regWrite <= 0;
//        MemRead <= 0;
//        MemWrite <= 1;
//        BranchJump <= 0;
//        ALUOp <= 5'b000010; // add Code
        controlOut <= 16'b0101000100000010; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b001111: begin // lui
//        MemDataType <= 2'b00;
//        regDst <= 0;
//        ALUSource <= 0;
//        MemToReg <= 0;
//        regWrite <= 1;
//        MemRead <= 1;
//        MemWrite <= 0;
//        BranchJump <= 0;
//        ALUOp <= 5'b000010; // add Code
        controlOut <= 16'b0000011000000010; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b000001: begin //
//        MemDataType <= 2'b00;
//        ALUSource <= 0;
//        regWrite <= 0;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 3'b100;
//        ALUOp <= 0; // todo: Change to sub Code
        controlOut <= 16'b0000000010000000; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b000100: begin // beq
//        MemDataType <= 2'b00;
//        ALUSource <= 0;
//        regWrite <= 0;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 3'b001;
//        ALUOp <= 2'b01; // sub Code
        controlOut <= 16'b0000000000100001; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b000101: begin // bne
//        MemDataType <= 2'b00;
//        ALUSource <= 0;
//        regWrite <= 0;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 3'b010;
//        ALUOp <= 2'b01; // sub Code
        controlOut <= 16'b0000000001000001; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b000111: begin // bgtz
//        MemDataType <= 2'b00;
//        ALUSource <= 0;
//        regWrite <= 0;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 3'b101;
//        ALUOp <= 0; // todo: Change to sub Code
        controlOut <= 16'b0000000010100000; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b000110: begin // blez
//        MemDataType <= 2'b00;
//        ALUSource <= 0;
//        regWrite <= 0;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 3'b110;
//        ALUOp <= 0; // todo: Change to sub Code
        controlOut <= 16'b0000000011000000; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b000010: begin // j // reqires datapath modification
//        MemDataType <= 2'b00;
//        ALUSource <= 0;
//        regWrite <= 0;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 3'b011;
//        ALUOp <= 0; // todo: Change to sub Code
        controlOut <= 16'b0000000001100000; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b000011: begin // jal
//        MemDataType <= 2'b00;
//        ALUSource <= 0;
//        regWrite <= 0;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 3'b011;
//        ALUOp <= 0; // todo: Change to sub Code
        controlOut <= 16'b0000000001100000; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b001100: begin // andi
//        MemDataType <= 2'b00;
//        regDst <= 1;
//        ALUSource <= 1;
//        MemToReg <= 1;
//        regWrite <= 1;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 0;
//        ALUOp <= 5'b00001; // change to and code
        controlOut <= 16'b0011110000000001; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b001101: begin // ori
//        MemDataType <= 2'b00;
//        regDst <= 1;
//        ALUSource <= 1;
//        MemToReg <= 1;
//        regWrite <= 1;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 0;
//        ALUOp <= 5'b00011; // change to or code
        controlOut <= 16'b0011110000000011; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b001110: begin // xori
//        MemDataType <= 2'b00;
//        regDst <= 1;
//        ALUSource <= 1;
//        MemToReg <= 1;
//        regWrite <= 1;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 0;
//        ALUOp <= 5'b00100; // change to xor code
        controlOut <= 16'b0011110000000100; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
         6'b001010: begin // slti
//        MemDataType <= 2'b00;
//        regDst <= 1;
//        ALUSource <= 1;
//        MemToReg <= 1;
//        regWrite <= 1;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 0;
//        ALUOp <= 5'b00101; // change to slt code
        controlOut <= 16'b0011110000000101; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        6'b001011: begin // sltiu
//        MemDataType <= 2'b00;
//        regDst <= 1;
//        ALUSource <= 1;
//        MemToReg <= 1;
//        regWrite <= 1;
//        MemRead <= 0;
//        MemWrite <= 0;
//        BranchJump <= 0;
//        ALUOp <= 0; // change to sltu code
        controlOut <= 16'b0011110000000000; //{regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp};
        end
        
            default: begin
                controlOut <= 16'b0;
            end
            
        
     
    endcase
    
    end
    
endmodule