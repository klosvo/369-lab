`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineers: Christopher Chritiansen  50%
//            Kama Svoboda             50% 

// Create Date: 10/17/2020 08:02:41 PM
// Design Name: 
// Module Name: Top
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


module Top(Clk, Reset, out7, en_out);
    
    input Clk, Reset;
    output [6:0] out7;
    output [7:0] en_out;

   wire [31:0] ProgramCounter, WriteData;
   
   // seven segement wires
   wire NewClk;
     
     ClkDiv clock_divider (Clk, Reset, NewClk);
     
     // Datapath 
     Datapath dp(NewClk, Reset, ProgramCounter, WriteData);
     
     // sevenSegment Display
     Two4DigitDisplay two_4_digit_display(Clk, ProgramCounter[15:0], WriteData[15:0], out7, en_out);
 
endmodule
