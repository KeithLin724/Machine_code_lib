ORG	0000H
	JMP	START
	ORG	0050H
START:
	MOV	A,#00010001B
	MOV R0,#0
MAIN:
	MOV	P1,A
	CALL	DELAY
	RR		A
	INC		R0
	CJNE	R0,#75,MAIN
	MOV	R0,#0
MAIN1:
	MOV	P1,A
	CALL	DELAY
	RL		A
	INC		R0
	CJNE	R0,#150,MAIN1
	MOV	R0,#0
	JMP	MAIN
DELAY:
	MOV	R6,#200
DELAY1:
	MOV	R7,#250
DELAY2:
	DJNZ	R7,DELAY2
	DJNZ	R6,DELAY1
	RET
END
