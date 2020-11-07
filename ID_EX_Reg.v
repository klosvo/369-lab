`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
////////////////////////////////////////////////////////////////////////////////

module ID_EX_Reg(PCAddResultIn, ReadData1In, ReadData2In, OffsetIn, RsRegIn, RtRegIn, RdRegIn,
                  regDstIn, ALUSourceIn, MemToRegIn, regWriteIn, MemReadIn, MemWriteIn, jumpIn, functIn,
                 BranchJumpIn, ALUOpIn, clk, dataTypeIn,
                  PCAddResultOut, ReadData1Out, ReadData2Out, OffsetOut, RsRegOut, RtRegOut, RdRegOut,
                   regDstOut, ALUSourceOut, MemToRegOut, regWriteOut, MemReadOut, MemWriteOut, jumpOut, functOut,
                  BranchJumpOut, ALUOpOut, dataTypeOut, flush);
                  
                  
                  input regDstIn, ALUSourceIn, MemToRegIn, regWriteIn, MemReadIn, MemWriteIn, clk, flush, jumpIn;
                  input [1:0] dataTypeIn;
                  input [31:0] PCAddResultIn, ReadData1In, ReadData2In, OffsetIn;
                  input [2:0] BranchJumpIn;
                  input [4:0] ALUOpIn;
                  input [4:0] RsRegIn, RtRegIn,  RdRegIn;
                  input [5:0] functIn; 
                  output reg regDstOut, ALUSourceOut, MemToRegOut, regWriteOut, MemReadOut, MemWriteOut, jumpOut;
                  output reg [1:0] dataTypeOut;
                  output reg [31:0] PCAddResultOut, ReadData1Out, ReadData2Out, OffsetOut;
                  output reg [4:0] RsRegOut, RtRegOut, RdRegOut;
                  output reg [5:0] functOut;
                  output reg [2:0] BranchJumpOut;
                  output reg [4:0] ALUOpOut;
    initial begin
        dataTypeOut <= 2'b0;
        regDstOut <= 0;
        ALUSourceOut <= 0;
        MemToRegOut <= 0;
        regWriteOut <= 0;
        MemReadOut <= 0;
        MemWriteOut <= 0;
        PCAddResultOut <= 32'b0;
        ReadData1Out <= 32'b0;
        ReadData2Out <= 32'b0;
        OffsetOut <= 32'b0;
        RsRegOut <= 5'b0;
        RtRegOut <= 5'b0;
        RdRegOut <= 5'b0;
        BranchJumpOut <= 3'b0;
        ALUOpOut <= 5'b0;
        functOut <= 6'b0;
    end


    always @ (posedge clk) begin
        if (flush) begin
            dataTypeOut <= 2'b0;
            regDstOut <= 0;
            ALUSourceOut <= 0;
            MemToRegOut <= 0;
            regWriteOut <= 0;
            MemReadOut <= 0;
            MemWriteOut <= 0;
            PCAddResultOut <= 32'b0;
            ReadData1Out <= 32'b0;
            ReadData2Out <= 32'b0;
            OffsetOut <= 32'b0;
            RsRegOut <= 5'b0;
            RtRegOut <= 5'b0;
            RdRegOut <= 5'b0;
            BranchJumpOut <= 3'b0;
            ALUOpOut <= 5'b0;
            functOut <= 6'b0;
        end
        else begin
            dataTypeOut <= dataTypeIn;
            regDstOut <= regDstIn;
            ALUSourceOut <= ALUSourceIn;
            MemToRegOut <= MemToRegIn;
            regWriteOut <= regWriteIn;
            MemReadOut <= MemReadIn;
            MemWriteOut <= MemWriteIn;
            PCAddResultOut <= PCAddResultIn;
            ReadData1Out <= ReadData1In;
            ReadData2Out <= ReadData2In;
            OffsetOut <= OffsetIn;
            RsRegOut <= RsRegIn;
            RtRegOut <= RtRegIn;
            RdRegOut <= RdRegIn;
            jumpOut <= jumpIn;
            BranchJumpOut <= BranchJumpIn;
            ALUOpOut <= ALUOpIn;
            functOut <= functIn;
        end
    end
endmodule