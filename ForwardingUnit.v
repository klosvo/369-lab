`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2020 02:04:52 PM
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(
        WBRegWrite, WBrd, MemRegWrite, Memrd, EXrs, EXrt, IDrs, IDrt, IDimmBit, EXimmBit, IDMemWrite, EXMemWrite, ControlA, ControlB, ControlC, ControlD
    );
    input WBRegWrite, MemRegWrite, IDimmBit, EXimmBit, IDMemWrite, EXMemWrite;
    input [4:0] WBrd, Memrd, EXrs, EXrt, IDrs, IDrt;
    output reg[1:0] ControlA, ControlB;
    output reg ControlC, ControlD;
    
    initial begin 
        ControlA <= 0;
        ControlB <= 0;
    end
    
    always @ * begin
        //forwarding from Mem and WB to EX
        if (MemRegWrite & ~(Memrd == 0) & (Memrd == EXrs)) begin
        ControlA <= 1;
        end
        else if (WBRegWrite & ~(WBrd == 0) & (WBrd == EXrs))  begin
        ControlA <= 2;
        end
        else ControlA <= 0;
        
        if (MemRegWrite & (~EXimmBit | EXMemWrite) & ~(Memrd == 0) & (Memrd == EXrt)) begin
        ControlB <= 1;
        end
        else if (WBRegWrite & (~EXimmBit | EXMemWrite) & ~(WBrd == 0) & (WBrd == EXrt))  begin
        ControlB <= 2;
        end
        else ControlB <= 0;
        
        // forwarding from WB to ID
        if (WBRegWrite & ~(WBrd == 0) & (WBrd == IDrs)) begin
        ControlC <= 1;
        end
        else ControlC <= 0;
        
        if (WBRegWrite & (~IDimmBit | IDMemWrite) & ~(WBrd == 0) & (WBrd == IDrt)) begin
            ControlD <= 1;
        end
        else ControlD <= 0;
        
       
        
    end
    
    
endmodule
