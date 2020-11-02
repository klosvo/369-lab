`timescale 1ns / 1ps


//INCOMPLETE
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
////////////////////////////////////////////////////////////////////////////////

module ID_EX_Reg(PCAddResultIn, ReadData1In, ReadData2In, OffsetIn, RsRegIn, RtRegIn, RdRegIn,
                  ControlSig, functIn, clk,
                  PCAddResultOut, ReadData1Out, ReadData2Out, OffsetOut, RsRegOut, RtRegOut, RdRegOut,
                  dataType, regDstOut, ALUSourceOut, MemToRegOut, regWriteOut, MemReadOut, MemWriteOut, functOut,
                  BranchJumpOut, ALUOpOut);              
                    
                  //input regDstIn, ALUSourceIn, MemToRegIn, regWriteIn, MemReadIn, MemWriteIn, 
                  input clk;
                  input [31:0] PCAddResultIn, ReadData1In, ReadData2In, OffsetIn;
                  input [15:0] ControlSig;
                  input [4:0] RsRegIn, RtRegIn,  RdRegIn;
                  input [5:0] functIn; 
                  output reg regDstOut, ALUSourceOut, MemToRegOut, regWriteOut, MemReadOut, MemWriteOut;
                  output reg [1:0] dataType;
                  output reg [31:0] PCAddResultOut, ReadData1Out, ReadData2Out, OffsetOut;
                  output reg [4:0] RsRegOut, RtRegOut, RdRegOut;
                  output reg [5:0] functOut;
                  output reg [2:0] BranchJumpOut;
                  output reg [4:0] ALUOpOut;
                  // Control Out = {IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, IDbranchJump, IDALUOp}; 

    always @ (posedge clk) begin
        dataType = ControlSig[15:14];
        regDstOut = ControlSig[13];
        ALUSourceOut = ControlSig[12];
        MemToRegOut = ControlSig[11];
        regWriteOut= ControlSig[10];
        MemReadOut = ControlSig[9];
        MemWriteOut = ControlSig[8];
        PCAddResultOut = PCAddResultIn;
        ReadData1Out = ReadData1In;
        ReadData2Out = ReadData2In;
        OffsetOut = OffsetIn;
        RsRegOut = RsRegIn;
        RtRegOut = RtRegIn;
        RdRegOut = RdRegIn;
        BranchJumpOut = ControlSig[7:5];
        ALUOpOut = ControlSig[4:0];
        functOut = functIn;
    end
endmodule