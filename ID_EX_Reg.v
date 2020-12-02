`timescale 1ns / 1ps


////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
////////////////////////////////////////////////////////////////////////////////

module ID_EX_Reg(PCAddResultIn, ReadData1In, ReadData2In, OffsetIn, RsRegIn, RtRegIn, RdRegIn,
                  regDstIn, ALUSourceIn, MemToRegIn, regWriteIn, MemReadIn, MemWriteIn, functIn,
                 BranchJumpIn, ALUOpIn, mulOpIn, jalBitIn, clk, dataTypeIn,
                  PCAddResultOut, ReadData1Out, ReadData2Out, OffsetOut, RsRegOut, RtRegOut, RdRegOut,
                   regDstOut, ALUSourceOut, MemToRegOut, regWriteOut, MemReadOut, MemWriteOut, functOut,
                  BranchJumpOut, ALUOpOut, mulOpOut, jalBitOut, dataTypeOut, flush);
                  
                  
                  input regDstIn, ALUSourceIn, MemToRegIn, regWriteIn, MemReadIn, MemWriteIn, mulOpIn, jalBitIn, clk, flush;
                  input [1:0] dataTypeIn;
                  input [31:0] PCAddResultIn, ReadData1In, ReadData2In, OffsetIn;
                  input [2:0] BranchJumpIn;
                  input [4:0] ALUOpIn;
//                  input [15:0] ControlSig;
                  input [4:0] RsRegIn, RtRegIn,  RdRegIn;
                  input [5:0] functIn; 
                  output reg regDstOut, ALUSourceOut, MemToRegOut, regWriteOut, MemReadOut, MemWriteOut, mulOpOut, jalBitOut;
                  output reg [1:0] dataTypeOut;
                  output reg [31:0] PCAddResultOut, ReadData1Out, ReadData2Out, OffsetOut;
                  output reg [4:0] RsRegOut, RtRegOut, RdRegOut;
                  output reg [5:0] functOut;
                  output reg [2:0] BranchJumpOut;
                  output reg [4:0] ALUOpOut;
                  // Control Out = {IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, IDbranchJump, IDALUOp}; 

    always @ (posedge clk) begin
    if (flush) begin
        dataTypeOut = 0;
        regDstOut = 0;
        ALUSourceOut = 0;
        MemToRegOut = 0;
        regWriteOut= 0;
        MemReadOut = 0;
        MemWriteOut = 0;
        PCAddResultOut = 0;
        ReadData1Out = 0;
        ReadData2Out = 0;
        OffsetOut = 0;
        RsRegOut = 0;
        RtRegOut = 0;
        RdRegOut = 0;
        BranchJumpOut = 0;
        ALUOpOut = 0;
        functOut = 0;
        mulOpOut = 0;
        jalBitOut = 0;
    end
    else begin
        dataTypeOut = dataTypeIn;
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
        functOut = functIn;
        mulOpOut = mulOpIn;
        jalBitOut = jalBitIn;
        end
    end
endmodule