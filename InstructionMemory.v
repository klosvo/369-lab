`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 3 (memory[i] = i * 3;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 

    output reg [31:0] Instruction;    // Instruction at memory location Address
    
    integer i;
    /* Please fill in the implementation here */
    //Create 2D array for memory with 128 32-bit elements here
         reg [31:0] memory [0:255];
    
         initial begin                   //need to initalize this for the code!!!

//        $readmemh ("Instruction_memory.mem", memory);
        memory[0] <= 32'h200ffc18;	//	main:	addi	$t7, $t7, -1000
        memory[1] <= 32'h01E07801;	// abs
        memory[2] <= 32'h2011000a;	//		addi	$s1, $s1, 10
        memory[2] <= 32'h20120005;	//		addi	$s2, $s2, 5
        memory[4] <= 32'h2D1980A; //subb
        memory[5] <= 32'h20080001;	//		addi	$t0, $t0, 1
        memory[6] <= 32'h20190003;	//		addi	$t9, $t9, 3
        memory[7] <= 32'h03394005;	//	adsh
        memory[8] <= 32'h200f0000;	//		addi	$t7, $t7, 0
        memory[9] <= 32'h01E07801;  // abs
        memory[10] <= 32'h2011000a;	//		addi	$s1, $s1, 10
        memory[11] <= 32'h2012fff5;	//		addi	$s2, $s2, -11
        memory[12] <= 32'h02D1980A;	//	subb
        memory[13] <= 32'h2008fffb;	//		addi	$t0, $t0, -5
        memory[14] <= 32'h20190001;	//		addi	$t9, $t9, 1
        memory[15] <= 32'h03394005;	//	adsh
        memory[16] <= 32'h21ef0064;	//		addi	$t7, $t7, 100
        memory[17] <= 32'h200f0064;  // abs


        end
        
        always @ (Address) begin
            Instruction <= memory[Address[10:2]];    
        end

endmodule
