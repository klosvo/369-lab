`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 02:19:55 PM
// Design Name: 
// Module Name: IF_ID_Reg
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


module IF_ID_Reg(
        PCAddResultIn, InstructionIn, clk,
        PCAddResultOut, InstructionOut
    );
    input clk;
    input [31:0] PCAddResultIn, InstructionIn;
    output reg [31:0] PCAddResultOut, InstructionOut;
    
    always @ (posedge clk)begin
        PCAddResultOut = PCAddResultIn;
        InstructionOut = InstructionIn;
    end
endmodule
