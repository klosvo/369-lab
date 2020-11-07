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
                  
      initial begin
        MemReadDataOut <= 32'b0;
        ALUResultOut <= 32'b0;
        rdOut <= 5'b0;
        MemToRegOut <= 0;
        RegWriteOut <= 0;
      end                  
                  
                  
      always @ (posedge clk) begin
        MemReadDataOut <= MemReadDataIn;
        ALUResultOut <= ALUResultIn;
        rdOut <= rdIn;
        MemToRegOut <= MemToRegIn;
        RegWriteOut <= RegWrite;
      end
     
endmodule