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


module Top_tb( );
    reg clk;
    reg reset;
    wire [6:0] out7;
    wire [7:0] en_out;
    
    Top t1(clk, reset, out7, en_out);
	
	always begin
           clk = 0;
           #100;
           clk = 1;
           #100;
	end
	
	initial begin
        reset <= 1;
        @(posedge clk);
        #5 reset <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); 
	end
	
endmodule