	ORG	0000H
	JMP	START					;跳至START執行
	ORG	0050H		
			
START:
	MOV	R0,#0					;將0這個值丟進R0R0目的為計算"列的遞迴"由於點矩陣顯示器一次只能控制一排顯示，因此當控制到最後一列時需要跳回第一列顯示

	MOV	R1,#80H					;將 10000000傳入R1,R1用來控制行
	MOV	R2,#10H					;將 00010000傳入R2,R2用來控制列

LOOP:							;控制"列"的切換
	MOV	A,R2					;將R2值丟給A (控制列)
	MOV	P1,A					;將A輸出至PORT1
	RR		A					; A的值向右位移( 000 10000 =>000 01000 )藉此便能夠往下一列移動

	MOV	R2,A					;回傳A的值到R2
	INC		R0					;R0 +1，用來計算跑過的次數
	CJNE	R0,#6,LOOP1			;CompareJump if Not Equal,比較R0是否為6，如果不是就跳到LOOP1，也就是如果還沒有跑過5列就繼續到LOOP1執行

	JMP		START				;如果 R0等於6，也就是跑過5行，就跳到START從頭開始



LOOP1:							;控制"行"的切換
	MOV	A,R1					;將R2值丟給A (控制行)
	MOV	P2,A					;將A輸出至PORT2
	RR		A					;A的值向右位移( 1000 0000 =>0100 0000 )

	MOV	R1,A					;回傳A的值到R1
	CALL	DELAY
	CJNE	A,#80H,LOOP1		;CompareJump if Not Equal,比較A是否為1000 0000，如果不是就跳回LOOP1遞迴，也就是如果還沒有跑過過一遍直列就繼續到LOOP1執行

	MOV	R1,#80H					;當執行到這，代表已經跑過一列了，
	

	JMP		LOOP				;因為這列已經跑完，因此跳至LOOP移至下一列	

DELAY:
	MOV	R5,#5H
DELAY1:
	MOV	R6,#0FFH
DELAY2:
	MOV	R7,#0FFH
DELAY3:
	DJNZ	R7,DELAY3
	DJNZ	R6,DELAY2
	DJNZ	R5,DELAY1
	RET
	END 
