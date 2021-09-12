;P1块北47琿陪ボ竟陪ボ抖(->->κ->)
;璝璶ㄏ陪ボ,块癟腹0,はぇ块1

;P0块北7琿陪ボ竟┮陪ボず甧

;璶计硉跑篊,计硈尿陪ボ20Ω,R4璸硉暩

;R0既竟纗计Ω赣陪ボ计,R1计,R2κ,R3 

	ORG 0000H
	AJMP MAIN
	ORG 0050H
MAIN:					;箇砞计竟9990
	MOV R0,#0			;R0计 箇砞0 
	MOV R1,#9			;R1计 箇砞9 
	MOV R2,#9			;R2κ计 箇砞9 
	MOV R3,#9			;R3计 箇砞9 
	MOV R4,#0			;R4璸衡计碻吏Ω计 箇砞0 
	MOV DPTR,#TABLE		;盢0-9Data祘Α癘拘砰 
	
LOOP:
	MOV P1,#11110111B	;北Τ縊獹 
	MOV A,R0			;盢癟腹メ倒A 
	MOVC A,@A+DPTR		;盢竚@A+DPTRい癳倒A 
	MOV P0,A			;块APort0 -> 7琿陪ボ竟櫒
	INC R4				;碻吏Ω计 
	ACALL DELAY
	
	MOV P1,#11111011B	;北Τ縊獹 
	MOV A,R1		    ;盢癟腹メ倒A 
	MOVC A,@A+DPTR		;盢竚@A+DPTRい癳倒A 
	MOV P0,A			;块APort0 -> 7琿陪ボ竟 
	ACALL DELAY
	
	MOV P1,#11111101B	;北Τκ縊獹
	MOV A,R2			;盢κ癟腹メ倒A 
	MOVC A,@A+DPTR		;盢竚@A+DPTRい癳倒A 
	MOV P0,A			;块APort0 -> 7琿陪ボ竟 
	ACALL DELAY
	
	MOV P1,#11111110B	;北Τ縊獹
	MOV A,R3			;盢癟腹メ倒A 
	MOVC A,@A+DPTR		;盢竚@A+DPTRい癳倒A 
	MOV P0,A			;块APort0 -> 7琿陪ボ竟
	ACALL DELAY
	
	CJNE R4,#20,LOOP	;耞碻吏Ω计琌20,⊿Τ碞铬LOOP膥尿计 
	INC R0				;硈尿Ω计笷20,计 
	CJNE R0,#10,LOOP	;耞计琌10,⊿Τ碞铬LOOP膥尿计暩
	AJMP LOOP1			;はぇ铬LOOP2
	
LOOP1:					;计 
	MOV R0,#0			;盢计既竟R0 耴0浂
	INC R1				;计 
	CJNE R1,#10,LOOP	;耞计琌10,⊿Τ碞铬LOOP膥尿计婃暩
	AJMP LOOP2			;はぇ铬LOOP2 

LOOP2:					;计
	MOV R1,#0			;盢计既竟R1 耴0 
	INC R2              ;κ计 
	CJNE R2,#10,LOOP	;耞κ计琌10,⊿Τ碞铬LOOP膥尿计婃 
	AJMP LOOP3			;はぇ铬LOOP3  
	
LOOP3:					;κ计
	MOV R2,#0			;盢κ计既竟R2 耴0 
	INC R3				;计 
	CJNE R3,#10,LOOP	;耞计琌10,⊿Τ碞铬LOOP膥尿计婃
	AJMP LOOP4			;はぇ铬LOOP4 
	
LOOP4:					;计 
	MOV R3,#0			;盢计既竟R3 耴0 
	AJMP LOOP			;铬LOOP
	
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
	
TABLE:					;计陪ボ夹乓 
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
