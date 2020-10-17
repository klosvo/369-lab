`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2020 01:56:52 PM
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
    input [31:26] instruction;
    output reg regDst, ALUSource, MemToReg, regWrite, MemRead, MemWrite;
    output reg [1:0] BranchJump;
    output reg [1:0] ALUOp;
    
    always @ (instruction) begin
    case (instruction)
        6'b000000: begin // r-type
        regDst <= 1;
        ALUSource <= 0;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 0;
        end
        6'b001000: begin // addi
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 0; // todo: Change to add Code
        end
        6'b001001: begin // addiu
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 0; // todo: Change to addu Code
        end
        6'b011100: begin // special2  madd/msub
        regDst <= 1;
        ALUSource <= 0;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 0; // todo: Change to madd/msub Code
        end
        6'b100011: begin // lw
        regDst <= 0;
        ALUSource <= 1;
        MemToReg <= 0;
        regWrite <= 1;
        MemRead <= 1;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 0; // todo: Change to add Code
        end
        6'b101011: begin // sw
        ALUSource <= 1;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 1;
        BranchJump <= 0;
        ALUOp <= 0; // todo: Change to add Code
        end
        6'b100000: begin // lb
        regDst <= 0;
        ALUSource <= 1;
        MemToReg <= 0;
        regWrite <= 1;
        MemRead <= 1;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 0; // todo: Change to add Code
        end
        6'b100001: begin //lh
        regDst <= 0;
        ALUSource <= 1;
        MemToReg <= 0;
        regWrite <= 1;
        MemRead <= 1;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 0; // todo: Change to add Code
        end
        6'b101000: begin // sb
        ALUSource <= 1;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 1;
        BranchJump <= 0;
        ALUOp <= 0; // todo: Change to add Code
        end
        6'b101001: begin // sh
        ALUSource <= 1;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 1;
        BranchJump <= 0;
        ALUOp <= 0; // todo: Change to add Code
        end
        6'b001111: begin // lui
        regDst <= 0;
        ALUSource <= 0;
        MemToReg <= 0;
        regWrite <= 1;
        MemRead <= 1;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 0; // todo: Change to add Code
        end
        6'b000001: begin // bgez skipped for now
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 1;
        ALUOp <= 0; // todo: Change to sub Code
        end
        6'b000100: begin // beq
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 1;
        ALUOp <= 0; // todo: Change to sub Code
        end
        6'b000101: begin // bne
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 1;
        ALUOp <= 0; // todo: Change to sub Code
        end
        6'b000111: begin // bgtz
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 1;
        ALUOp <= 0; // todo: Change to sub Code
        end
        6'b000110: begin // blez
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 1;
        ALUOp <= 0; // todo: Change to sub Code
        end
        6'b000001: begin // bltz // Skipped for now
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 1;
        ALUOp <= 0; // todo: Change to sub Code
        end
        6'b000010: begin // j // reqires datapath modification
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 1;
        ALUOp <= 0; // todo: Change to sub Code
        end
        6'b000011: begin // jal
        ALUSource <= 0;
        regWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 1;
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
        ALUOp <= 0; // change to and code
        end
        6'b001101: begin // ori
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 0; // change to or code
        end
        6'b001110: begin // xori
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 0; // change to xor code
        end
         6'b001010: begin // slti
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 0; // change to slt code
        end
        6'b001011: begin // sltiu
        regDst <= 1;
        ALUSource <= 1;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 0; // change to sltu code
        end
        6'b011111: begin // sltiu
        regDst <= 1;
        ALUSource <= 0;
        MemToReg <= 1;
        regWrite <= 1;
        MemRead <= 0;
        MemWrite <= 0;
        BranchJump <= 0;
        ALUOp <= 0; // set to Special 3 seb/seh
        end
     
    endcase
    end
    
endmodule
