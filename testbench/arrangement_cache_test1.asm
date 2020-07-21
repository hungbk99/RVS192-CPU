## arrangment
addi ra, zero, 1
andi a1,a1,0 #giu so lan lap
andi a0,a0,0 #bien temp dung de doi cho 2 so
andi s0,s0,0 #dau hieu nhan biet be hon
andi s1,s1,0
andi s2,s2,0
andi s3,s3,0
andi s4,s4,0
andi s5,s5,0
andi s6,s6,0
andi s7,s7,0
andi s8,s8,0
andi s9,s9,0
andi s10,s10,0
andi t1,t1,0
addi t1,t1,10
andi t6,t6,0 #dau hieu ket thuc
lw   s1,0(zero)
lw   s2,4(zero)
lw   s3,8(zero)
lw   s4,12(zero)
lw   s5,16(zero)
lw   s6,20(zero)
lw   s7,24(zero)
lw   s8,28(zero)
lw   s9,32(zero)
lw   s10,36(zero)
# start bubble sort
step_1:   slt s0,s1,s2 # so sanh voi so 1 (thanh ghi ra)
	  beq ra,s0, NEXT_1_1 # neu s1 < s2 thi nhay NEXT_1_1
      sub t0,s1,s2 
      beq zero,t0, NEXT_1_1# neu s1 = s2 thi nhay NEXT_1_1
	  add a0,zero,s1 # a0 chua s1
	  addi s1,s2,0 # chuyen s2 sang cho s1
	  addi s2,a0,0 # chuyen s1 sang cho s2
	  andi s0,s0,0 # xoa  s0 ve khong chuan bi lan kiem tra tiep theo
NEXT_1_1: slt s0,s2,s3 # so sanh voi so 1 (thanh ghi ra)
	  beq ra,s0, NEXT_1_2 # neu s2 < s3 thi nhay NEXT_1_2
      sub t0,s2,s3 
      beq zero,t0, NEXT_1_1# neu s2 = s3 thi nhay NEXT_1_2
	  add a0,zero,s2 # a0 chua s2
	  addi s2,s3,0 # chuyen s3 sang cho s2
	  addi s3,a0,0 # chuyen s2 sang cho s3
	  andi s0,s0,0 # xoa  s0 ve khong chuan bi lan kiem tra tiep theo
NEXT_1_2: slt s0,s3,s4 # so sanh voi so 1 (thanh ghi ra)
	  beq ra,s0, NEXT_1_3 # neu s3 < s4 thi nhay NEXT_1_3
    	  sub t0,s3,s4 
      	  beq zero,t0, NEXT_1_3# neu s3 = s4 thi nhay NEXT_1_3
	  add a0,zero,s3 # a0 chua s3
	  addi s3,s4,0 # chuyen s4 sang cho s3
	  addi s4,a0,0 # chuyen s3 sang cho s4
	  andi s0,s0,0 # xoa  s0 ve khong chuan bi lan kiem tra tiep theo	  
NEXT_1_3: slt s0,s4,s5 # so sanh voi so 1 (thanh ghi ra)
	  beq ra,s0, NEXT_1_4 # neu s4 < s5 thi nhay NEXT_1_4
      	  sub t0,s4,s5 
      	  beq zero,t0, NEXT_1_4# neu s4 = s5 thi nhay NEXT_1_4
	  add a0,zero,s4 # a0 chua s4
	  addi s4,s5,0 # chuyen s5 sang cho s4
	  addi s5,a0,0 # chuyen s4 sang cho s5
	  andi s0,s0,0 # xoa  s0 ve khong chuan bi lan kiem tra tiep theo
NEXT_1_4: slt s0,s5,s6 # so sanh voi so 1 (thanh ghi ra)
	  beq ra,s0, NEXT_1_5 # neu s5 < s6 thi nhay NEXT_1_5
          sub t0,s5,s6 
          beq zero,t0, NEXT_1_5# neu s5 = s6 thi nhay NEXT_1_5
	  add a0,zero,s5 # a0 chua s5
	  addi s5,s6,0 # chuyen s6 sang cho s5
	  addi s6,a0,0 # chuyen s5 sang cho s6
	  andi s0,s0,0 # xoa  s0 ve khong chuan bi lan kiem tra tiep theo	  
NEXT_1_5: slt s0,s6,s7 # so sanh voi so 1 (thanh ghi ra)
	  beq ra,s0, NEXT_1_6 # neu s6 < s7 thi nhay NEXT_1_6
          sub t0,s6,s7 
          beq zero,t0, NEXT_1_6# neu s6 = s7 thi nhay NEXT_1_6
	  add a0,zero,s6 # a0 chua s6
	  addi s6,s7,0 # chuyen s7 sang cho s6
	  addi s7,a0,0 # chuyen s6 sang cho s7
	  andi s0,s0,0 # xoa  s0 ve khong chuan bi lan kiem tra tiep theo	 
NEXT_1_6: slt s0,s7,s8 # so sanh voi so 1 (thanh ghi ra)
	  beq ra,s0, NEXT_1_7 # neu s7 < s8 thi nhay NEXT_1_7
          sub t0,s7,s8 
          beq zero,t0, NEXT_1_7# neu s7 = s8 thi nhay NEXT_1_7
	  add a0,zero,s7 # a0 chua s7
	  addi s7,s8,0 # chuyen s8 sang cho s7
	  addi s8,a0,0 # chuyen s7 sang cho s8
	  andi s0,s0,0 # xoa  s0 ve khong chuan bi lan kiem tra tiep theo	
NEXT_1_7: slt s0,s8,s9 # so sanh voi so 1 (thanh ghi ra)
	  beq ra,s0, NEXT_1_8 # neu s8 < s9 thi nhay NEXT_1_8
          sub t0,s8,s9
          beq zero,t0, NEXT_1_8# neu s8 = s9 thi nhay NEXT_1_8
	  add a0,zero,s8 # a0 chua s8
	  addi s8,s9,0 # chuyen s9 sang cho s8
	  addi s9,a0,0 # chuyen s8 sang cho s9
	  andi s0,s0,0 # xoa  s0 ve khong chuan bi lan kiem tra tiep theo		  
NEXT_1_8: slt s0,s9,s10 # so sanh voi so 1 (thanh ghi ra)
	  beq ra,s0, STEP_2 # neu s9 < s10 thi nhay step 2
          sub t0,s9,s10 
          beq zero,t0, STEP_2 # neu s9 = s10 thi nhay step 2
	  add a0,zero,s9 # a0 chua s9
	  addi s9,s10,0 # chuyen s10 sang cho s9
	  addi s10,a0,0 # chuyen s9 sang cho s10
STEP_2:   andi s0,s0,0 # xoa  s0 ve khong chuan bi lan kiem tra tiep theo	  
	  addi a1,a1,1
	  beq  t1,a1, STORE
	  jal  t2, step_1
STORE:	  sw  s1, 40(zero)
      	  sw  s2, 44(zero)
	  sw  s3, 48(zero)	  
	  sw  s4, 52(zero)
	  sw  s5, 56(zero)
	  sw  s6, 60(zero)
	  sw  s7, 64(zero)
	  sw  s8, 68(zero)
	  sw  s9, 72(zero)
	  sw  s10, 76(zero)
	  addi t6,t6, 511
LOAD:	lw a0, 40(zero)
	lw a1, 44(zero)
	lw a2, 48(zero)
	lw a3, 52(zero)
	lw a4, 56(zero)
	lw a5, 60(zero)
	lw a6, 64(zero)
	lw a7, 68(zero)
	lw t3, 72(zero)
	lw t4, 76(zero)
	  
	  
	  

