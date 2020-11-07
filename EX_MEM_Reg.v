`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
////////////////////////////////////////////////////////////////////////////////

module EX_MEM_Reg(MultResultIn, BranchAddResultIn, ALUResultIn, MemDataIn, ReadData1In, OffsetIn, rdRegIn, RegWriteIn, MemWriteIn, MemReadIn, BranchIn, dataTypeIn, MemToRegIn, 
                  MultBitIn, HiLoWriteIn, ZeroIn, clk, 
                  MultResultOut, BranchAddResultOut, ALUResultOut, MemDataOut, ReadData1Out, OffsetOut, rdRegOut, RegWriteOut, MemWriteOut, MemReadOut, BranchOut, dataTypeOut, MemToRegOut, 
                  MultBitOut, HiLoWriteOut, ZeroOut);
                  
                  input [63:0] MultResultIn;
                  input [31:0] BranchAddResultIn, ALUResultIn, MemDataIn, ReadData1In, OffsetIn;
                  input [4:0] rdRegIn;
                  input RegWriteIn, MemWriteIn, MemReadIn, MemToRegIn, MultBitIn, HiLoWriteIn, ZeroIn, clk;
                  input [1:0] BranchIn, dataTypeIn;
                  output reg [63:0] MultResultOut;
                  output reg [31:0] BranchAddResultOut, ALUResultOut, MemDataOut, ReadData1Out, OffsetOut;
                  output reg [4:0] rdRegOut;
                  output reg RegWriteOut, MemWriteOut, MemReadOut, MemToRegOut, MultBitOut, HiLoWriteOut, ZeroOut;
                  output reg [1:0] BranchOut, dataTypeOut;
                  
 
      initial begin
          MultResultOut <= 64'b0;
          BranchAddResultOut <= 32'b0;
          ALUResultOut <= 32'b0;
          MemDataOut <= 32'b0;
          rdRegOut <= 5'b0;
          RegWriteOut <= 0;
          MemWriteOut <= 0;
          MemReadOut <= 0;
          MemToRegOut <= 0;
          HiLoWriteOut <= 0;
          MultBitOut <= 0;
          ZeroOut <= 0;
          BranchOut <= 2'b0;   
          dataTypeOut <= 2'b0;
          ReadData1Out <= 32'b0;
          OffsetOut <= 32'b0;
      end                  
                  
      always @ (posedge clk) begin
         MultResultOut <= MultResultIn;
         BranchAddResultOut <= BranchAddResultIn;
         ALUResultOut <= ALUResultIn;
         MemDataOut <= MemDataIn;
         rdRegOut <= rdRegIn;
         RegWriteOut <= RegWriteIn;
         MemWriteOut <= MemWriteIn;
         MemReadOut <= MemReadIn;
         MemToRegOut <= MemToRegIn;
         HiLoWriteOut <= HiLoWriteIn;
         MultBitOut <= MultBitIn;
         ZeroOut <= ZeroIn;
         BranchOut <= BranchIn;   
         dataTypeOut <= dataTypeIn;
         ReadData1Out <= ReadData1In;
         OffsetOut <= OffsetIn;
      end
endmodule