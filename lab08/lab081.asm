	ORG	0000H
	JMP	START
	ORG	0050H
START:
	ACALL	DELAY5MS		;���� LCD �Ұʧ���	
	MOV	A,#00111011B		;8�줸��Ʀs���A���C�A5*7�I�}�C�r�� 
	ACALL	COMMAND			;�I�s COMMAND�Ƶ{��
							;COMMAND�Ƶ{���|�� 
							;A�ȿ�J��Instruction Register
	
	MOV	A,#00001110B		;��ܾ�ON�ACursorON�ACursor�{�{off 
	ACALL	COMMAND			;A�ȿ�J��Instruction Register
	
	MOV	A,#00000001B		;CLEAR DD RAM
	ACALL	COMMAND			;A�ȿ�J��Instruction Register
	
	ACALL	DELAY2MS		;DELAY 2ms
	
	MOV	A,#10000000B		;�]DD RAM��}��0
	ACALL	COMMAND			;A�ȿ�J��Instruction Register
	
	MOV	DPTR,#TABLE			;�NTABLE��iDPTR�Ȧs��
	
LOOP:				
	CLR	A					;�M��A�Ȧs������,A=0
	MOVC	A,@A+DPTR		;���TABLE�̹�������
	JZ	ENDTABLE			;�p�G��쪺A��0,�N����ENDTABLE
	ACALL	SDATA			;�I�sSDATA�ASDATA�|�� A�ȿ�J��DDRAM
	INC	DPTR				;DPTR+1
	SJMP	LOOP			;���^LOOP��U�@�ӭ�

ENDTABLE:
	SJMP	$				
	

COMMAND:					;COMMAND�Ƶ{���|��A�ȿ�J��Instruction Register

	MOV	P2,A				;DATA�ȿ�J��P2�AP2����LCM��D0-D7
	MOV	P1,#00000100B		;E=1 , RW=0 , RS=0 �ADATA�g�iInstructionRegister
	MOV	P1,#00000000B		;E=0 , RW=0 , RS=0
	ACALL	DELAY40US		;����40 us
	RET						;RETURN

SDATA:						;SDATA�Ƶ{���|�� 
							;A�ȿ�J�� DD RAM
	MOV	P2,A
	MOV	P1,#00000101B		;E=1 , RW=0 , RS=1 �ADATA�g�i DD RAM
	MOV	P1,#00000001B		;E=0 , RW=0 , RS=1
	ACALL	DELAY40US		;����40 us
	RET						;RETURN

DELAY40US:
	MOV	R1,#20				;1 machine cycle���� 1us
 	DJNZ	R1,$			;DJNZ ����n 2 machine cycle=2us����20 ���Y�� 40us
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

	


TABLE:						;�n�g�JDD RAM�� DATA TABLE
	DB		"0610872",0
	END




