`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2020 07:36:15 PM
// Design Name: 
// Module Name: Mux5Bit2To1
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


module Mux5Bit2To1(out, inA, inB, sel);

    output reg [4:0] out;
    
    input [4:0] inA;
    input [4:0] inB;
    input sel;

    /* Fill in the implementation here ... */ 
    always @ (inA, inB, sel) begin
       if (sel == 1)
            out <= inB;    
       else
            out <= inA;
    end
endmodule
