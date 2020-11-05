`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2020 08:51:30 PM
// Design Name: 
// Module Name: BranchAnd
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


module And(in1, in2, out);
    input  in1, in2;
    
    output reg out;
    
    always @ (*)begin
        out <= in1 & in2;
    end
    
    
endmodule
