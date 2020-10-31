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


module Controller(instruction, regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite, BranchJump, ALUOp);
    input [5:0] instruction;
    output reg regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite;
    output reg [2:0] BranchJump;
    output reg [4:0] ALUOp;
    
    initial begin
        regDst = 0;
        ALUSource = 0;
        MemToReg = 0;
        regWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        BranchJump = 0;
        ALUOp = 0;
    end
    
    always @ (instruction) begin
        case (instruction)
            2'h00: begin // r-type
            regDst = 1'b0;
            ALUSource = 1'b0;
            MemToReg = 1'b1;
            regWrite = 1'b1;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            BranchJump = 3'b000;
            ALUOp = 5'b000000;
            end
        6'b001000: begin // addi
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 5'b000010; //  add Code
        end
        6'b001001: begin // addiu
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 5'b00111; // todo: Change to addu Code
        end
        6'b011100: begin // special2  madd/msub
        regDst <= 1;
        ALUSource <= 0;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 5'b01000; // 
        end
        6'b011111: begin // special3  seb/seh
        regDst <= 0;
        ALUSource <= 0;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 5'b01001; // 
        end
        6'b100011: begin // lw
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 0;
        regWrite <= 1;
        MemRead <= 1;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 5'b000010; // add Code
        end
        6'b101011: begin // sw
        ALUSource <= 1;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 1;
        BranchJump <= 0;
        ALUOp <= 5'b000010; // add Code
        end
        6'b100000: begin // lb
        regDst <= 0;
        ALUSource <= 1;
        MemToReg <= 0;
        regWrite <= 1;
        MemRead <= 1;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 5'b000010; // add Code
        end
        6'b100001: begin //lh
        regDst <= 0;
        ALUSource <= 1;
        MemToReg <= 0;
        regWrite <= 1;
        MemRead <= 1;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 5'b000010; // add Code
        end
        6'b101000: begin // sb
        ALUSource <= 1;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 1;
        BranchJump <= 0;
        ALUOp <= 5'b000010; // add Code
        end
        6'b101001: begin // sh
        ALUSource <= 1;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 1;
        BranchJump <= 0;
        ALUOp <= 5'b000010; // add Code
        end
        6'b001111: begin // lui
        regDst <= 0;
        ALUSource <= 0;
        MemToReg <= 0;
        regWrite <= 1;
        MemRead <= 1;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 5'b000010; // add Code
        end
        6'b000001: begin //
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 3'b100;
        ALUOp <= 0; // todo: Change to sub Code
        end
        6'b000100: begin // beq
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 3'b001;
        ALUOp <= 2'b01; // sub Code
        end
        6'b000101: begin // bne
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 3'b010;
        ALUOp <= 2'b01; // sub Code
        end
        6'b000111: begin // bgtz
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 3'b101;
        ALUOp <= 0; // todo: Change to sub Code
        end
        6'b000110: begin // blez
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 3'b110;
        ALUOp <= 0; // todo: Change to sub Code
        end
        6'b000010: begin // j // reqires datapath modification
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 3'b011;
        ALUOp <= 0; // todo: Change to sub Code
        end
        6'b000011: begin // jal
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 3'b011;
        ALUOp <= 0; // todo: Change to sub Code
        end
        6'b001100: begin // andi
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 5'b00001; // change to and code
        end
        6'b001101: begin // ori
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 5'b00011; // change to or code
        end
        6'b001110: begin // xori
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 5'b00100; // change to xor code
        end
         6'b001010: begin // slti
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 5'b00101; // change to slt code
        end
        6'b001011: begin // sltiu
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 5'b01011; // change to sltu code
        end
        
            default: begin
                regDst = 0;
                ALUSource = 0;
                MemToReg = 0;
                regWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                BranchJump = 0;
                ALUOp = 0;
            end
     
    endcase
    
    end
    
endmodule
