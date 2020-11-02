`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineers: Christopher Chritiansen  50%
//            Kama Svoboda             50% 

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


module Top( input Clk, Reset,
            output [6:0] out7,
            output [7:0] en_out
    );
    //debug
    (* mark_debug = "true" *)wire [31:0] Debug_Program_Counter, Debug_HI, Debug_LO, Debug_Write_Register;
 // fetchStageWires
   wire [31:0] PCResult, PCAddResult, Address, FetchedInstruction;
   reg [31:0] PCAddAmount;
   
   // seven segement wires
   wire NewClk;
   
  // decode stage wires
   wire [31:0] IDRegPCAddResult, IDRegInstruction, ReadData1, ReadData2, IDSignExtendedOffset;
   wire [15:0] IDinstructionOffset;
   wire [5:0] InstructionIn, funct;
   wire [4:0] IDALUOp, IDrs, IDrt, IDrd;
   wire [2:0] IDbranchJump;
   wire IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite;
   
   // Execute Stage wires
   wire [63:0] MultResult;
   wire [31:0] EXPCAddResult, EXReadData1, EXReadData2, EXOffset, ShiftedOffset, ALUInput, EXBranchAddress, ALUResult, RegValA, RegValB;
   wire [5:0] EXfunct;
   wire [4:0] EXALUOp, SEH;
   wire [4:0] EXrtReg, EXrsReg, EXrdReg, SelRd;
   wire [4:0] ALUcontrolWire;
   wire [2:0] EXBranchOp;
   wire [1:0] EXbranchJump, FwdCtrA, FwdCtrB;
   wire EXregDst, EXALUSource, ExMemToReg, EXregWrite, EXMemRead, EXMemWrite, zeroFlag, HiLoWrite, MultBit;
   
   //Memory Stage wires
    wire [63:0] MemMultResult;
    wire [31:0]  BranchAddress, MemALUResult,MemReadData1, MemReadData2, MemReadData, MemOffset, MulOut, LO, HI, MemResult;
    wire [4:0] MemRd;
    wire [1:0] MemBranchJump;
    wire MemregWrite, MemMemWrite, MemRegWriteResult, MemMemRead, MemMemToReg, MemZero, MemHiLoWrite, MemMultBit;
    wire [1:0] PCSrc;
  
  //WB stage wires
  wire [31:0]  MemoryOut, ALUOut, RegWriteData;
  wire [4:0] WBrd;
  wire WBRegWrite, WBMemToReg;
  
  
   
   // initial and assignemnts
    initial begin
        PCAddAmount = 4;
    end
    
    assign Debug_Write_Register = RegWriteData;

    // seven SegmentDisplay
     ClkDiv clock_divider (Clk, Reset, NewClk);
     Two4DigitDisplay two_4_digit_display(Clk, Debug_Program_Counter[15:0], Debug_Write_Register[15:0], out7, en_out);
    
    
    
     // fetch stage
    Adder PCAdder(PCResult, PCAddAmount, PCAddResult);
	ProgramCounter counter(Address, PCResult, Reset, NewClk, Debug_Program_Counter);
	InstructionMemory instructionMemory(PCResult, FetchedInstruction);
	Mux32Bit4To1 PCSrcMux(Address, PCAddResult, BranchAddress, MemOffset, MemReadData1, PCSrc); // hook up branch Control
	
	// IF/ID
	IF_ID_Reg IfIdReg(PCAddResult, FetchedInstruction, NewClk, IDRegPCAddResult, IDinstructionOffset, InstructionIn, funct, IDrs, IDrt, IDrd);
	
	// Decode Stage
	Controller control(InstructionIn, IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, IDbranchJump, IDALUOp);
	RegisterFile registers(IDrs, IDrt, WBrd, RegWriteData, WBRegWrite, NewClk, ReadData1, ReadData2, debug_reg16); // hook up Rd, writeData RegWrite from WB stage
	SignExtension signExtend(IDinstructionOffset, IDSignExtendedOffset);
	
	
	
	// ID/EX
	ID_EX_Reg IdExReg(IDRegPCAddResult, ReadData1, ReadData2, IDSignExtendedOffset, IDrs, IDrt, IDrd,
	                   IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, funct, IDbranchJump, IDALUOp, NewClk,
	                   EXPCAddResult, EXReadData1, EXReadData2, EXOffset, EXrsReg, EXrtReg, EXrdReg, EXregDst, EXALUSource, ExMemToReg, EXregWrite,
	                   EXMemRead, EXMemWrite, EXfunct, EXBranchOp, EXALUOp);
	                   
	                   assign SEH = EXOffset[10:6];
	                   
	                   //forwarding Muxes
	                   Mux32Bit4To1 forwardMuxA(RegValA, EXReadData1, MemALUResult, RegWriteData, 0, FwdCtrA);
	                   Mux32Bit4To1 forwardMuxB(RegValB, EXReadData2, MemALUResult, RegWriteData, 0, FwdCtrB);
	                   
	// Execution Stage
    Shift_Left_2 ShiftLeft2 (EXOffset, ShiftedOffset);
    Mux32Bit2To1 ALUsrcMux (ALUInput, RegValB, EXOffset, EXALUSource);
    Mux5Bit2To1 RegDstMux (SelRd, EXrdReg, EXrtReg, EXregDst);
    Adder BranchAdder (EXPCAddResult, ShiftedOffset, EXBranchAddress);
    ALUControl ALUcontroller(EXALUOp, EXfunct, SEH, ALUcontrolWire, HiLoWrite, MultBit); //EXALUOp, EXOffset, ALUcontrol
    ALU32Bit ALU(ALUcontrolWire, RegValA, ALUInput, HiLoWrite, EXrsReg, SEH, ALUResult, zeroFlag, MultResult, Debug_HI, Debug_LO);
    BranchControlModule BranchAndJumpController(EXBranchOp, RegValA, RegValB, EXrsReg, EXbranchJump, EXfunct);
    
        // forwarding Unit
        ForwardingUnit forwarding(WBRegWrite, WBrd, MemregWrite, MemRd, EXrsReg, EXrtReg, FwdCtrA, FwdCtrB);
    
    
    // EX/MEM
    EX_MEM_Reg ExMemReg(MultResult, EXBranchAddress, ALUResult, RegValB, RegValA, EXOffset, SelRd, EXregWrite, EXMemWrite, EXMemRead, EXbranchJump, ExMemToReg,
                        MultBit, HiLoWrite, zeroFlag, NewClk,
                        MemMultResult, BranchAddress, MemALUResult, MemReadData2, MemReadData1, MemOffset, MemRd, MemregWrite, MemMemWrite, MemMemRead, PCSrc, MemMemToReg,
                        MemMultBit, MemHiLoWrite, MemZero);
                        
    // Memory Access Stage
   DataMemory datamemory(MemALUResult, MemReadData2, MemMemWrite, MemMemRead, MemReadData);
   And regWriteAnd(MemZero, MemregWrite, MemRegWriteResult);
   
   multiplyUnit MU(MemMultResult, MulOut, HI, LO, MemHiLoWrite);
   HiLoRegs hiloregs(HI, LO, MemHiLoWrite, NewClk, Debug_HI, Debug_LO);
   
   Mux32Bit2To1 MultMux(MemResult, MemALUResult, MulOut, MemMultBit); 
   
   // MEM/WB
   MEM_WB_Reg MemWbReg(MemReadData, MemResult, MemRd, MemMemToReg, MemRegWriteResult, NewClk,
                       MemoryOut, ALUOut, WBrd, WBMemToReg, WBRegWrite);
                       
   // Write Back Stage
   Mux32Bit2To1 MemToRegMux(RegWriteData, MemoryOut, ALUOut, WBMemToReg);
   
    
    
endmodule
