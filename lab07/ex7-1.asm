    ORG 0000H 
    AJMP  START			//���L�O����00H~50H����m�A��������MAIN����m����
    ORG 0050H
START:
	MOV 	DPTR,#TABLE  	//�NTABLE�̭��s���ƭȥᵹDPTR�Ȧs��
	
ROW1:
	MOV 	P1,#7FH  		//�N7FH���ȥ��PORT1��(��ROW1���y)
	CALL 	DELAY  			//����Delay���Ƶ{������{���A������^�U���~�����
	MOV	A,P1  				//�NPORT1���ȥ��A����
	ANL	A,#0FH  			//�NA���ȩM0FH��AND�b�^�Ǩ�A����
	MOV	R1,#0  				//�N0�o�ӭȩ��R1�Ȧs������
	CJNE	A,#0FH,COL1  	//�P�_A�O�_������0FH�A�p�G������0FH�N����COL1�A�p�G����0FH�N����U�@��
	
ROW2:
	MOV 	P1,#0BFH  		//�NBFH���ȥ��PORT1��(��ROW2���y)
	CALL 	DELAY  			//����Delay���Ƶ{������{���A������^�U���~�����
	MOV	A,P1  				//�NPORT1���ȥ��A����
	ANL	A,#0FH  			//�NA���ȩM0FH��AND�b�^�Ǩ�A����
	MOV	R1,#4  				//�N4�o�ӭȩ��R1�Ȧs������
	CJNE	A,#0FH,COL1  	//�P�_A�O�_������0FH�A�p�G������0FH�N����COL1�A�p�G����0FH�N����U�@��
	
ROW3:
	MOV 	P1,#0DFH  		//�NDFH���ȥ��PORT1��(��ROW3���y)
	CALL 	DELAY  			//����Delay���Ƶ{������{���A������^�U���~�����
	MOV	A,P1  				//�NPORT1���ȥ��A����
	ANL	A,#0FH  			//�NA���ȩM0FH��AND�b�^�Ǩ�A����
	MOV	R1,#8  				//�N8�o�ӭȩ��R1�Ȧs������
	CJNE	A,#0FH,COL1  	//�P�_A�O�_������0FH�A�p�G������0FH�N����COL1�A�p�G����0FH�N����U�@��
	
ROW4:
	MOV 	P1,#0EFH  		//�NEFH���ȥ��PORT1��(��ROW4���y)
	CALL 	DELAY  			//����Delay���Ƶ{������{���A������^�U���~�����
	MOV	A,P1    			//�NPORT1���ȥ��A����
	ANL	A,#0FH    			//�NA���ȩM0FH��AND�b�^�Ǩ�A����
	MOV	R1,#12   			//�N12�o�ӭȩ��R1�Ȧs������
	CJNE	A,#0FH,COL1  	//�P�_A�O�_������0FH�A�p�G������0FH�N����COL1�A�p�G����0FH�N����U�@��
	JMP		ROW1  			//���^��ROW1����

COL1:
	CJNE	A,#0EH,COL2  	//�P�_A�O�_������0EH�A�p�G������0EH�N����COL2�A�p�G����0EH�N����U�@��
	MOV	R0,#0  				//�N0�o�ӭȩ��R0�Ȧs������
	JMP 	SHOW  			//����SHOW����

COL2:
	CJNE	A,#0DH,COL3  	//�P�_A�O�_������0DH�A�p�G������0DH�N����COL3�A�p�G����0DH�N����U�@��
	MOV	R0,#1  				//�N1�o�ӭȩ��R0�Ȧs������
	JMP 	SHOW  			//����SHOW����
	
COL3:
	CJNE	A,#0BH,COL4  	//�P�_A�O�_������0BH�A�p�G������0BH�N����COL4�A�p�G����0BH�N����U�@��
	MOV	R0,#2  				//�N2�o�ӭȩ��R0�Ȧs������
	JMP 	SHOW  			//����SHOW����
	
COL4:
	CJNE	A,#07H,ROW1  	//�P�_A�O�_������07H�A�p�G������07H�N���^��ROW1�A�p�G����07H�N����U�@��
	MOV	R0,#3  				//�N3�o�ӭȩ��R0�Ȧs������
	JMP 	SHOW  			//����SHOW����

SHOW:
	MOV	A,R1  				//�NR1���ȥ��A����
	ADD	A,R0  				//�NR0���ȩMA�ۥ[
	MOVC	A,@A+DPTR  		//���NA�MDPTR���Ȭۥ[��A�A��{���O���餤�����Щҫ�����m�A�N��m�ǵ�A
OVER:
	MOV 	P2,A  			//�NA���ȥ��PORT2����
	JMP		ROW1  			//���^��ROW1����
	
DELAY:
	MOV	R6,#100  			//�N100���ƭȩ��R6�Ȧs������
DELAY1:
	MOV	R7,#150  			//�N150���ƭȩ��R6�Ȧs������
DELAY2:
	DJNZ	R7,DELAY2  		//R7���ƭȥ���1�A�M���˹�R7�O�_��0�A�p�G�O�ܴN�]�U�@��A�p�G����0�A�N����DELAY3����
	DJNZ	R6,DELAY1  		//R6���ƭȥ���1�A�M���˹�R6�O�_��0�A�p�G�O���ܴN�]�U�@��A�p�G����0�A�N����DELAY2����
	RET  					//���^ACALL Delay���U��{���~�����
	
TABLE:
	DB	70H,71H,72H,73H
	DB	74H,75H,76H,77H
	DB	78H,79H,7AH,7BH
	DB	7CH,7DH,7EH,7FH
	END	

