`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2020 08:51:30 PM
// Design Name: 
// Module Name: BranchAnd
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


module BranchAnd(Branch, Zero, PCSrc);
    input [1:0] Branch;
    input Zero;
    
    output reg PCSrc;
    
    initial begin
        PCSrc <= 0;
    end
    
    always @ (*)begin
        PCSrc =  Branch[0] & Zero;
    end
    
    
endmodule
