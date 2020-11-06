`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - data_memory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.   
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, dataType, ReadData); 

    input Clk;
    input [31:0] Address;   // Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 
    input [1:0] dataType;    // 2 bits indicating whether it is byte, halfword, or word

    output reg[31:0] ReadData; // Contents of memory location at Address

    reg [31:0] memory [0:1023];
    
    initial begin
            memory[0] = 32'h30e;    // 782
            memory[1] = 32'h149B;   // 5259
            memory[2] = 32'h369;    // 873
            memory[3] = 32'h23e;    // 574
            memory[4] = 32'h1eb;    // 491
            memory[5] = 32'h1DF1;   // 7665
            memory[6] = 32'h31f;    // 799
            memory[7] = 32'h13e;    // 318
            memory[8] = 32'h31b;    //
            memory[9] = 32'h34d;
            memory[10] = 32'hffffffff;
            memory[11] = 32'h3e3;
            memory[12] = 32'hbc;
            memory[13] = 32'h108;
            memory[14] = 32'h17e;
            memory[15] = 32'h2be;
            memory[16] = 32'hfd;
            memory[17] = 32'h371;
            memory[18] = 32'h3da;
            memory[19] = 32'he2;
            memory[20] = 32'h277;
            memory[21] = 32'h4a;
            memory[22] = 32'h17;
            memory[23] = 32'hc8;
            memory[24] = 32'h3ca;
            memory[25] = 32'h1f4;
            memory[26] = 32'h2694;
            memory[27] = 32'h2a3;
            memory[28] = 32'ha5;
            memory[29] = 32'h375;
            memory[30] = 32'h228;
            memory[31] = 32'h39c;
            memory[32] = 32'h1d2;
            memory[33] = 32'h2b8;
            memory[34] = 32'h2e9;
            memory[35] = 32'h4FA;
            memory[36] = 32'h28e;
            memory[37] = 32'h1d1;
            memory[38] = 32'h2ed;
            memory[39] = 32'hf3;
            memory[40] = 32'h6f;
            memory[41] = 32'h34b;
            memory[42] = 32'he7;
            memory[43] = 32'h35b;
            memory[44] = 32'h112;
            memory[45] = 32'h171;
            memory[46] = 32'h2a;
            memory[47] = 32'h305;
            memory[48] = 32'h1c6;
            memory[49] = 32'h6d;
            memory[50] = 32'h392;
            memory[51] = 32'h229;
            memory[52] = 32'hab;
            memory[53] = 32'he3;
            memory[54] = 32'h31c;
            memory[55] = 32'hcf;
            memory[56] = 32'h206;
            memory[57] = 32'h11a;
            memory[58] = 32'hf6;
            memory[59] = 32'h24f;
            memory[60] = 32'h35c;
            memory[61] = 32'h37d;
            memory[62] = 32'h400;
            memory[63] = 32'h9;
            memory[64] = 32'h40;        // dummy values to check functions fro 274 - number of integers used for sorting
     end

    always @(posedge Clk) begin
        if(MemWrite == 1) begin
            case (dataType)
                2'b00: begin // byte
                    case(Address[1:0])  // which byte is indicated?
                        // least significant byte
                        2'b00: memory[Address[11:2]][7:0] <= WriteData[7:0];
                        // second least significant byte
                        2'b01: memory[Address[11:2]][15:8] <= WriteData[15:8];
                        // second most significant byte
                        2'b10: memory[Address[11:2]][23:16] <= WriteData[23:16];
                        // most significant byte
                        2'b11: memory[Address[11:2]][31:24] <= WriteData[31:24];
                    endcase
                end
                2'b01: begin // half word
                    case(Address[0])    // which halfword is indicated?
                        // least significant halfword
                        1'b0: memory[Address[11:2]][15:0] <= WriteData[15:0];
                        // most significant halfword
                        1'b1: memory[Address[11:2]][31:16] <= WriteData[31:16];
                    endcase
                end
                2'b10: begin // word (16 bits)
                    memory[Address[11:2]] <= WriteData;
                end
             endcase 
         end
     end    
     
    always @(*) begin
         if (MemRead == 1) begin
             case (dataType)
                 2'b00: begin // byte
                     ReadData <= {24'b0, memory[Address[11:2]][7:0]};
                 end
                 2'b01: begin // halfword
                     ReadData <= {16'b0, memory[Address[11:2]][15:0]};
                 end
                 2'b10: begin // word
                     ReadData <= memory[Address[11:2]];
                 end
             endcase
         end
         else begin
             ReadData <= 32'b0; 
         end
     end      
endmodule