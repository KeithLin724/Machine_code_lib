	ORG	0000H
	JMP	START
	ORG	0050H
START:
	ACALL	DELAY5MS		;等待 LCD 啟動完成	
	MOV	A,#00111011B		;8位元資料存取，雙列，5*7點陣列字型 
	ACALL	COMMAND			;呼叫 COMMAND副程式
							;COMMAND副程式會把 
							;A值輸入到Instruction Register
	
	MOV	A,#00001110B		;顯示器ON，CursorON，Cursor閃爍off 
	ACALL	COMMAND			;A值輸入到Instruction Register
	
	MOV	A,#00000001B		;CLEAR DD RAM
	ACALL	COMMAND			;A值輸入到Instruction Register
	
	ACALL	DELAY2MS		;DELAY 2ms
	
	MOV	A,#10000000B		;設DD RAM位址為0
	ACALL	COMMAND			;A值輸入到Instruction Register
	
	MOV	DPTR,#TABLE			;將TABLE丟進DPTR暫存器
	
LOOP:				
	CLR	A					;清除A暫存器的值,A=0
	MOVC	A,@A+DPTR		;抓取TABLE裡對應的值
	JZ	ENDTABLE			;如果抓到的A為0,就跳到ENDTABLE
	ACALL	SDATA			;呼叫SDATA，SDATA會把 A值輸入到DDRAM
	INC	DPTR				;DPTR+1
	SJMP	LOOP			;跳回LOOP抓下一個值

ENDTABLE:
	SJMP	$				
	

COMMAND:					;COMMAND副程式會把A值輸入到Instruction Register

	MOV	P2,A				;DATA值輸入到P2，P2接著LCM的D0-D7
	MOV	P1,#00000100B		;E=1 , RW=0 , RS=0 ，DATA寫進InstructionRegister
	MOV	P1,#00000000B		;E=0 , RW=0 , RS=0
	ACALL	DELAY40US		;延遲40 us
	RET						;RETURN

SDATA:						;SDATA副程式會把 
							;A值輸入到 DD RAM
	MOV	P2,A
	MOV	P1,#00000101B		;E=1 , RW=0 , RS=1 ，DATA寫進 DD RAM
	MOV	P1,#00000001B		;E=0 , RW=0 , RS=1
	ACALL	DELAY40US		;延遲40 us
	RET						;RETURN

DELAY40US:
	MOV	R1,#20				;1 machine cycle約為 1us
 	DJNZ	R1,$			;DJNZ 執行要 2 machine cycle=2us執行20 次即為 40us
	RET

DELAY5MS:					;DELAY 5ms 
	ACALL	DELAY1MS
	ACALL	DELAY1MS
	ACALL	DELAY1MS
	ACALL	DELAY1MS
	ACALL	DELAY1MS
	RET

DELAY2MS:					;DELAY 2ms
	ACALL	DELAY1MS
	ACALL	DELAY1MS
	RET


DELAY1MS:					;DELAY 1ms
	MOV	R6,#100
DELAY1:
	MOV	R7,#150
DELAY2:
	DJNZ	R7,$
	DJNZ	R6,DELAY1
	RET

	


TABLE:						;要寫入DD RAM的 DATA TABLE
	DB		"0610872",0
	END




