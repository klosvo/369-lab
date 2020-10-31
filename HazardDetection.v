`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2020 10:51:12 PM
// Design Name: 
// Module Name: HazardDetection
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


module HazardDetection(IDEXMemRead, IDEXrt, IFIDrs, IFIDrt, MuxSig, IFIDWrite, PCWrite);

    input IDEXMemRead;
    input [4:0] IDEXrt, IFIDrs, IFIDrt;
    
    output reg MuxSig, IFIDWrite, PCWrite;
    
    always @( IDEXMemRead, IDEXrt, IFIDrs, IFIDrt ) begin
        if (IDEXMemRead & ((IDEXrt == IFIDrs) | (IDEXrt == IFIDrt))) begin
                MuxSig <= 0;
                IFIDWrite <= 0;
                PCWrite <=0;
        end 
        else begin
                MuxSig <= 1;
                IFIDWrite <= 1;
                PCWrite <= 1;
        end
    end          
endmodule
