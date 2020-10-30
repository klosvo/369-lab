`timescale 1ns / 1ps


//INCOMPLETE
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
////////////////////////////////////////////////////////////////////////////////

<<<<<<< Updated upstream
module ID_EX_Reg(PCAddResultIn, ReadData1In, ReadData2In, OffsetIn, RtRegIn, RdRegIn,
                 regDstIn, ALUSourceIn, MemToRegIn, regWriteIn, MemReadIn, MemWriteIn,
                 BranchJumpIn, ALUOpIn, clk,
                  PCAddResultOut, ReadData1Out, ReadData2Out, OffsetOut, RtRegOut, RdRegOut,
                  regDstOut, ALUSourceOut, MemToRegOut, regWriteOut, MemReadOut, MemWriteOut,
=======
module ID_EX_Reg(PCAddResultIn, ReadData1In, ReadData2In, OffsetIn, RsRegIn, RtRegIn, RdRegIn,
                 regDstIn, ALUSourceIn, MemToRegIn, regWriteIn, MemReadIn, MemWriteIn, functIn,
                 BranchJumpIn, ALUOpIn, clk,
                  PCAddResultOut, ReadData1Out, ReadData2Out, OffsetOut, RsRegOut, RtRegOut, RdRegOut,
                  regDstOut, ALUSourceOut, MemToRegOut, regWriteOut, MemReadOut, MemWriteOut, functOut,
>>>>>>> Stashed changes
                  BranchJumpOut, ALUOpOut);
                  
                  
                  input regDstIn, ALUSourceIn, MemToRegIn, regWriteIn, MemReadIn, MemWriteIn, clk;
                  input [31:0] PCAddResultIn, ReadData1In, ReadData2In, OffsetIn;
<<<<<<< Updated upstream
                  input [20:16] RtRegIn;
                  input [15:11] RdRegIn;
                  input [1:0] BranchJumpIn, ALUOpIn;
                  output reg regDstOut, ALUSourceOut, MemToRegOut, regWriteOut, MemReadOut, MemWriteOut;
                  output reg [31:0] PCAddResultOut, ReadData1Out, ReadData2Out, OffsetOut;
                  output reg [4:0] RtRegOut, RdRegOut;
                  output reg [1:0] BranchJumpOut, ALUOpOut;
=======
                  input [4:0] RsRegIn, RtRegIn, RdRegIn;
                  input [5:0] functIn;
                  input [4:0] ALUOpIn;
                  input [2:0] BranchJumpIn; 
                  output reg regDstOut, ALUSourceOut, MemToRegOut, regWriteOut, MemReadOut, MemWriteOut;
                  output reg [31:0] PCAddResultOut, ReadData1Out, ReadData2Out, OffsetOut;
                  output reg [4:0] RsRegOut, RtRegOut, RdRegOut;
                  output reg [5:0] functOut;
                  output reg [2:0] BranchJumpOut;
                  output reg [4:0] ALUOpOut;
>>>>>>> Stashed changes

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
        RsRegOut = RsRegIn;
        RtRegOut = RtRegIn;
        RdRegOut = RdRegIn;
        BranchJumpOut = BranchJumpIn;
        ALUOpOut = ALUOpIn;
    end
endmodule