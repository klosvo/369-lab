`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2020 04:40:19 PM
// Design Name: 
// Module Name: BranchControlModule
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


module BranchControlModule(Op, A, B, BGE_BLT, BranchAndJump, funct 
    );
    
    input [2:0] Op;
    input [4:0] BGE_BLT;
    input [5:0] funct;
    input [31:0]  A, B;
    output reg [1:0] BranchAndJump;
    
    
    initial begin
        BranchAndJump = 0;
    end
    
    always @ * begin
    case (Op)
        3'b100: begin // bgez skipped for now
                BranchAndJump[0] = A[31] ^ BGE_BLT[0];
                BranchAndJump[1] = 0;
        end
        3'b001: begin // beq
                BranchAndJump[0] = ~(|(A ^ B));
                BranchAndJump[1] = 0;
//            if (A == B) begin
//                BranchAndJump = 2'b01;
//            end
//            else BranchAndJump = 0;
        end
        3'b010: begin // bne
                BranchAndJump[0] = (|(A ^ B));
                BranchAndJump[1] = 0;
//            if (A == B) begin
//                BranchAndJump = 0;
//            end
//            else BranchAndJump = 2'b01;
        end
        3'b101: begin // bgtz
                BranchAndJump[0] = ~A[31] & (|(A ^ 0));
                BranchAndJump[1] = 0;
        end
        3'b110: begin // blez
                BranchAndJump[0] = A[31] | ~(|(A ^ 0));
                BranchAndJump[1] = 0;
        end
        
        3'b011: begin // j
                BranchAndJump = 2'b01;
        end
        
        3'b000: begin //jr
            if (funct == 6'b001000) begin
            BranchAndJump = 2'b10;
            end
            else BranchAndJump = 0;
        end
        
        default: BranchAndJump = 0;
    endcase
    end
    
endmodule
