;P1輸出控制4個7段顯示器顯示的順序(個->十->百->千)
;若要使他顯示,輸入訊號0,反之輸入1

;P0輸出控制7段顯示器上所顯示的內容

;要令上數速度變慢,令一個數字連續顯示20次,以R4計速��

;R0暫存器儲存個位數下一次該顯示的數字,R1存十位數,R2百,R3千 

	ORG 0000H
	AJMP MAIN
	ORG 0050H
MAIN:					;預設上數器為9990
	MOV R0,#0			;令R0為個位數 預設0 
	MOV R1,#9			;令R1為十位數 預設9 
	MOV R2,#9			;令R2為百位數 預設9 
	MOV R3,#9			;令R3為千位數 預設9 
	MOV R4,#0			;以R4計算一數循環次數 預設為0 
	MOV DPTR,#TABLE		;將0-9Data放入程式記憶體 
	
LOOP:
	MOV P1,#11110111B	;控制只有個位燈亮 
	MOV A,R0			;將個位訊號丟給A 
	MOVC A,@A+DPTR		;將位置@A+DPTR中的值送給A 
	MOV P0,A			;輸出A至Port0 -> 7段顯示器��
	INC R4				;循環次數加一 
	ACALL DELAY
	
	MOV P1,#11111011B	;控制只有十位燈亮 
	MOV A,R1		    ;將十位訊號丟給A 
	MOVC A,@A+DPTR		;將位置@A+DPTR中的值送給A 
	MOV P0,A			;輸出A至Port0 -> 7段顯示器 
	ACALL DELAY
	
	MOV P1,#11111101B	;控制只有百位燈亮
	MOV A,R2			;將百位訊號丟給A 
	MOVC A,@A+DPTR		;將位置@A+DPTR中的值送給A 
	MOV P0,A			;輸出A至Port0 -> 7段顯示器 
	ACALL DELAY
	
	MOV P1,#11111110B	;控制只有千位燈亮
	MOV A,R3			;將千位訊號丟給A 
	MOVC A,@A+DPTR		;將位置@A+DPTR中的值送給A 
	MOV P0,A			;輸出A至Port0 -> 7段顯示器
	ACALL DELAY
	
	CJNE R4,#20,LOOP	;判斷循環次數是否加到20,沒有就跳至LOOP繼續上數 
	INC R0				;連續次數達到20,個位數加一 
	CJNE R0,#10,LOOP	;判斷個位數是否加到10,沒有就跳至LOOP繼續上數��
	AJMP LOOP1			;反之跳至LOOP2
	
LOOP1:					;個位數加到十的時候 
	MOV R0,#0			;將個位數暫存器R0 歸0��
	INC R1				;十位數加一 
	CJNE R1,#10,LOOP	;判斷十位數是否加到10,沒有就跳至LOOP繼續上數����
	AJMP LOOP2			;反之跳至LOOP2 

LOOP2:					;十位數加到十的時候
	MOV R1,#0			;將十位數暫存器R1 歸0 
	INC R2              ;百位數加一 
	CJNE R2,#10,LOOP	;判斷百位數是否加到10,沒有就跳至LOOP繼續上數�� 
	AJMP LOOP3			;反之跳至LOOP3  
	
LOOP3:					;百位數加到十的時候
	MOV R2,#0			;將百位數暫存器R2 歸0 
	INC R3				;千位數加一 
	CJNE R3,#10,LOOP	;判斷千位數是否加到10,沒有就跳至LOOP繼續上數��
	AJMP LOOP4			;反之跳至LOOP4 
	
LOOP4:					;千位數加到十的時候 
	MOV R3,#0			;將千位數暫存器R3 歸0 
	AJMP LOOP			;跳至LOOP
	
DELAY:
	MOV R5,#0FFH
DELAY1:
	MOV R6,#1H
DELAY2:
	MOV R7,#1H
DELAY3:
	DJNZ R7,DELAY3
	DJNZ R6,DELAY2
	DJNZ R5,DELAY1
	RET
	
TABLE:					;數字顯示標籤 
	DB	0C0H			;0
	DB	0F9H			;1
	DB	0A4H			;2
	DB	0B0H			;3
	DB	099H			;4
	DB	092H			;5
	DB	082H			;6
	DB	0F8H			;7
	DB	080H			;8
	DB	090H			;9
	
	END
