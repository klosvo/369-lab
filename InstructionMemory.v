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
    
         reg [31:0] memory [0:127];
    
         initial begin                   //need to initalize this for the code!!!
         
         
         memory[0] <= 32'h00000000;	//	loop:	nop
         memory[1] <= 32'h20090006;    //        addi    $t1, $zero, 6
         memory[2] <= 32'h200a000a;    //        addi    $t2, $zero, 10
         memory[3] <= 32'had090000;    //        sw    $t1, 0($t0)
         memory[4] <= 32'had0a0004;    //        sw    $t2, 4($t0)
         memory[5] <= 32'h8d100000;    //        lw    $s0, 0($t0)
         memory[6] <= 32'h8d110004;    //        lw    $s1, 4($t0)
         memory[7] <= 32'h02305822;    //        sub    $t3, $s1, $s0
         memory[8] <= 32'h000b60c0;    //        sll    $t4, $t3, 3
         memory[9] <= 32'h000c6882;    //        srl    $t5, $t4, 2
         memory[10] <= 32'h08000000;    //        j    loop
         memory[11] <= 32'h00000000;    //        nop
         memory[12] <= 32'h00000000;    //        nop
         memory[13] <= 32'h00000000;    //        nop
         memory[14] <= 32'h00000000;    //        nop
         memory[15] <= 32'h00000000;    //        nop
         memory[16] <= 32'h00000000;    //        nop
         memory[17] <= 32'h00000000;    //        nop
         memory[18] <= 32'h20090006;    //        addi    $t1, $zero, 6

         
         
         
//         memory[0] <= 32'h20100001;	//		addi	$s0, $zero, 1
//         memory[1] <= 32'h2011000a;    //        addi    $s1, $zero, 10
//         memory[2] <= 32'h20120010;    //        addi    $s2, $zero, 16
//         memory[3] <= 32'h20130009;    //        addi    $s3, $zero, 9
//         memory[4] <= 32'h20140014;    //        addi    $s4, $zero, 20
//         memory[5] <= 32'h20150020;    //        addi    $s5, $zero, 32
//         memory[6] <= 32'h2016003c;    //        addi    $s6, $zero, 60
//         memory[7] <= 32'h20080000;    //        addi    $t0, $zero, 0
//         memory[8] <= 32'h00000000;    //        nop
//         memory[9] <= 32'h00000000;    //        nop
//         memory[10] <= 32'h00000000;    //        nop
//         memory[11] <= 32'h00000000;    //        nop
//         memory[12] <= 32'h00000000;    //        nop
//         memory[13] <= 32'h3c08ffff;    //        lui    $t0, 65535
//         memory[14] <= 32'h00000000;    //        nop
//         memory[15] <= 32'h00000000;    //        nop
//         memory[16] <= 32'h00000000;    //        nop
//         memory[17] <= 32'h00000000;    //        nop
//         memory[18] <= 32'h00000000;    //        nop
//         memory[19] <= 32'hac080028;    //        sw    $t0, 40($zero)
//         memory[20] <= 32'h00000000;    //        nop
//         memory[21] <= 32'h00000000;    //        nop
//         memory[22] <= 32'h00000000;    //        nop
//         memory[23] <= 32'h00000000;    //        nop
//         memory[24] <= 32'h00000000;    //        nop

         
//         memory[0] <= 32'h34090000;	//	main:	ori	$t1, $zero, 0
//         memory[1] <= 32'h2012001d;    //        addi    $s2, $zero, 29
//         memory[2] <= 32'h2013000c;    //        addi    $s3, $zero, 12
//         memory[3] <= 32'had320004;    //        sw    $s2, 4($t1)
//         memory[4] <= 32'had330008;    //        sw    $s3, 8($t1)
//         memory[5] <= 32'h8d280004;    //        lw    $t0, 4($t1)
//         memory[6] <= 32'h8d280008;    //        lw    $t0, 8($t1)
//         memory[7] <= 32'h15120002;    //        bne    $t0, $s2, label1
//         memory[8] <= 32'h00004020;    //        add    $t0, $zero, $zero
//         memory[9] <= 32'h2008000c;    //        addi    $t0, $zero, 12
//         memory[10] <= 32'h15130001;    //    label1:    bne    $t0, $s3, label2
//         memory[11] <= 32'h20080001;    //        addi    $t0, $zero, 1
//         memory[12] <= 32'h2008001d;    //    label2:    addi    $t0, $zero, 29

         
         
//         memory[0] <= 32'h20100001;	//		addi	$s0, $zero, 1
//         memory[1] <= 32'h2011000a;    //        addi    $s1, $zero, 10
//         memory[2] <= 32'h20120010;    //        addi    $s2, $zero, 16
//         memory[3] <= 32'h20130009;    //        addi    $s3, $zero, 9
//         memory[4] <= 32'h20140014;    //        addi    $s4, $zero, 20
//         memory[5] <= 32'h20150020;    //        addi    $s5, $zero, 32
//         memory[6] <= 32'h2016003c;    //        addi    $s6, $zero, 60
//         memory[7] <= 32'h20080000;    //        addi    $t0, $zero, 0
//         memory[8] <= 32'h8e480000;    //        lw    $t0, 0($s2)
//         memory[9] <= 32'h8e480004;    //        lw    $t0, 4($s2)
//         memory[10] <= 32'h00000000;    //        nop
//         memory[11] <= 32'h00000000;    //        nop

         
//         memory[0] <= 32'h20100001;	//		addi	$s0, $zero, 1
//         memory[1] <= 32'h2011000a;    //        addi    $s1, $zero, 10
//         memory[2] <= 32'h20120010;    //        addi    $s2, $zero, 16
//         memory[3] <= 32'h20130009;    //        addi    $s3, $zero, 9
//         memory[4] <= 32'h20140014;    //        addi    $s4, $zero, 20
//         memory[5] <= 32'h20150020;    //        addi    $s5, $zero, 32
//         memory[6] <= 32'h2016003c;    //        addi    $s6, $zero, 60
//         memory[7] <= 32'h20080000;    //        addi    $t0, $zero, 0
//         memory[8] <= 32'h8e480000;    //        lw    $t0, 0($s2)
//         memory[9] <= 32'h8c080004;    //        lw    $t0, 4($zero)
//         memory[10] <= 32'h8c080008;    //        lw    $t0, 8($zero)
//         memory[11] <= 32'h8c080014;    //        lw    $t0, 20($zero)
//         memory[12] <= 32'h8c08001c;    //        lw    $t0, 28($zero)
//         memory[13] <= 32'hae080000;    //        sw    $t0, 0($s0)
//         memory[14] <= 32'hae080004;    //        sw    $t0, 4($s0)
//         memory[15] <= 32'hae080008;    //        sw    $t0, 8($s0)
//         memory[16] <= 32'hae080000;    //        sw    $t0, 0($s0)


         
         
//         memory[0] <= 32'b00100000000100000000000000000001;	//		addi	$s0, $zero, 1
//         memory[1] <= 32'b00100000000100010000000000001010;    //        addi    $s1, $zero, 10
//         memory[2] <= 32'b00100000000100100000000000010000;    //        addi    $s2, $zero, 16
//         memory[3] <= 32'b00100000000100110000000000001001;    //        addi    $s3, $zero, 9
//         memory[4] <= 32'b00100000000101000000000000010100;    //        addi    $s4, $zero, 20
//         memory[5] <= 32'b00100000000101010000000000100000;    //        addi    $s5, $zero, 32
//         memory[6] <= 32'b00100000000101100000000000111100;    //        addi    $s6, $zero, 60
//         memory[7] <= 32'b00100000000010000000000000000000;    //        addi    $t0, $zero, 0
//         memory[8] <= 32'b10001110000010000000000000001000;    //        lw    $t0, 8($s0)
//         memory[9] <= 32'b00000010000100010100000000100000;    //        add    $t0, $s0, $s1
//         memory[10] <= 32'b10101110000010000000000000000000;    //        sw    $t0, 0($s0)
//         memory[11] <= 32'b00000010010100010100000000100010;    //        sub    $t0, $s2, $s1
//         memory[12] <= 32'b00000010001100100100000000100100;    //        and    $t0, $s1, $s2
//         memory[13] <= 32'b00000010101101100100000000100111;    //        nor    $t0, $s5, $s6
//         memory[14] <= 32'b00000010001100100100000000100101;    //        or    $t0, $s1, $s2
//         memory[15] <= 32'b00000000000100010100000010000000;    //        sll    $t0, $s1, 2
//         memory[16] <= 32'b00000010011101000100000000000100;    //        sllv    $t0, $s4, $s3
//         memory[17] <= 32'b00000010100000000100000000101010;    //        slt    $t0, $s4, $zero

        end
        
        always @ * begin
            Instruction <= memory[Address[8:2]];    
        end

endmodule
