`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineers: Christopher Chritiansen  50%
//            Kama Svoboda             50% 
// 
// Create Date: 11/02/2020 02:05:34 PM
// Design Name: 
// Module Name: Datapath
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


module Datapath(Clk, Reset, PCResult, RegWriteData);
    
    input Clk, Reset;
    output [31:0] PCResult, RegWriteData;
    
    //debug
    (* mark_debug = "true" *)wire [31:0] Debug_Program_Counter, Debug_HI, Debug_LO, Debug_Write_Register;
 
 // fetchStageWires
   wire [31:0] PCAddResult, Address, FetchedInstruction;
   reg [31:0] PCAddAmount;
   
  // decode stage wires
   wire [31:0] IDRegPCAddResult, IDRegInstruction, ReadData1, ReadData2, IDSignExtendedOffset;
   wire [15:0] IDinstructionOffset;
   wire [5:0] InstructionIn, funct;
   wire [4:0] IDALUOp, IDrs, IDrt, IDrd;
   wire [2:0] IDbranchJump;
   wire [1:0] IDdataType;
   wire IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, IFIDWrite, PCWrite, FlushIFID, FlushIDEX, mulOp;
   
   // Execute Stage wires
   wire [63:0] MultResult;
   wire [31:0] EXPCAddResult, EXReadData1, EXReadData2, EXOffset, ShiftedOffset, ALUInput, EXBranchAddress, ALUResult, RegValA, RegValB;
   wire [5:0] EXfunct;
   wire [4:0] EXALUOp, SEH;
   wire [4:0] EXrtReg, EXrsReg, EXrdReg, SelRd;
   wire [4:0] ALUcontrolWire;
   wire [2:0] EXBranchOp;
   wire [1:0] EXbranchJump, FwdCtrA, FwdCtrB, EXdataType;
   wire EXregDst, EXALUSource, ExMemToReg, EXregWrite, EXMemRead, EXMemWrite, zeroFlag, HiLoWrite, MultBit;
   
   //Memory Stage wires
    wire [63:0] MemMultResult;
    wire [31:0]  BranchAddress, MemALUResult,MemReadData1, MemReadData2, MemReadData, MemOffset, MulOut, LO, HI, MemResult;
    wire [4:0] MemRd;
    wire [1:0] MemBranchJump, DataType;
    wire MemregWrite, MemMemWrite, MemRegWriteResult, MemMemRead, MemMemToReg, MemZero, MemHiLoWrite, MemMultBit;
    wire [1:0] PCSrc;
  
  //WB stage wires
  wire [31:0]  MemoryOut, ALUOut;
  wire [4:0] WBrd;
  wire WBRegWrite, WBMemToReg;
  
   
   // initial and assignemnts
    initial begin
        PCAddAmount = 4;
    end
    assign Debug_Write_Register = RegWriteData;
    
    
     // fetch stage
    Adder PCAdder(PCResult, PCAddAmount, PCAddResult);
	ProgramCounter counter(Address, PCWrite, PCResult, Reset, Clk, Debug_Program_Counter);
	InstructionMemory instructionMemory(PCResult, FetchedInstruction);
	Mux32Bit4To1 PCSrcMux(Address, PCAddResult, BranchAddress, MemOffset, MemReadData1, PCSrc); // hook up branch Control
	
	// IF/ID
	IF_ID_Reg IfIdReg(PCAddResult, FetchedInstruction, Clk, IFIDWrite, FlushIFID, IDRegPCAddResult, IDinstructionOffset, InstructionIn, funct, IDrs, IDrt, IDrd);
	
	// Decode Stage
	Controller control(InstructionIn, funct, IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, IDbranchJump, IDALUOp, mulOp, IDdataType);
	RegisterFile registers(IDrs, IDrt, WBrd, RegWriteData, WBRegWrite, Clk, ReadData1, ReadData2); // hook up Rd, writeData RegWrite from WB stage
	SignExtension signExtend(IDinstructionOffset, IDSignExtendedOffset);
	
	  // hazard detection unit
     HazardDetection hazard(PCSrc, EXMemRead, EXrtReg, IDrs, IDrt, FlushIFID, FlushIDEX, IFIDWrite, PCWrite, mulOp);
	
//	    input [1:0] branch;
//    input IDEXMemRead, MulOp;
//    input [4:0] IDEXrt, IFIDrs, IFIDrt;
    
//    reg stallagain;
    
//    output reg IFIDFlush, IDEXFlush, IFIDWrite, PCWrite;
	
	
	// mux for control signals that depend on hazard detection unit
    //Mux16Bit2to1 controlMux(MuxControlOut, 16'b0, ControlOut, MuxSig);

	
	// ID/EX
	ID_EX_Reg IdExReg(IDRegPCAddResult, ReadData1, ReadData2, IDSignExtendedOffset, IDrs, IDrt, IDrd,
	                    IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, funct, IDbranchJump, IDALUOp, Clk, IDdataType,
	                   EXPCAddResult, EXReadData1, EXReadData2, EXOffset, EXrsReg, EXrtReg, EXrdReg, EXregDst, EXALUSource, ExMemToReg, EXregWrite,
	                    EXMemRead, EXMemWrite, EXfunct, EXBranchOp, EXALUOp, EXdataType, FlushIDEX);
	                   
	                   assign SEH = EXOffset[10:6];
	                   
	                   //forwarding Muxes
	                   Mux32Bit4To1 forwardMuxA(RegValA, EXReadData1, MemALUResult, RegWriteData, 0, FwdCtrA);
	                   Mux32Bit4To1 forwardMuxB(RegValB, EXReadData2, MemALUResult, RegWriteData, 0, FwdCtrB);
	                   
	// Execution Stage
    Shift_Left_2 ShiftLeft2 (EXOffset, ShiftedOffset);
    Mux32Bit2To1 ALUsrcMux (ALUInput, EXReadData2, EXOffset, EXALUSource);
    
    Mux5Bit2To1 RegDstMux (SelRd, EXrdReg, EXrtReg, EXregDst);
    Adder BranchAdder (EXPCAddResult, ShiftedOffset, EXBranchAddress);
    ALUControl ALUcontroller(EXALUOp, EXfunct, SEH, ALUcontrolWire, HiLoWrite, MultBit); //EXALUOp, EXOffset, ALUcontrol
    ALU32Bit ALU(ALUcontrolWire, RegValA, ALUInput, HiLoWrite, EXrsReg, SEH, ALUResult, zeroFlag, MultResult, Debug_HI, Debug_LO);
    BranchControlModule BranchAndJumpController(EXBranchOp, RegValA, RegValB, EXrsReg, EXbranchJump, EXfunct);
    
        // forwarding Unit
        ForwardingUnit forwarding(WBRegWrite, WBrd, MemregWrite, MemRd, EXrsReg, EXrtReg, FwdCtrA, FwdCtrB);
    
    
    // EX/MEM
    EX_MEM_Reg ExMemReg(MultResult, EXBranchAddress, ALUResult, RegValB, RegValA, EXOffset, SelRd, EXregWrite, EXMemWrite, EXMemRead, EXbranchJump, EXdataType, ExMemToReg,
                        MultBit, HiLoWrite, zeroFlag, Clk,
                        MemMultResult, BranchAddress, MemALUResult, MemReadData2, MemReadData1, MemOffset, MemRd, MemregWrite, MemMemWrite, MemMemRead, PCSrc, DataType, MemMemToReg,
                        MemMultBit, MemHiLoWrite, MemZero);
                        
    // Memory Access Stage
   DataMemory datamemory(MemALUResult, MemReadData2, Clk, MemMemWrite, MemMemRead, DataType, MemReadData);
   And regWriteAnd(MemZero, MemregWrite, MemRegWriteResult);
   multiplyUnit MU(MemMultResult, MulOut, HI, LO, MemHiLoWrite);
   HiLoRegs hiloregs(HI, LO, MemHiLoWrite, Clk, Debug_HI, Debug_LO);
   Mux32Bit2To1 MultMux(MemResult, MemALUResult, MulOut, MemMultBit); 
   
   // MEM/WB
   MEM_WB_Reg MemWbReg(MemReadData, MemResult, MemRd, MemMemToReg, MemRegWriteResult, Clk,
                       MemoryOut, ALUOut, WBrd, WBMemToReg, WBRegWrite);
                       
   // Write Back Stage
   Mux32Bit2To1 MemToRegMux(RegWriteData, MemoryOut, ALUOut, WBMemToReg);
    
endmodule