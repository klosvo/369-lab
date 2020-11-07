`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2020 06:39:50 PM
// Design Name: 
// Module Name: multiplyUnit
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


module multiplyUnit( multResult, mulOut, HI_out, LO_out, regWrite);

    input [63:0] multResult;
    output reg [31:0] HI_out, LO_out;
    input regWrite;
    output reg [31:0] mulOut;
    
    
    reg HI, LO;
    
    always @ * begin
        if (regWrite) begin
            HI_out <= multResult[63:32];
            LO_out <= multResult[31:0];
        end
        else begin
            HI_out <= 16'b0;
            LO_out <= multResult[31:0];
            mulOut <= multResult[31:0];
        end
    end
    
endmodule
