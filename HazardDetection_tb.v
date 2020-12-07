`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2020 01:51:08 PM
// Design Name: 
// Module Name: HazardDetection_tb
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


module HazardDetection_tb();

    reg IDEXMemRead;
    reg [4:0] IDEXrt, IFIDrs, IFIDrt;
    wire MuxSig, IFIDWrite, PCWrite;
    
    HazardDetection a1(IDEXMemRead, IDEXrt, IFIDrs, IFIDrt, MuxSig, IFIDWrite, PCWrite);

	initial begin
        IDEXMemRead <= 1;
        IDEXrt <= 'b00000;
        IFIDrs <= 'b00000;
        IFIDrt <= 'b00000;
        #100 
        IDEXMemRead <= 0;
        IDEXrt <= 'b00000;
        IFIDrs <= 'b00000;
        IFIDrt <= 'b00000;
        #100 
        IDEXMemRead <= 1;
        IDEXrt <= 'b10000;
        IFIDrs <= 'b01000;
        IFIDrt <= 'b00100;
        #100 
        IDEXMemRead <= 1;
        IDEXrt <= 'b00011;
        IFIDrs <= 'b00011;
        IFIDrt <= 'b00000;
        #100
        IDEXMemRead <= 1;
        IDEXrt <= 'b10000;
        IFIDrs <= 'b01000;
        IFIDrt <= 'b00100;
        #100
        #100
        #100
        IDEXMemRead <= 1;
        IDEXrt <= 'b00000;
        IFIDrs <= 'b00000;
        IFIDrt <= 'b00000;
	end
endmodule
