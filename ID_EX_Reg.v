`timescale 1ns / 1ps


//INCOMPLETE
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
////////////////////////////////////////////////////////////////////////////////

module ID_EX_Reg(PCAddResultIn, ReadData1In, ReadData2In, OffsetIn, RtRegIn, RdRegIn,
                 regDstIn, ALUSourceIn, MemToRegIn, regWriteIn, MemReadIn, MemWriteIn,
                 BranchJumpIn, ALUOpIn, clk,
                  PCAddResultOut, ReadData1Out, ReadData2Out, OffsetOut, RtRegOut, RdRegOut,
                  regDstOut, ALUSourceOut, MemToRegOut, regWriteOut, MemReadOut, MemWriteOut,
                  BranchJumpOut, ALUOpOut);
                  
                  
                  input regDstIn, ALUSourceIn, MemToRegIn, regWriteIn, MemReadIn, MemWriteIn, clk;
                  input [31:0] PCAddResultIn, ReadData1In, ReadData2In, OffsetIn;
                  input [20:16] RtRegIn;
                  input [15:11] RdRegIn;
                  input [4:0] ALUOpIn;
                  input [1:0] BranchJumpIn; 
                  output reg regDstOut, ALUSourceOut, MemToRegOut, regWriteOut, MemReadOut, MemWriteOut;
                  output reg [31:0] PCAddResultOut, ReadData1Out, ReadData2Out, OffsetOut;
                  output reg [4:0] RtRegOut, RdRegOut;
                  output reg [1:0] BranchJumpOut;
                  output reg [4:0] ALUOpOut;

    always @ (posedge clk) begin
        regDstOut = regDstIn;
        ALUSourceOut = ALUSourceIn;
        MemToRegOut = MemToRegIn;
        regWriteOut= regWriteIn;
        MemReadOut = MemReadIn;
        MemWriteOut = MemWriteIn;
        PCAddResultOut = PCAddResultIn;
        ReadData1Out = ReadData1In;
        ReadData2Out = ReadData2In;
        OffsetOut = OffsetIn;
        RtRegOut = RtRegIn;
        RdRegOut = RdRegIn;
        BranchJumpOut = BranchJumpIn;
        ALUOpOut = ALUOpIn;
    end
endmodule