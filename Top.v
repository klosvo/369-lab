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
// Additional Comments: The Datapath is a 5 Stage pipeline, with branches resolved in the MEM stage
//                      There is forwarding from MEM and WB to EX, and from WB to ID.
//                      The mult operation takes two clock cycles and is resolved in MEM stage
//////////////////////////////////////////////////////////////////////////////////


module Top( input Clk, Reset,
            output [6:0] out7,
            output [7:0] en_out
    );
    //debug
    (* mark_debug = "true" *)wire [31:0] Debug_Program_Counter, Debug_HI, Debug_LO, Debug_Write_Register, Debug_V0, Debug_V1;
 // fetchStageWires
   wire [31:0] PCResult, PCAddResult, Address, FetchedInstruction;
   reg [31:0] PCAddAmount;
   
   // seven segement wires
   wire NewClk;
   
  // decode stage wires
   wire [31:0] IDRegPCAddResult, RegData1, IDRegInstruction, ReadData1, ReadData2, DataOut1, DataOut2, IDSignExtendedOffset,IDSignExtended, IDzeroExtended;
   wire [15:0] IDinstructionOffset;
   wire [5:0] InstructionIn, funct;
   wire [4:0] IDALUOp, IDrs, IDrt, IDrd;
   wire [2:0] IDbranchJump;
   wire [1:0] IDdataType;
   wire IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, IFIDWrite, PCWrite, FlushIFID, FlushIDEX, FlushEXMEM, mulOp, ZeroExtendBit, JalBit;
   
   // Execute Stage wires
   wire [63:0] MultResult;
   wire [31:0] EXPCAddResult, EXReadData1, EXReadData2, EXOffset, ShiftedOffset, ALUInput, EXBranchAddress, ALUResult, RegValA, RegValB;
   wire [5:0] EXfunct;
   wire [4:0] EXALUOp, SEH;
   wire [4:0] EXrtReg, EXrsReg, EXrdReg, RegSel, SelRd;
   wire [4:0] ALUcontrolWire;
   wire [2:0] EXBranchOp;
   wire [1:0] EXbranchJump, FwdCtrA, FwdCtrB, EXdataType;
   wire EXregDst, EXALUSource, ExMemToReg, EXregWrite, EXMemRead, EXMemWrite, zeroFlag, HiLoWrite, MultBit, FwdCtrC, FwdCtrD;
   wire EXjalBit, EXmulOp;
   
   //Memory Stage wires
    wire [63:0] MemMultResult;
    wire [31:0]  BranchAddress, JumpAddressShifted, MemALUResult,MemReadData1, MemReadData2, MemReadData, MemOffset, MulOut, LO, HI, MemResult;
    wire [4:0] MemRd, MEMrs, MEMrt;
    wire [1:0] MemBranchJump, DataType;
    wire MemregWrite, MemMemWrite, MemRegWriteResult, MemMemRead, MemMemToReg, MemZero, MemHiLoWrite, MemMultBit, MemALUSource;
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

    // sevenSegment Display
     ClkDiv clock_divider (Clk, Reset, NewClk);
     Two4DigitDisplay two_4_digit_display(Clk, Debug_V0[15:0], Debug_V1[15:0], out7, en_out);
     //assign NewClk = Clk;
     
   
        
    //todo add mux
    assign Debug_Program_Counter = Address;
    
     // fetch stage
    Adder PCAdder(PCResult, PCAddAmount, PCAddResult);
  ProgramCounter counter(Address, PCWrite, PCResult, Reset, NewClk);
  InstructionMemory instructionMemory(PCResult, FetchedInstruction);
  Mux32Bit4To1 PCSrcMux(Address, PCAddResult, BranchAddress, JumpAddressShifted, MemReadData1, PCSrc); 
  Shift_Left_2 addressShifter(MemOffset, JumpAddressShifted);
  
  // IF/ID
  IF_ID_Reg IfIdReg(PCAddResult, FetchedInstruction, NewClk, IFIDWrite, FlushIFID, IDRegPCAddResult, IDinstructionOffset, InstructionIn, funct, IDrs, IDrt, IDrd);
  
  // Decode Stage
  Controller control(InstructionIn, funct, IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, IDbranchJump, IDALUOp, mulOp, ZeroExtendBit, IDdataType, JalBit);
  RegisterFile registers(IDrs, IDrt, WBrd, RegWriteData, WBRegWrite, NewClk, ReadData1, ReadData2, Debug_V0, Debug_V1); // hook up Rd, writeData RegWrite from WB stage
  SignExtension signExtend(IDinstructionOffset, IDSignExtended);
  zeroExtension zeroExtend(IDinstructionOffset, IDzeroExtended);
  
  
  
  Mux32Bit2To1 signExtendMux(IDSignExtendedOffset, IDSignExtended, IDzeroExtended, ZeroExtendBit);
  
    // hazard detection unit
     HazardDetection hazard(PCSrc, EXMemRead, EXregWrite, EXrdReg, EXrtReg, IDrs, IDrt, FlushIFID, FlushIDEX, FlushEXMEM, IFIDWrite, PCWrite, EXmulOp);
  
  // mux for control signals that depend on hazard detection unit
    //Mux16Bit2to1 controlMux(MuxControlOut, 16'b0, ControlOut, MuxSig);
    
    //forwarding muxes
    Mux32Bit2To1 forwardingMuxC(RegData1, ReadData1, RegWriteData, FwdCtrC);
    Mux32Bit2To1 forwardingMuxD(DataOut2, ReadData2, RegWriteData, FwdCtrD);

//jal data mux
Mux32Bit2To1 jalDataMux(DataOut1, RegData1, PCAddResult, JalBit);
    
  // ID/EX
  ID_EX_Reg IdExReg(IDRegPCAddResult, DataOut1, DataOut2, IDSignExtendedOffset, IDrs, IDrt, IDrd,
                      IDregDst, IDALUSource, IDMemToReg, IDregWrite, IDMemRead, IDMemWrite, funct, IDbranchJump, IDALUOp, mulOp, JalBit, NewClk, IDdataType,
                     EXPCAddResult, EXReadData1, EXReadData2, EXOffset, EXrsReg, EXrtReg, EXrdReg, EXregDst, EXALUSource, ExMemToReg, EXregWrite,
                      EXMemRead, EXMemWrite, EXfunct, EXBranchOp, EXALUOp, EXmulOp, EXjalBit, EXdataType, FlushIDEX);
                     
                     assign SEH = EXOffset[10:6];
                     
                     
                     
  // Execution Stage

    Shift_Left_2 ShiftLeft2 (EXOffset, ShiftedOffset);
    Mux32Bit2To1 ALUsrcMux (ALUInput, RegValB, EXOffset, EXALUSource);
    
                     //forwarding Muxes
                     Mux32Bit4To1 forwardMuxA(RegValA, EXReadData1, MemALUResult, RegWriteData, 0, FwdCtrA);
                     Mux32Bit4To1 forwardMuxB(RegValB, EXReadData2, MemALUResult, RegWriteData, 0, FwdCtrB);
    
    Mux5Bit2To1 RegDstMux (RegSel, EXrdReg, EXrtReg, EXregDst);
    Mux5Bit2To1 JalDstMux (SelRd, RegSel, 31, EXjalBit); 
    Adder BranchAdder (EXPCAddResult, ShiftedOffset, EXBranchAddress);
    ALUControl ALUcontroller(EXALUOp, EXfunct, SEH, ALUcontrolWire, HiLoWrite, MultBit); //EXALUOp, EXOffset, ALUcontrol
    ALU32Bit ALU(ALUcontrolWire, RegValA, ALUInput, HiLoWrite, EXrsReg, SEH, ALUResult, zeroFlag, MultResult, Debug_HI, Debug_LO);
    BranchControlModule BranchAndJumpController(EXBranchOp, RegValA, RegValB, EXrtReg, EXbranchJump, EXfunct);
    
        // forwarding Unit
        ForwardingUnit forwarding(WBRegWrite, WBrd, MemregWrite, MemRd,EXrsReg, EXrtReg, IDrs, IDrt, IDALUSource, EXALUSource, 
                                  IDMemWrite, EXMemWrite, FwdCtrA, FwdCtrB, FwdCtrC, FwdCtrD);
    
    
    // EX/MEM
    EX_MEM_Reg ExMemReg(MultResult, EXBranchAddress, ALUResult, RegValB, RegValA, EXOffset, SelRd, EXregWrite, 
                        EXMemWrite, EXMemRead, EXbranchJump, EXdataType, ExMemToReg,MultBit, HiLoWrite, zeroFlag, NewClk, FlushEXMEM,
                        MemMultResult, BranchAddress, MemALUResult, MemReadData2, MemReadData1, MemOffset, MemRd, MemregWrite, 
                        MemMemWrite, MemMemRead, PCSrc, DataType, MemMemToReg, MemMultBit, MemHiLoWrite, MemZero);
                        
    // Memory Access Stage
   DataMemory datamemory(MemALUResult, MemReadData2, MemMemWrite, MemMemRead, DataType, MemReadData, clk);
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