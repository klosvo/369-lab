`timescale 1ns / 1ps


//INCOMPLETE
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
////////////////////////////////////////////////////////////////////////////////

module EX_MEM_Reg(BranchAddResultIn, ALUResultIn, MemDataIn, ReadData1In, OffsetIn, rdRegIn, RegWriteIn, MemWriteIn, MemReadIn, BranchIn, MemToRegIn, ZeroIn, clk, 
                  BranchAddResultOut, ALUResultOut, MemDataOut, ReadData1Out, OffsetOut, rdRegOut, RegWriteOut, MemWriteOut, MemReadOut, BranchOut, MemToRegOut, ZeroOut);
                  
                  input [31:0] BranchAddResultIn, ALUResultIn, MemDataIn, ReadData1In, OffsetIn;
                  input [4:0] rdRegIn;
                  input RegWriteIn, MemWriteIn, MemReadIn, MemToRegIn, ZeroIn, clk;
                  input [1:0] BranchIn;
                  output reg [31:0] BranchAddResultOut, ALUResultOut, MemDataOut, ReadData1Out, OffsetOut;
                  output reg [4:0] rdRegOut;
                  output reg RegWriteOut, MemWriteOut, MemReadOut, MemToRegOut, ZeroOut;
                  output reg [1:0] BranchOut;
                  
      always @ (posedge clk) begin
         BranchAddResultOut = BranchAddResultIn;
         ALUResultOut = ALUResultIn;
         MemDataOut = MemDataIn;
         rdRegOut = rdRegIn;
         RegWriteOut = RegWriteIn;
         MemWriteOut = MemWriteIn;
         MemReadOut = MemReadIn;
         MemToRegOut = MemToRegIn;
         ZeroOut = ZeroIn;
         BranchOut = BranchIn;   
         ReadData1Out = ReadData1In;
         OffsetOut = OffsetIn;
      end

endmodule