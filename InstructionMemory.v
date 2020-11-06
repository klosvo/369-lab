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
         reg [31:0] memory [0:127];
    
         initial begin                   //need to initalize this for the code!!!
         
         
         memory[0] <= 32'h20100001;	//		addi	$s0, $zero, 1
         memory[1] <= 32'h2011000a;    //        addi    $s1, $zero, 10
         memory[2] <= 32'h20120010;    //        addi    $s2, $zero, 16
         memory[3] <= 32'h20130009;    //        addi    $s3, $zero, 9
         memory[4] <= 32'h20140014;    //        addi    $s4, $zero, 20
         memory[5] <= 32'h20150020;    //        addi    $s5, $zero, 32
         memory[6] <= 32'h2016003c;    //        addi    $s6, $zero, 60
         memory[7] <= 32'h20080000;    //        addi    $t0, $zero, 0
         memory[8] <= 32'h00000000;    //        nop
         memory[9] <= 32'h00000000;    //        nop
         memory[10] <= 32'h00000000;    //        nop
         memory[11] <= 32'h00000000;    //        nop
         memory[12] <= 32'h00000000;    //        nop
         memory[13] <= 32'h3c08ffff;    //        lui    $t0, 65535
         memory[14] <= 32'h00000000;    //        nop
         memory[15] <= 32'h00000000;    //        nop
         memory[16] <= 32'h00000000;    //        nop
         memory[17] <= 32'h00000000;    //        nop
         memory[18] <= 32'h00000000;    //        nop
         memory[19] <= 32'hac080028;    //        sw    $t0, 40($zero)
         memory[20] <= 32'h00000000;    //        nop
         memory[21] <= 32'h00000000;    //        nop
         memory[22] <= 32'h00000000;    //        nop
         memory[23] <= 32'h00000000;    //        nop
         memory[24] <= 32'h00000000;    //        nop





         
         
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

         
         
         
         
//		 memory[0] = 32'b00100000000100000000000000000001; //	main:	addi	$s0, $zero, 1
//         memory[1] = 32'b00100000000100010000000000000001; //        addi    $s1, $zero, 1
//         memory[2] = 32'b00000010000100011000000000100100; //        and    $s0, $s0, $s1
//         memory[3] = 32'b00000010000000001000000000100100; //        and    $s0, $s0, $zero
//         memory[4] = 32'b00000010001100001000000000100010; //        sub    $s0, $s1, $s0
//         memory[5] = 32'b00000010000000001000000000100111; //        nor    $s0, $s0, $zero
//         memory[6] = 32'b00000010000000001000000000100111; //        nor    $s0, $s0, $zero
//         memory[7] = 32'b00000000000000001000000000100101; //        or    $s0, $zero, $zero
//         memory[8] = 32'b00000010001000001000000000100101; //        or    $s0, $s1, $zero
//         memory[9] = 32'b00000000000100001000000010000000; //        sll    $s0, $s0, 2
//         memory[10] = 32'b00000010001100001000000000000100; //        sllv    $s0, $s0, $s1
//         memory[11] = 32'b00000010000000001000000000101010; //        slt    $s0, $s0, $zero
//         memory[12] = 32'b00000010000100011000000000101010; //        slt    $s0, $s0, $s1
//         memory[13] = 32'b00000000000100011000000001000011; //        sra    $s0, $s1, 1
//         memory[14] = 32'b00000000000100011000000000000111; //        srav    $s0, $s1, $zero
//         memory[15] = 32'b00000000000100011000000001000010; //        srl    $s0, $s1, 1
//         memory[16] = 32'b00000000000100011000000011000000; //        sll    $s0, $s1, 3
//         memory[17] = 32'b00000000000100001000000011000010; //        srl    $s0, $s0, 3
//         memory[18] = 32'b00000010001100001000000000000100; //        sllv    $s0, $s0, $s1
//         memory[19] = 32'b00000010001100001000000000000110; //        srlv    $s0, $s0, $s1
//         memory[20] = 32'b00000010000100011000000000100110; //        xor    $s0, $s0, $s1
//         memory[21] = 32'b00000010000100011000000000100110; //        xor    $s0, $s0, $s1
//         memory[22] = 32'b00100000000100100000000000000100; //        addi    $s2, $zero, 4
//         memory[23] = 32'b01110010000100101000000000000010; //        mul    $s0, $s0, $s2
//         memory[24] = 32'b00100010000100000000000000000100; //        addi    $s0, $s0, 4
//         memory[25] = 32'b00110010000100000000000000000000; //        andi    $s0, $s0, 0
//         memory[26] = 32'b00110110000100000000000000000001; //        ori    $s0, $s0, 1
//         memory[27] = 32'b00101010000100000000000000000000; //        slti    $s0, $s0, 0
//         memory[28] = 32'b00101010000100000000000000000001; //        slti    $s0, $s0, 1
//         memory[29] = 32'b00111010000100000000000000000001; //        xori    $s0, $s0, 1
//         memory[30] = 32'b00111010000100000000000000000001; //        xori    $s0, $s0, 1
//         memory[31] = 32'b00100000000100001111111111111110; //        addi    $s0, $zero, -2
//         memory[32] = 32'b00100000000100010000000000000010; //        addi    $s1, $zero, 2
//         memory[33] = 32'b00000010001100001001000000101011; //        sltu    $s2, $s1, $s0
//         memory[34] = 32'b00101110001100001111111111111110; //        sltiu    $s0, $s1, -2
//         memory[35] = 32'b00000010001000001000000000001010; //        movz    $s0, $s1, $zero
//         memory[36] = 32'b00000000000100011000000000001011; //        movn    $s0, $zero, $s1
//         memory[37] = 32'b00000010001100101000000000100000; //        add    $s0, $s1, $s2
//         memory[38] = 32'b00100000000100001111111111111110; //        addi    $s0, $zero, -2
//         memory[39] = 32'b00000010001100001000100000100001; //        addu    $s1, $s1, $s0
//         memory[40] = 32'b00100100000100011111111111111111; //        addiu    $s1, $zero, -1
//         memory[41] = 32'b00100000000100100000000000100000; //        addi    $s2, $zero, 32
//         memory[42] = 32'b00000010001100100000000000011000; //        mult    $s1, $s2
//         memory[43] = 32'b00000000000000001010000000010000; //        mfhi    $s4
//         memory[44] = 32'b00000000000000001010100000010010; //        mflo    $s5
//         memory[45] = 32'b00000010001100100000000000011001; //        multu    $s1, $s2
//         memory[46] = 32'b00000000000000001010000000010000; //        mfhi    $s4
//         memory[47] = 32'b00000000000000001010100000010010; //        mflo    $s5
//         memory[48] = 32'b01110010001100100000000000000000; //        madd    $s1, $s2
//         memory[49] = 32'b00000000000000001010000000010000; //        mfhi    $s4
//         memory[50] = 32'b00000000000000001010100000010010; //        mflo    $s5
//         memory[51] = 32'b00000010010000000000000000010001; //        mthi    $s2
//         memory[52] = 32'b00000010001000000000000000010011; //        mtlo    $s1
//         memory[53] = 32'b00000000000000001010000000010000; //        mfhi    $s4
//         memory[54] = 32'b00000000000000001010100000010010; //        mflo    $s5
//         memory[55] = 32'b00110010001100011111111111111111; //        andi    $s1, , $s1, 65535
//         memory[56] = 32'b01110010100100100000000000000100; //        msub    $s4, , $s2
//         memory[57] = 32'b00000000000000001010000000010000; //        mfhi    $s4
//         memory[58] = 32'b00000000000000001010100000010010; //        mflo    $s5
//         memory[59] = 32'b00100000000100100000000000000001; //        addi    $s2, $zero, 1
//         memory[60] = 32'b00000000001100101000111111000010; //        rotr    $s1, $s2, 31
//         memory[61] = 32'b00100000000101000000000000011111; //        addi    $s4, $zero, 31
//         memory[62] = 32'b00000010100100011000100001000110; //        rotrv    $s1, $s1, $s4
//         memory[63] = 32'b00000000000000000000000000000000; //        nop
//         memory[64] = 32'b01111100000100011010010000100000; //        seb    $s4, $s1
//         memory[65] = 32'b01111100000100011010011000100000; //        seh    $s4, , $s1
                       
                         
                         
                 //    end
                 
                 

//memory[0] <= 32'b00100000000010000000000000000100;	//	main:		addi	$t0, $zero, 4
//memory[1] <= 32'b00100000000010011111111111111011;	//			addi	$t1, $zero, -5
//memory[2] <= 32'b00100001000010001111111111111111;	//	loop:		addi	$t0, $t0, -1
//memory[3] <= 32'b00011101000000001111111111111110;	//			bgtz	$t0, loop
//memory[4] <= 32'b00100001001010010000000000000001;	//	loop2:		addi	$t1, $t1, 1
//memory[5] <= 32'b00000101001000001111111111111110;	//			bltz	$t1, loop2
//memory[6] <= 32'b00100000000010100000000000000000;	//			addi	$t2, $zero, 0
//memory[7] <= 32'b00010001010000000000000000000010;	//	return1:	beq	$t2, $zero, CheckJump
//memory[8] <= 32'b00010101010000000000000000000011;	//			bne	$t2, $zero, CheckJR
//memory[9] <= 32'b00000011111000000000000000001000;	//			jr	$ra
//memory[10] <= 32'b00100000000010100000000000000001;	//	CheckJump:	addi	$t2, $zero, 1
//memory[11] <= 32'b00000000000000000000000000000000;	//			nop
//memory[12] <= 32'b00100000000010100000000000100000;	//	CheckJR:	addi	$t2, $zero, 32



            //  TASK 3
//            memory[0] = 32'h34040000;	//	main:		ori	$a0, $zero, 0
//            memory[1] = 32'h34050100;	//			ori	$a1, $zero, 256
//            memory[2] = 32'h20110000;	//			addi	$s1, $zero, 0
//            memory[3] = 32'h20120001;	//			addi	$s2, $zero, 1
//            memory[4] = 32'h20080000;	//			addi	$t0, $zero, 0
//            memory[5] = 32'h8ca50000;	//			lw	$a1, 0($a1)
//            memory[6] = 32'h20080004;	//			addi	$t0, $zero, 4
//            memory[7] = 32'h20100000;	//			addi	$s0, $zero, 0
//            memory[8] = 32'h70a82802;	//			mul	$a1, $a1, $t0
//            memory[9] = 32'h20a5fffc;	//			addi	$a1, $a1, -4

            

//      Task 1
//            memory[0] = 32'h2010000e;    //    main:   addi   $s0, $zero, 14            #so = RegFile[16] = 14  (0+14)
//            memory[1] = 32'h2011000f;    //        addi    $s1, $zero, 15               #s1 = RegFile[17] = 15  (0+15)
//            memory[2] = 32'h2012001d;    //        addi    $s2, $zero, 29               #s2 = RegFile[18] = 29  (0+29)
//            memory[3] = 32'h2013fff1;    //        addi    $s3, $zero, -15              #s3 = RegFile[19] = -15 (0+-15)
//            memory[4] = 32'h02324020;    //        add     $t0, $s1, $s2                #t0 = RegFile[8] = 44  (15+29)
//            memory[5] = 32'h02504024;    //        and     $t0, $s2, $s0                #t0 = 12  (29 AND 14 => 11101 AND 01110 = 01100 = 12)
//            memory[6] = 32'h72114002;    //        mul     $t0, $s0, $s1                #t0 = 210 (14*15)
//            memory[7] = 32'h02504025;    //        or      $t0, $s2, $s0                #t0 = 31  (29 OR 14 => 11101 OR 01110 = 11111 = 31) 
//            memory[8] = 32'h36080010;    //        ori     $t0, $s0, 16                 #t0 = 30  (14 OR 16 = 01110 OR 10000 = 11110 = 30)
//            memory[9] = 32'h02124022;    //        sub     $t0, $s0, $s2                #t0 = -15 (14-29)  
//            memory[10] = 32'h72604021;    //        clo    $t0, $s3                     #t0 = 28  (count leading 1 of s3 = -15 =  1111 1111 1111 1111 1111 1111 1111 0001)
//            memory[11] = 32'h72404020;    //        clz    $t0, $s2                     #t0 = 27  (count leading 0 of s2 = 29 = 0000 0000 0000 0000 0000 0000 0001 1101)
//            memory[12] = 32'h0211402a;    //        slt    $t0, $s0, $s1                #t0 = 1
//            memory[13] = 32'h0230402a;    //        slt    $t0, $s1, $s0                #t0 = 0
//            memory[14] = 32'h00114080;    //        sll    $t0, $s1, 2                  #t0 = 60  (15*4)
//            memory[15] = 32'h001240c2;    //        srl    $t0, $s2, 3                  #t0 = 3   (29/8)
     //    TASK 2
//           memory[0] = 32'h34090000;	//	main:	ori	$t1, $zero, 0
//           memory[1] = 32'h2012001d;	//		addi	$s2, $zero, 29
//           memory[2] = 32'h2013000c;	//		addi	$s3, $zero, 12
//           memory[3] = 32'had320004;	//		sw	$s2, 4($t1)
//           memory[4] = 32'had330008;	//		sw	$s3, 8($t1)
//           memory[5] = 32'h8d280004;	//		lw	$t0, 4($t1)
//           memory[6] = 32'h8d280008;	//		lw	$t0, 8($t1)
//           memory[7] = 32'h15120002;	//		bne	$t0, $s2, label1
//           memory[8] = 32'h00004020;	//		add	$t0, $zero, $zero
//           memory[9] = 32'h2008000c;	//		addi	$t0, $zero, 12
//           memory[10] = 32'h15130001;	//	label1:	bne	$t0, $s3, label2
//           memory[11] = 32'h20080001;	//		addi	$t0, $zero, 1
//           memory[12] = 32'h2008001d;	//	label2:	addi	$t0, $zero, 29
        end
        
        always @ (Address) begin
            Instruction <= memory[Address[8:2]];    
        end

endmodule
