`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 02:19:55 PM
// Design Name: 
// Module Name: IF_ID_Reg
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


module IF_ID_Reg(
        PCAddResultIn, InstructionIn, Write, clk, 
        PCAddResultOut,InstructionOffset, InstructionCode, funct, IDrs, IDrt, IDrd
    );
    input clk, Write;
    input [31:0] PCAddResultIn, InstructionIn;
    output reg [31:0] PCAddResultOut;
    output reg [15:0] InstructionOffset;
    output reg [5:0] InstructionCode, funct;
    output reg [4:0] IDrs, IDrt, IDrd;   
    
    initial begin
        PCAddResultOut <= 0;
        InstructionOffset <= 0;
        InstructionCode <= 0;
        funct <= 0;
        IDrs <= 0;
        IDrt <= 0;
        IDrd <= 0;
    end   
    
    always @ (posedge clk)begin
        if(Write == 0) begin
            PCAddResultOut <= 0;
            InstructionOffset <= 0;
            InstructionCode <= 0;
            funct <= 0;
            IDrs <= 0;
            IDrt <= 0;
            IDrd <= 0;
       end
       else begin     
            PCAddResultOut = PCAddResultIn;
            InstructionOffset <= InstructionIn[15:0];
            InstructionCode <= InstructionIn[31:26];
            funct <= InstructionIn[5:0];
            IDrs <= InstructionIn[25:21];
            IDrt <= InstructionIn[20:16];
            IDrd <= InstructionIn[15:11];
       end
    end
endmodule
