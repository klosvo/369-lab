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
        WBRegWrite, WBrd, MemRegWrite, Memrd, EXrs, EXrt, ControlA, ControlB
    );
    input WBRegWrite, MemRegWrite;
    input [4:0] WBrd, Memrd, EXrs, EXrt;
    output reg[1:0] ControlA, ControlB;
    
    initial begin 
        ControlA <= 0;
        ControlB <= 0;
    end
    
    always @ * begin
        if (MemRegWrite & ~(Memrd == 0) & (Memrd == EXrs)) begin
        ControlA <= 1;
        end
        else if (WBRegWrite & ~(WBrd == 0) & (WBrd == EXrs))  begin
        ControlA <= 2;
        end
        else ControlA <= 0;
        
        if (MemRegWrite & ~(Memrd == 0) & (Memrd == EXrt)) begin
        ControlB <= 1;
        end
        else if (WBRegWrite & ~(WBrd == 0) & (WBrd == EXrt))  begin
        ControlB <= 2;
        end
        else ControlB <= 0;
        
        
    end
    
    
endmodule
