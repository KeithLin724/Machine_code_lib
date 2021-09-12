	ORG 0000H
    AJMP MAIN 
    ORG 0050H
MAIN:
    MOV R0,#07FH; 
    MOV R1,#0FEH;
	MOV R2,#0FDH;
    MOV R3,#0FEH;
    MOV R4,#0FBH;

LOOP:
	MOV A,R4
	MOV P3,A
    MOV A,R0  
    ANL A,R1  
    MOV P1,A  
    MOV A,R0  
    RR A       
    MOV R0,A  
    MOV A,R1  
    RL A       
    MOV R1,A 
    ACALL DELAY 
	CJNE A,#07FH,LOOP
	JMP LOOP2

LOOP2:
	MOV A,R3
	MOV P3,A
    MOV A,R0  
    ANL A,R1  
    MOV P1,A  
    MOV A,R0  
    RR A       
    MOV R0,A  
    MOV A,R1  
    RL A       
    MOV R1,A 
    ACALL DELAY 
	CJNE A,#07FH,LOOP2
	JMP LOOP3  

LOOP3:
	MOV A,R2
	MOV P3,A
    MOV A,R0  
    ANL A,R1  
    MOV P1,A  
    MOV A,R0  
    RR A       
    MOV R0,A  
    MOV A,R1  
    RL A       
    MOV R1,A 
    ACALL DELAY 
	CJNE A,#07FH,LOOP3
	JMP LOOP


DELAY:
    MOV R5,#0FFH;  
DELAY1:
    MOV R6,#0FFH; 
DELAY2:
    MOV R7,#05H;  
DELAY3:
    DJNZ R7,DELAY3 
    DJNZ R6,DELAY2 
    DJNZ R5,DELAY1 
    RET  
    END

