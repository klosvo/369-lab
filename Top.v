`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 02:15:38 PM
// Design Name: 
// Module Name: Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top(
    input Clk, Reset
    );
    reg [31:0] PCAddAmount;
    wire NewClk;
    wire PCSrc;
    wire [31:0] FetchedInstruction, PCAddResult, PCResult, Address;
    wire [31:0] IDRegInstruction;
    wire [31:0] IDRegPCAddResult;
    wire IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite;
    wire EXregDst, EXALUSource, EXMemToReg, EXregWrite, EXMemRead, EXMemWrite;
    wire [1:0] IDbranchJump, IDALUOp;
    wire [1:0] EXbranchJump, EXALUOp;
    wire [31:0] ReadData1, ReadData2;
    wire [31:0] Debug_reg16;
    wire [31:0] IDSignExtendedOffset;
    wire [31:0] EXPCAddResult, EXReadData1, EXReadData2, EXOffset;
    wire [4:0] EXrtReg, EXrdReg, SelRd;
    wire [31:0] ShiftedOffset;
    wire [31:0] ALUInput, ALUResult;
    wire [31:0] EXbranchAddress, BranchAdress;
    wire [3:0] ALUcontrol;
    wire [31:0] MemALUResult, MemReadData2, MemReadData;
    wire [4:0] MemRd, WBrd;
    wire MemregWrite, MemMemWrite, MemMemRead, MemMemToReg, MemZero;
    wire [1:0] MemBranchJump;
    wire zeroFlag, WBMemToReg, WBRegWrite;
    wire [31:0] MemoryOut, ALUOut, RegWriteData;
        
    initial begin
        PCAddAmount = 4;
    end
    
    // input modules
    ClkDiv clock_divider (Clk, Reset, NewClk);
    // fetch stage
    Adder PCAdder(PCResult, PCAddAmount, PCAddResult);
	ProgramCounter counter(Address, PCResult, Reset, NewClk);
	InstructionMemory instructionMemory(PCResult, FetchedInstruction);
	Mux32Bit2To1 PCSrcMux(Address, PCAddResult, BranchAddress, PCSrc); // TODO: hook up second source
	
	// IF/ID
	IF_ID_Reg IfIdReg(PCAddResult, FetchedInstruction, NewClk, IDRegPCAddResult, IDRegInstruction);

	
	
	// Decode Stage
	Controller control(IDRegInstruction, IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, IDbranchJump, IDALUOp);
	RegisterFile registers(IDRegInstruction, IDRegInstruction, WBrd, RegWriteData, WBRegWrite, Clk, ReadData1, ReadData2, debug_reg16); // hook up Rd, writeData RegWrite from WB stage
	SignExtension signExtend(IDRegInstruction, IDSignExtendedOffset);
	
	// ID/EX
	ID_EX_Reg IdExReg(IDRegPCAddResult, ReadData1, ReadData2, IDSignExtendedOffset, IDRegInstruction, IDRegInstruction,
	                   IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, IDbranchJump, IDALUOp, NewClk,
	                   EXPCAddResult, EXReadData1, EXReadData2, EXOffset, EXrsReg, EXrdReg, EXregDst, EXALUSource, ExMemToReg, EXregWrite,
	                   EXMemRead, EXMemWrite, EXbranchJump, EXALUOp);
	                   
    // Execution Stage
    Shift_Left_2 ShiftLeft2 (EXOffset, ShiftedOffset);
    Mux32Bit2To1 ALUsrcMux (ALUInput, EXReadData2, EXOffset, EXALUSource);
    Mux5Bit2To1 RegDstMux (SelRd, EXrsReg, EXrdReg, EXregDst);
    Adder BranchAdder (EXPCAddResult, ShiftedOffset, EXBranchAddress);
    ALUControl ALUcontroller(EXALUOp, EXOffset, ALUcontrol);
    ALU32Bit ALU(ALUcontrol, EXReadData1, ALUInput, ALUResult, zeroFlag);
    
    // EX/MEM
    EX_MEM_Reg ExMemReg(EXBranchAddress, ALUResult, EXReadData2, SelRd, EXregWrite, EXMemWrite, EXMemRead, EXbranchJump, ExMemToReg, zeroFlag, NewClk,
                        BranchAddress, MemALUResult, MemReadData2, MemRd, MemregWrite, MemMemWrite, MemMemRead, MemBranchJump, MemMemToReg, MemZero);
                        
   // Memory Access Stage
   DataMemory datamemory(MemALUResult, MemReadData2, NewClk, MemMemWrite, MemMemRead, MemReadData);
   BranchAnd BAnd(MemBranchJump, MemZero, PCSrc);
   
   // MEM/WB
   MEM_WB_Reg MemWbReg(MemReadData, MemALUResult, MemRd, MemMemToReg, MemregWrite, NewClk,
                       MemoryOut, ALUOut, WBrd, WBMemToReg, WBRegWrite);
                       
   // Write Back Stage
   Mux32Bit2To1 MemToRegMux(RegWriteData, MemoryOut, ALUOut, WBMemToReg);
   
    
    
endmodule
