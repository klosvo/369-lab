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

<<<<<<< Updated upstream
module HazardDetection(branch, IDEXMemRead, IDEXrt, IFIDrs, IFIDrt, IFIDFlush, IDEXFlush, IFIDWrite, PCWrite, MulOp);
=======
module HazardDetection(branch, IDEXMemRead, IDEXrt, IFIDrs, IFIDrt, IFIDFlush, IDEXFlush, EXMEMFlush, IFIDWrite, PCWrite, MulOp);
>>>>>>> Stashed changes

    input [1:0] branch;
    input IDEXMemRead, MulOp;
    input [4:0] IDEXrt, IFIDrs, IFIDrt;
    
        reg mulStallCounter;
    
    output reg IFIDFlush, IDEXFlush, EXMEMFlush, IFIDWrite, PCWrite;
    
        initial begin
        IFIDFlush <= 0;
        IDEXFlush <= 0;
        IFIDWrite <= 1;
        PCWrite <= 1;
        mulStallCounter <= 0;
    end
    
    always @( branch, IDEXMemRead, MulOp, IDEXrt, IFIDrs, IFIDrt ) begin
        if ((IDEXMemRead & ((IDEXrt == IFIDrs) | (IDEXrt == IFIDrt))) | (MulOp & !mulStallCounter)) begin
                IDEXFlush <= 1;
                IFIDFlush <= 0;
                IFIDWrite <= 0;
                EXMEMFlush <= 0;
                PCWrite <=0;
                mulStallCounter <= 1;
        end 
        else if (~(branch == 0) | stallagain) begin
            IFIDFlush <= 1;
            IDEXFlush <= 1;
<<<<<<< Updated upstream
            stallagain <= ~stallagain;
=======
            EXMEMFlush <= 1;
>>>>>>> Stashed changes
        end
        else begin
                IFIDFlush <= 0;
                IDEXFlush <= 0;
                EXMEMFlush <= 0;
                IFIDWrite <= 1;
                PCWrite <= 1;
                mulStallCounter <= 0;
        end

    end          
endmodule
