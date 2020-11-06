`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2020 09:58:43 AM
// Design Name: 
// Module Name: HiLoRegs
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


module HiLoRegs( HI_input, LO_input, regWrite, clk, HIReg, LOReg //HI_output, LO_output

    );
    input [31:0] HI_input, LO_input; 
    input regWrite, clk;

//    output [31:0] HI_output, LO_output;

    output reg [31:0] HIReg, LOReg;
    
//    reg [31:0] HIReg, LOReg; 
    
//    assign HI_output = HIReg;
//    assign LO_output  = LOReg;
    
    initial begin
        HIReg <= 0;
        LOReg <= 0;
    end
    
    always @ (posedge clk) begin
        if (regWrite == 1) begin
            LOReg <= LO_input;
        end
    end
    always @ (HI_input, regWrite) begin
        if (regWrite == 1) begin
            HIReg <= HI_input;
        end
    end
    
endmodule
