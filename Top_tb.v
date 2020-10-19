`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2020 12:20:23 PM
// Design Name: 
// Module Name: Top_tb
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


module Top_tb(

    );
    reg clk;
    reg reset;
    
    Top top(clk, reset);
    integer i;
    
	
	initial begin
	reset = 0;
        for (i = 0; i < 128; i = i+1) begin
           #100 clk = 0;
           #100 clk = 1;
        end
	end
	
    
    
endmodule
