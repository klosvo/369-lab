`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
////////////////////////////////////////////////////////////////////////////////

module MEM_WB_Reg(MemReadDataIn, ALUResultIn, rdIn, MemToRegIn, RegWrite, clk,
                  MemReadDataOut, ALUResultOut, rdOut, MemToRegOut, RegWriteOut);             
                  
                  input [31:0] MemReadDataIn, ALUResultIn;
                  input [4:0] rdIn;
                  input MemToRegIn, RegWrite, clk;
                  
                  output reg [31:0] MemReadDataOut, ALUResultOut;
                  output reg [4:0] rdOut;
                  output reg MemToRegOut, RegWriteOut;
                  
      always @ (posedge clk) begin
        MemReadDataOut = MemReadDataIn;
        ALUResultOut = ALUResultIn;
        rdOut = rdIn;
        MemToRegOut = MemToRegIn;
        RegWriteOut = RegWrite;
      end
     
endmodule