`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2020 06:44:23 PM
// Design Name: 
// Module Name: Mux14Bit2to1
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


module Mux14Bit2to1(out, inA, inB, sel);

    output reg [13:0] out;
    
    input [13:0] inA;
    input [13:0] inB;
    input sel;

    /* Fill in the implementation here ... */ 
    always @ (inA, inB, sel) begin
       if (sel == 1)
            out <= inB;    
       else
            out <= inA;
    end
endmodule

