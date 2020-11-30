.text
.globl main


		# this is the first itration of testing, I will add more as we progress.

main: 

	#tesing arithmatics (forwarding and hazard detection also tested)
			addi $t0, $zero, 4  # test addi --- should output 4 
			addi $t1, $zero, -5 # should output -5
			add $t2, $t0, $t1   # test add and forwarding WB.rd to EX.rs and MEM.rd to EX.rt --- should output -1
			sub $t3, $t2, $t0  #test sub --- should output -5
			mul $t4, $t1, $t1  #test mul --- shoulde output 25
			mult $t0, $t0	   #test mult --- Lo reg should be updated with 16
			madd $t1, $t1	   #test madd --- Lo reg should be updated with 41 --- test hazard detection
			msub $t2, $t2      #test msub --- Lo reg should be updated with 40 --- test hazard detection
	#testing LocialOps
			and $t2, $t0, $t1  #test and --- should output 0
			andi $t3, $t0, 500 #test andi --- should output 4
			or $t2, $t0, $t1   #test or --- should output -1
			ori $t3, $t0, 500  #test ori --- should output 500
			nor $t2, $t0, $t1  #test nor --- should output 0
			xori $t3, $t0, 500 #test xori --- should output 496
		    xor $t2, $t1, $t0  #test xor --- should output -1
			sll $t4, $t0, 2	   #test sll --- should output 16
			srl $t2, $t1, 1	   #test srl --- should output -3
			srlv $t3, $t3, $t0 #test srlv -- should output 31
			sllv $t4, $t4, $t4 #test sllv -- should output 1048576
			slti $t2, $t2, 0   #test slti -- should output 1
			slt $t3, $t0, $t1  #test slt -- should output 0
			rotrv $t3, $t4, $t0#test rotrv -- should output 65536
			rotr $t4, $t0, 4  #test rotr -- should output 	1073741824
			sra $t2, $t0, 1    #test sra -- should output 2
			srav $t2, $t4, $t0  #test srav -- should output 67108864
			
			#have not tested seh, seb, sltu, sltiu
			
	#testing Branches (and flushing)
	loop:
			beq $t1, $zero, exit #test beq -- should output nothing -- should run 6 times
			addi $t1, $t1, 1	 # should output -4, -3, -2, -1, 0
			j loop				 #test jump -- should output nothing -- should run 5 times
	exit:
	
			#have not tested bne, bgez, blez, bgtz, bltz, jr, jal
			
			
			
			
	#testing memory access (and hazard detection)
			addi $t1, $zero, 5 	#should output 5
			addi $t2, $t2, 6    #should output 67108870
			addi $t3, $t3, 7	#should output 65543
			
			sw $t1, 0($t0)
			sh $t2, 6($t0)
			sb $t3, 11($t0)
			sw $t4, 12($t0) 
			
			lw $t5, 0($t0)  #testing lw and sw -- should output -5
			lh $t6, 6($t0)  #testing lh and sh -- should output 6
			lb $t7, 11($t0) #testing lb and sb -- should output 7
			lw $t8, 12($t0) #more testing of lw and sw should output 1073741824
			
			#have not tested for lui
			
	#testing move Ops
			mthi $t0 #test move to HI -- HI should be updated to 4
			mtlo $t2 #test move fo LO -- LO should be updated to 67108870
			
			mfhi $t3 #test move from HI -- should output 4
			mflo $t4 #test move from LO -- should output 67108870
			
			#have not tested move on zero OR move on not zero
			
			
			jr $ra
			
