`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - PCAdder.v
// Description - 32-Bit program counter (PC) adder.
// 
// INPUTS:-
// PCResult: 32-Bit input port.
// 
// OUTPUTS:-
// PCAddResult: 32-Bit output port.
//
// FUNCTIONALITY:-
// Design an incrementor by 4 
// (a hard-wired ADDER whose first input is from the PCResult, and 
// second input is a hard-wired value of 4 that outputs PCResult + 4. 
// The result should always be an increment of the signal 'PCResult' by 4 (i.e., PCAddResult = PCResult + 4).
////////////////////////////////////////////////////////////////////////////////

module Adder(InputA, InputB, AddResult);

    input [31:0] InputA, InputB;

    output reg [31:0] AddResult;
    
    always @(InputA, InputB)
    begin
        AddResult <= InputA + InputB;
    end
    
endmodule

