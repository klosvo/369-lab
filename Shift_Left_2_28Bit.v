`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2020 09:43:36 PM
// Design Name: 
// Module Name: Shift_Left_2_28Bit
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


module Shift_Left_2_28Bit(ShiftIn, ShiftOut);
    input [27:0] ShiftIn;
    output reg [27:0] ShiftOut;
    
    always @ (ShiftIn) begin
        ShiftOut = ShiftIn << 2;
    end
endmodule
