	ORG	00H
	JMP	INITIAL							;跳至INITIAL執行
	ORG	50H
INITIAL:
	MOV	R2,#0						;將0這個值丟進R2,為閃爍次數的計數器,借閃爍造成視覺暫留以達顯示的目的

START:
	MOV	R0,#0						;將0這個值丟進R0,R0目的為計算"列"的遞迴,由於點矩陣顯示器一次只能控制一排顯示，因此當控制到最後一列時需要跳回第一列顯示

	MOV	R1,#10H						;將10H這個值丟進R1控制輸出到哪一列，因給予 10H (000 10000)這個值讓程式從第一排開始

	MOV	DPTR,#TABLE  				;將TABLE丟進DPTR暫存器，TABLE為顯示"大"字時所需的真值表

LOOP:								;LOOP副程式( "大"字 )
	MOV	P1,#00H							
	MOV	A,R0						;將R0值丟進A
	MOVC	A,@A+DPTR				;先將A和DPTR的值相加接著到PROGRAM MEMORY中找指標所指的位置，最後回傳給 A
	MOV	P2,A						;將A值丟進P2 (控制"列")
	MOV	P1,R1						;將R1丟進P1(控制"行")
	INC		R0						;R0+1 (計算已經跑過列數)
	MOV	A,R1						;將R1值丟進A
	RR		A						;A的值向右位移( 000 10000 =>000 01000 )目的是為了跑向下一列
	MOV	R1,A						;A回傳R1
	CALL	DELAY					;呼叫DELAY副程式
	CJNE	R0,#5,LOOP				;CompareJump if Not Equal 比較R0是否為5，如果不是就跳回LOOP，也就是如果沒有跑過5列，就遞迴LOOP繼續跑向下一列

	INC	R2							;R2+1當程式進行至此，表示所有列都已經跑過一次，此時整體閃爍次數就+1
	CJNE	R2,#50,START			; 當R2閃爍50次後就往下一個進行，如果沒有就跳回START跑
	
	MOV	R2,#0						; R2歸零，由於"大"已經跑完，因此將閃爍次數歸零
	JMP		START2					;跳向START2，下一個字



START2:								;START2基本上與START大同小異，為一差別就在DPTR要指向TABLE2而非TABLE，因為這TABLE2才有"中"字的真值表
	MOV	R0,#0
	MOV	R1,#10H	
	MOV	DPTR,#TABLE2  				


LOOP2:								;LOOP2副程式( "中"字 )與LOOP 原理相同
	MOV	P1,#00H
	MOV	A,R0
	MOVC	A,@A+DPTR
	MOV	P2,A
	MOV	P1,R1
	INC	R0
	MOV	A,R1
	RR	A
	MOV	R1,A
	CALL	DELAY
	CJNE	R0,#5,LOOP2
	INC	R2
	CJNE	R2,#50,START2	
	MOV	R2,#0
	JMP	START3							

START3:								;同START2，只需將DPTR指的TABLE2改至TABLE3("小"字)即可
	MOV	R0,#0
	MOV	R1,#10H	
	MOV	DPTR,#TABLE3  

LOOP3:								;LOOP2副程式( "小"字 )與LOOP 原理相同
	MOV	P1,#00H
	MOV	A,R0
	MOVC	A,@A+DPTR
	MOV	P2,A
	MOV	P1,R1
	INC	R0
	MOV	A,R1
	RR	A
	MOV	R1,A
	CALL	DELAY
	CJNE	R0,#5,LOOP3
	INC	R2
	CJNE	R2,#50,START3

	MOV	R2,#0
	JMP	START							;當三個字都跑過後跳回START ("大")從頭開始，如此便會無限循環"大" "中" "小"	

TABLE:									;"大"字的TABLE
	DB	00010010B
	DB	00010100B
	DB	01111000B
	DB	00010100B
	DB	00010010B

TABLE2:									;"中"字的TABLE
	DB	00111110B
	DB	00100010B
	DB	01111111B
	DB	00100010B
	DB	00111110B

TABLE3:									;"小"字的TABLE
	DB	00001000B
	DB	00010001B
	DB	01111111B
	DB	00010000B
	DB	00001000B

DELAY:								
	MOV	R6,#20H
DELAY1:
	MOV	R7,#0FFH
DELAY2:
	DJNZ	R7,DELAY2
	DJNZ	R6,DELAY1
	RET	
	END 
