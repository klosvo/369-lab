`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2020 05:14:01 PM
// Design Name: 
// Module Name: Mux32Bit4To1
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


module Mux32Bit4To1(out, inA, inB, inC, inD, sel);

    output reg [31:0] out;
    
    input [31:0] inA, inB, inC, inD;
    input [1:0] sel;

    /* Fill in the implementation here ... */ 
    always @ (inA, inB, sel) begin
        case (sel)
            2'b00: out <= inA;
            2'b01: out <= inB;
            2'b10: out <= inC;
            2'b11: out <= inD;
            default: out <= inA;
        endcase
    end
endmodule
