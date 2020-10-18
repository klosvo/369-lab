`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2020 08:02:41 PM
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


module Top( input Clk, Reset
    );
    //debug
    (* mark_debug = "true" *)wire [31:0] Debug_Program_Counter, Debug_HI, Debug_LO, Debug_Write_Register;
 // fetchStageWires
   wire [31:0] PCResult, PCAddResult, Address, FetchedInstruction;
   reg [31:0] PCAddAmount;
   
  // decode stage wires
   wire [31:0] IDRegPCAddResult, IDRegInstruction, ReadData1, ReadData2, IDSignExtendedOffset;
   wire [15:0] IDinstructionOffset;
   wire [5:0] InstructionIn, funct;
   wire [4:0] IDALUOp, IDrs, IDrt, IDrd;
   wire [1:0] IDbranchJump;
   wire IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite;
   
   // Execute Stage wires
   wire [31:0] EXPCAddResult, EXReadData1, EXReadData2, EXOffset, ShiftedOffset, ALUInput, EXBranchAddress, ALUResult;
   wire [4:0] EXALUOp;
   wire [4:0] EXrsReg, EXrdReg, SelRd;
   wire [4:0] ALUcontrolWire;
   wire [1:0] EXbranchJump;
   wire EXregDst, EXALUSource, ExMemToReg, EXregWrite, EXMemRead, EXMemWrite, zeroFlag;
   
   //Memory Stage wires
    wire [31:0]  BranchAddress, MemALUResult, MemReadData2, MemReadData;
    wire [4:0] MemRd;
    wire [1:0] MemBranchJump;
    wire MemregWrite, MemMemWrite, MemMemRead, MemMemToReg, MemZero, PCSrc;
  
  //WB stage wires
  wire [31:0]  MemoryOut, ALUOut, RegWriteData;
  wire [4:0] WBrd;
  wire WBRegWrite, WBMemToReg;
  
  
   
   // initial and assignemnts
    initial begin
        PCAddAmount = 4;
    end
    
    assign Debug_Write_Register = RegWriteData;

    
     // fetch stage
    Adder PCAdder(PCResult, PCAddAmount, PCAddResult);
	ProgramCounter counter(Address, PCResult, Reset, Clk, Debug_Program_Counter);
	InstructionMemory instructionMemory(PCResult, FetchedInstruction);
	Mux32Bit2To1 PCSrcMux(Address, PCAddResult, BranchAddress, PCSrc); // hook up branch Control
	
	// IF/ID
	IF_ID_Reg IfIdReg(PCAddResult, FetchedInstruction, Clk, IDRegPCAddResult, IDinstructionOffset, InstructionIn, funct, IDrs, IDrt, IDrd);
	
	// Decode Stage
	Controller control(InstructionIn, IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, IDbranchJump, IDALUOp);
	RegisterFile registers(IDrs, IDrt, WBrd, RegWriteData, WBRegWrite, Clk, ReadData1, ReadData2, debug_reg16); // hook up Rd, writeData RegWrite from WB stage
	SignExtension signExtend(IDinstructionOffset, IDSignExtendedOffset);
	
	// ID/EX
	ID_EX_Reg IdExReg(IDRegPCAddResult, ReadData1, ReadData2, IDSignExtendedOffset, IDrt, IDrd,
	                   IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, IDbranchJump, IDALUOp,Clk,
	                   EXPCAddResult, EXReadData1, EXReadData2, EXOffset, EXrsReg, EXrdReg, EXregDst, EXALUSource, ExMemToReg, EXregWrite,
	                   EXMemRead, EXMemWrite, EXbranchJump, EXALUOp);
	                   
	// Execution Stage
    Shift_Left_2 ShiftLeft2 (EXOffset, ShiftedOffset);
    Mux32Bit2To1 ALUsrcMux (ALUInput, EXReadData2, EXOffset, EXALUSource);
    Mux5Bit2To1 RegDstMux (SelRd, EXrdReg, EXrsReg, EXregDst);
    Adder BranchAdder (EXPCAddResult, ShiftedOffset, EXBranchAddress);
    ALUControl ALUcontroller(EXALUOp, EXOffset, ALUcontrolWire); //EXALUOp, EXOffset, ALUcontrol
    ALU32Bit ALU(ALUcontrolWire, EXReadData1, ALUInput, ALUResult, zeroFlag, Debug_LO, Debug_HI);
    
    
    // EX/MEM
    EX_MEM_Reg ExMemReg(EXBranchAddress, ALUResult, EXReadData2, SelRd, EXregWrite, EXMemWrite, EXMemRead, EXbranchJump, ExMemToReg, zeroFlag, Clk,
                        BranchAddress, MemALUResult, MemReadData2, MemRd, MemregWrite, MemMemWrite, MemMemRead, MemBranchJump, MemMemToReg, MemZero);
                        
    // Memory Access Stage
   DataMemory datamemory(MemALUResult, MemReadData2, MemMemWrite, MemMemRead, MemReadData);
   BranchAnd BAnd(MemBranchJump, MemZero, PCSrc);
   
   // MEM/WB
   MEM_WB_Reg MemWbReg(MemReadData, MemALUResult, MemRd, MemMemToReg, MemregWrite, Clk,
                       MemoryOut, ALUOut, WBrd, WBMemToReg, WBRegWrite);
                       
   // Write Back Stage
   Mux32Bit2To1 MemToRegMux(RegWriteData, MemoryOut, ALUOut, WBMemToReg);
   
    
    
endmodule
