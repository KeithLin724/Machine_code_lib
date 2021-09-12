	ORG	00H
	JMP	START
	ORG	50H

START:
	MOV	R0,#01110101B  ;0111 0101		;將01110101這個值丟進R0 ( 個位數 5)
	MOV	R1,#10110000B  ;1011 0000		;將10110000這個值丟進R1 ( 十位數 0)

	MOV	R5,#00H	  ;0000 0000
	

	
MAIN1:
	CJNE R5,#30H,MAIN2
	MOV	R5,#00H
	DEC	R0								;Decrease R0，個位數減一，這行指令為是否繼續記數的關鍵

MAIN2:
	MOV	P0,R0
	CALL  DELAY
	CJNE  R0,#6FH,SHOWA  ;0110 1111		;當個位數由 01110101被扣到 0110 1111，表是該退位，因此執行下列指令
	DEC	R1								;十位數減一
	MOV	R0,#01111001B	 ;0111 1001		;個位數歸零
		

SHOWA:									;有SHOWA SHOWB主要是來控制當記數剩個位數時( 1 2 3 4 5 6…. )，我們需要停掉顯示十位數的指令（MOV P1,R1）
	CJNE	R1,#10110000B,SHOWB			;若十位數不為零，跳到SHOWB
	CALL	DELAY
	INC	R5
	JMP	LAST							;跳到LAST

SHOWB:	
	MOV	P0,R1							;顯示十位數(十位數不為零)
	CALL	DELAY
	INC	R5
	JMP	LAST	


LAST:
	CJNE	R1,#10101111B,MAIN1			;若十位數沒從0000被扣到 1111則繼續遞回，若有，表示十位數已經被扣到-1，需要從頭開始算，因此執行下列指令
	MOV	R1,#10110110B					; 十位數 = 6 
	MOV	R0,#01110000B					; 個位數 = 0 
	MOV	R5,#00H
	JMP	MAIN1							;回到MAIN1
	


DELAY:
	MOV	R6,#10H
DELAY1:
	MOV	R7,#0FFH
DELAY2:
	DJNZ	R7,DELAY2
	DJNZ	R6,DELAY1
	RET	
	END 

