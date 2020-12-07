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

module HazardDetection(branch, IDEXMemRead,IDEXregWrite, IDEXrd, IDEXrt, IFIDrs, IFIDrt, IFIDFlush, IDEXFlush, EXMEMFlush, IFIDWrite, PCWrite, MulOp);

    input [1:0] branch;
    input IDEXMemRead, MulOp, IDEXregWrite;
    input [4:0] IDEXrd, IDEXrt, IFIDrs, IFIDrt;
    
        //reg mulStallCounter;IDEXregWrite, 
    
    output reg IFIDFlush, IDEXFlush, EXMEMFlush, IFIDWrite, PCWrite;
    
        initial begin
        IFIDFlush <= 0;
        IDEXFlush <= 0;
        IFIDWrite <= 1;
        PCWrite <= 1;
       // mulStallCounter <= 0;
        
    end
    
    always @(*) begin
        if (~(branch == 0)) begin
            IFIDFlush <= 1;
            IDEXFlush <= 1;
            EXMEMFlush <= 1;
        end
        else if ((IDEXMemRead & ((IDEXrt == IFIDrs) | (IDEXrt == IFIDrt))) | (IDEXregWrite & (MulOp & ((IDEXrd == IFIDrs) | (IDEXrd == IFIDrt))))) begin
                IDEXFlush <= 1;
                IFIDFlush <= 0;
                IFIDWrite <= 0;
                EXMEMFlush <= 0;
                PCWrite <=0;
                //mulStallCounter <= 1;
        end 
        else begin
                IFIDFlush <= 0;
                IDEXFlush <= 0;
                EXMEMFlush <= 0;
                IFIDWrite <= 1;
                PCWrite <= 1;
               // mulStallCounter <= 0;
        end

    end          
endmodule
