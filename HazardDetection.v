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


module HazardDetection(branch, IDEXMemRead, IDEXrt, IFIDrs, IFIDrt, IFIDFlush, IDEXFlush, IFIDWrite, PCWrite, MulOp);

    input [1:0] branch;
    input IDEXMemRead, MulOp;
    input [4:0] IDEXrt, IFIDrs, IFIDrt;
    
    reg stallagain;
    
    output reg IFIDFlush, IDEXFlush, IFIDWrite, PCWrite;
    
    always @( branch, IDEXMemRead, IDEXrt, IFIDrs, IFIDrt ) begin
        if ((IDEXMemRead & ((IDEXrt == IFIDrs) | (IDEXrt == IFIDrt))) | MulOp) begin
                IDEXFlush <= 1;
                IFIDWrite <= 0;
                PCWrite <=0;
        end 
        else if (~(branch == 0) | stallagain) begin
            IFIDFlush <= 1;
            IDEXFlush <= 1;
            stallagain <= ~stallagain;
        end
        else begin
                IFIDFlush <= 0;
                IDEXFlush <= 0;
                IFIDWrite <= 1;
                PCWrite <= 1;
        end
        
        
    end          
endmodule
