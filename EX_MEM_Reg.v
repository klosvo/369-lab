`timescale 1ns / 1ps


//INCOMPLETE
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
////////////////////////////////////////////////////////////////////////////////

module EX_MEM_Reg(MultResultIn, BranchAddResultIn, ALUResultIn, MemDataIn, ReadData1In, OffsetIn, rdRegIn,RegWriteIn, 
                  MemWriteIn, MemReadIn, BranchIn, dataTypeIn, MemToRegIn, MultBitIn, HiLoWriteIn, ZeroIn, clk, flush,
                  MultResultOut, BranchAddResultOut, ALUResultOut, MemDataOut, ReadData1Out, OffsetOut, rdRegOut, RegWriteOut, 
                  MemWriteOut, MemReadOut, BranchOut, dataTypeOut, MemToRegOut, MultBitOut,HiLoWriteOut, ZeroOut);
                  
                  input [63:0] MultResultIn;
                  input [31:0] BranchAddResultIn, ALUResultIn, MemDataIn, ReadData1In, OffsetIn;
                  input [4:0] rdRegIn;
                  input RegWriteIn, MemWriteIn, MemReadIn, MemToRegIn, MultBitIn, HiLoWriteIn, ZeroIn, clk, flush;
                  input [1:0] BranchIn, dataTypeIn;
                  output reg [63:0] MultResultOut;
                  output reg [31:0] BranchAddResultOut, ALUResultOut, MemDataOut, ReadData1Out, OffsetOut;
                  output reg [4:0] rdRegOut;
                  output reg RegWriteOut, MemWriteOut, MemReadOut, MemToRegOut, MultBitOut, HiLoWriteOut, ZeroOut;
                  output reg [1:0] BranchOut, dataTypeOut;
                  
      always @ (posedge clk) begin
      if (flush) begin
        MultResultOut = 0;
         BranchAddResultOut = 0;
         ALUResultOut = 0;
         MemDataOut = 0;
         rdRegOut = 0;
         RegWriteOut = 0;
         MemWriteOut = 0;
         MemReadOut = 0;
         MemToRegOut = 0;
         HiLoWriteOut = 0;
         MultBitOut = 0;
         ZeroOut = 0;
         BranchOut = 0;   
         dataTypeOut = 0;
         ReadData1Out = 0;
         OffsetOut = 0;
        end 
        else begin
         MultResultOut = MultResultIn;
         BranchAddResultOut = BranchAddResultIn;
         ALUResultOut = ALUResultIn;
         MemDataOut = MemDataIn;
         rdRegOut = rdRegIn;
         RegWriteOut = RegWriteIn;
         MemWriteOut = MemWriteIn;
         MemReadOut = MemReadIn;
         MemToRegOut = MemToRegIn;
         HiLoWriteOut = HiLoWriteIn;
         MultBitOut = MultBitIn;
         ZeroOut = ZeroIn;
         BranchOut = BranchIn;   
         dataTypeOut = dataTypeIn;
         ReadData1Out = ReadData1In;
         OffsetOut = OffsetIn;
         end
      end

endmodule