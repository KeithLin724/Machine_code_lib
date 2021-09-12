    ORG 0000H 
    AJMP  START			//跳過記憶體00H~50H的位置，直接跳到MAIN的位置執行
    ORG 0050H
START:
	MOV 	DPTR,#TABLE  	//將TABLE裡面存的數值丟給DPTR暫存器
	
ROW1:
	MOV 	P1,#7FH  		//將7FH的值丟到PORT1中(對ROW1掃描)
	CALL 	DELAY  			//跳到Delay的副程式執行程式，完成後回下行繼續執行
	MOV	A,P1  				//將PORT1的值丟到A之中
	ANL	A,#0FH  			//將A的值和0FH做AND在回傳到A之中
	MOV	R1,#0  				//將0這個值放到R1暫存器之中
	CJNE	A,#0FH,COL1  	//判斷A是否不等於0FH，如果不等於0FH就跳到COL1，如果等於0FH就執行下一行
	
ROW2:
	MOV 	P1,#0BFH  		//將BFH的值丟到PORT1中(對ROW2掃描)
	CALL 	DELAY  			//跳到Delay的副程式執行程式，完成後回下行繼續執行
	MOV	A,P1  				//將PORT1的值丟到A之中
	ANL	A,#0FH  			//將A的值和0FH做AND在回傳到A之中
	MOV	R1,#4  				//將4這個值放到R1暫存器之中
	CJNE	A,#0FH,COL1  	//判斷A是否不等於0FH，如果不等於0FH就跳到COL1，如果等於0FH就執行下一行
	
ROW3:
	MOV 	P1,#0DFH  		//將DFH的值丟到PORT1中(對ROW3掃描)
	CALL 	DELAY  			//跳到Delay的副程式執行程式，完成後回下行繼續執行
	MOV	A,P1  				//將PORT1的值丟到A之中
	ANL	A,#0FH  			//將A的值和0FH做AND在回傳到A之中
	MOV	R1,#8  				//將8這個值放到R1暫存器之中
	CJNE	A,#0FH,COL1  	//判斷A是否不等於0FH，如果不等於0FH就跳到COL1，如果等於0FH就執行下一行
	
ROW4:
	MOV 	P1,#0EFH  		//將EFH的值丟到PORT1中(對ROW4掃描)
	CALL 	DELAY  			//跳到Delay的副程式執行程式，完成後回下行繼續執行
	MOV	A,P1    			//將PORT1的值丟到A之中
	ANL	A,#0FH    			//將A的值和0FH做AND在回傳到A之中
	MOV	R1,#12   			//將12這個值放到R1暫存器之中
	CJNE	A,#0FH,COL1  	//判斷A是否不等於0FH，如果不等於0FH就跳到COL1，如果等於0FH就執行下一行
	JMP		ROW1  			//跳回到ROW1執行

COL1:
	CJNE	A,#0EH,COL2  	//判斷A是否不等於0EH，如果不等於0EH就跳到COL2，如果等於0EH就執行下一行
	MOV	R0,#0  				//將0這個值放到R0暫存器之中
	JMP 	SHOW  			//跳到SHOW執行

COL2:
	CJNE	A,#0DH,COL3  	//判斷A是否不等於0DH，如果不等於0DH就跳到COL3，如果等於0DH就執行下一行
	MOV	R0,#1  				//將1這個值放到R0暫存器之中
	JMP 	SHOW  			//跳到SHOW執行
	
COL3:
	CJNE	A,#0BH,COL4  	//判斷A是否不等於0BH，如果不等於0BH就跳到COL4，如果等於0BH就執行下一行
	MOV	R0,#2  				//將2這個值放到R0暫存器之中
	JMP 	SHOW  			//跳到SHOW執行
	
COL4:
	CJNE	A,#07H,ROW1  	//判斷A是否不等於07H，如果不等於07H就跳回到ROW1，如果等於07H就執行下一行
	MOV	R0,#3  				//將3這個值放到R0暫存器之中
	JMP 	SHOW  			//跳到SHOW執行

SHOW:
	MOV	A,R1  				//將R1的值丟到A之中
	ADD	A,R0  				//將R0的值和A相加
	MOVC	A,@A+DPTR  		//先將A和DPTR的值相加後，再到程式記憶體中找到指標所指的位置，將位置傳給A
OVER:
	MOV 	P2,A  			//將A的值丟到PORT2之中
	JMP		ROW1  			//跳回到ROW1執行
	
DELAY:
	MOV	R6,#100  			//將100的數值放到R6暫存器之中
DELAY1:
	MOV	R7,#150  			//將150的數值放到R6暫存器之中
DELAY2:
	DJNZ	R7,DELAY2  		//R7的數值先減1，然後檢察R7是否為0，如果是話就跑下一行，如果不為0，就跳到DELAY3執行
	DJNZ	R6,DELAY1  		//R6的數值先減1，然後檢察R6是否為0，如果是的話就跑下一行，如果不為0，就跳到DELAY2執行
	RET  					//跳回ACALL Delay的下行程式繼續執行
	
TABLE:
	DB	70H,71H,72H,73H
	DB	74H,75H,76H,77H
	DB	78H,79H,7AH,7BH
	DB	7CH,7DH,7EH,7FH
	END	

