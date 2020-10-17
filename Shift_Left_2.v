`timescale 1ns / 1ps


//INCOMPLETE
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
////////////////////////////////////////////////////////////////////////////////

module Shift_Left_2(ShiftIn, ShiftOut);
    input [31:0] ShiftIn;
    output reg [31:0] ShiftOut;
    
    always @ (ShiftIn) begin
    ShiftOut = ShiftIn << 2;
    end

endmodule