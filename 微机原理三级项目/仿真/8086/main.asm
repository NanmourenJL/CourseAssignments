DATASE SEGMENT
C8253CTRL  EQU 0A006H
C8253A	   EQU 0A000H
C8253B	   EQU 0A002H
C8253C	   EQU 0A004H		;8253地址

C8255CTRL  EQU 08006H
C8255A	   EQU 08000H
C8255B	   EQU 08002H
C8255C	   EQU 08004H		;8255地址

C8259ICW1  EQU 09000H
C8259ICW2  EQU 09002H
C8259ICW3  EQU 09002H
C8259ICW4  EQU 09002H		;8259A初始化命令字地址

C8259OCW1  EQU 09002H
C8259OCW2  EQU 09000H
C8259OCW3  EQU 09000H		;8259A操作命令字地址


MAX7219_ADDR  DB 00H		;待访问的MAX7219寄存器地址（MAX7219_WRITE_DATA调用）
MAX7219_DATA  DB 00H		;待访问的MAX7219寄存器数据（MAX7219_WRITE_DATA调用）
MAX7219_DIN_H	   EQU 02H	;CS=0 DIN=1 CLK=0  (INC DIN_H能使得时钟线拉高)
MAX7219_DIN_L	   EQU 00H	;CS=0 DIN=0 CLK=0  (INC DIN_L能使得时钟线拉高)
MAX7219_CS_H 	   EQU 04H	;CS=1

LS595_OUTPUT DB 00H		;待74LS595输出的数据（DIGITAL_OUTPUT调用）
LS595_DAT_H EQU 14H		;RCK=0 DAT=1 SCK=0 (ADD DAT,08H能使得时钟线拉高)
LS595_DAT_L EQU 04H		;RCK=0 DAT=0 SCK=0 (ADD DAT,08H能使得时钟线拉高)
LS595_RCK_H EQU 24H		;RCK=1
LS595_RCK_L EQU 04H		;RCK=0

CHAR_NUMBER DB 00H		;指示点阵下一个显示的字（INT0调用）

DIGITAL_NUM DB 0FCH,060H,0DAH,0F2H,66H,0B6H,0BEH,0E0H,0FEH,0F6H;
	
		;点阵字库,每两行代表一个字, "检测二班游寅龙"	
NAME_CHAR DB 000H,010H,010H,010H,07CH,011H,013H,032H,03DH,077H,051H,051H,010H,014H,017H,010H
DB 000H,060H,060H,0F0H,090H,00CH,0F6H,000H,044H,06CH,028H,0A8H,010H,010H,0FEH,000H
DB 000H,000H,077H,014H,004H,045H,065H,025H,005H,015H,015H,023H,022H,046H,04CH,000H
DB 000H,006H,0C6H,056H,056H,056H,056H,056H,056H,056H,056H,096H,086H,046H,04EH,000H
DB 000H,000H,000H,000H,03FH,000H,000H,000H,000H,000H,000H,000H,07FH,07FH,000H,000H
DB 000H,000H,000H,000H,0F8H,000H,000H,000H,000H,000H,000H,000H,0FEH,0FEH,000H,000H
DB 000H,000H,000H,07CH,010H,012H,012H,012H,07EH,010H,010H,010H,01DH,073H,042H,000H
DB 000H,080H,0C0H,0BEH,088H,088H,088H,088H,0BEH,088H,088H,088H,008H,008H,07EH,000H
DB 000H,006H,062H,010H,00FH,044H,064H,017H,004H,024H,034H,024H,02CH,068H,05BH,000H
DB 000H,010H,010H,03EH,0A0H,060H,07EH,084H,088H,088H,0BEH,088H,088H,088H,038H,010H
DB 000H,001H,001H,07FH,040H,05FH,001H,01FH,011H,01FH,011H,01FH,004H,00CH,030H,020H
DB 000H,000H,080H,0FEH,006H,0F6H,080H,0F8H,088H,0F8H,088H,0F8H,020H,038H,00EH,000H
DB 000H,003H,003H,003H,003H,07FH,002H,002H,002H,006H,004H,00CH,018H,031H,066H,000H
DB 000H,000H,030H,018H,000H,0FEH,0C0H,0C0H,0C8H,0D8H,0F0H,0E0H,0C0H,0C2H,0FEH,000H
DATASE ENDS

STACKSE SEGMENT STACK
	DW 256H DUP(?)
STACKSE ENDS

EXTRASE	SEGMENT
	DW 256H DUP(?)
EXTRASE	ENDS

CODESE  SEGMENT PUBLIC 'CODE'
;;;;;;;;主函数;;;;;;;;
	MAIN	PROC
		ASSUME CS:CODESE, DS:DATASE, SS:STACKSE, ES:EXTRASE
	START:
		CLI			;关闭中断
		
		MOV AX, DATASE
		MOV DS, AX
		MOV AX, STACKSE
		MOV SS, AX
		MOV AX, EXTRASE
		MOV ES, AX		;段寄存器赋值
		
		MOV DX, C8255CTRL
		MOV AL, 10000010B
		OUT DX, AL		;8255初始化——A口输出，B口输入
		
		CALL MAX7219_INIT	;调用子程序初始化MAX7219
		
		MOV DX, C8253CTRL
		MOV AL, 00010110B
		OUT DX, AL		;8253初始化——打开计数器0
		
		MOV DX, C8253CTRL
		MOV AL, 01010110B
		OUT DX, AL		;8253初始化——打开计数器1
		
		MOV DX, C8253A 
		MOV AL, 006FH
		OUT DX, AL		;8253初始化——计数器0计数6FH
		
		MOV DX, C8253B
		MOV AL, 04FH
		OUT DX, AL		;8253初始化——计数器0计数4FH
		
		MOV DX, C8259ICW1
		MOV AL, 00010011B
		OUT DX, AL		;8259A初始化——设置为单片上升沿触发
		
		MOV DX, C8259ICW2
		MOV AL, 060H
		OUT DX, AL		;8259A初始化——设置IR0-IR7对应中断向量60H-67H
		
		MOV DX, C8259ICW4
		MOV AL, 00000001B
		OUT DX, AL		;8259A初始化——设置为一般嵌套、非缓冲
		
		MOV DX, C8259OCW1
		MOV AL, 11111100B
		OUT DX, AL		;8259A初始化——屏蔽高六位中断，只保留IR0、IR1
		
		MOV AX, 00H
		MOV ES, AX		;定义中断向量表——附加段段基地址指向向量表段基地址
		
		MOV BX, 60H*4
		MOV AX, OFFSET INT0
		MOV ES:[BX], AX		;定义中断向量表——写入中断服务函数的偏移地址
	
		MOV AX, CS
		MOV ES:[BX+2], AX	;定义中断向量表——写入中断服务函数的段基地址
		
		STI			;开启中断
		
	LOOP_C:
		MOV DX,C8255B
		IN  AL,DX		;读取按键数据
		
		NOT AL			;由于按键采用反逻辑，因此需要改为正逻辑
		
		MOV LS595_OUTPUT,AL
		CALL DIGITAL_OUTPUT	;将二进制交予数码管处理函数处理
		
		JMP LOOP_C		;跳回主函数形成死循环，防止停机
		
		RET			;实际运行不到，为了防止编译器给予警告
	MAIN ENDP
	
;;;;;;;;MAX7219初始化函数;;;;;;;;
	MAX7219_INIT PROC
		MOV MAX7219_ADDR, 09H
		MOV MAX7219_DATA, 00H	;译码方式设为不译码，地址0xX9，数值0x00
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA	;四片芯片都是该译码方式
		MOV DX,C8255A
		MOV AL,MAX7219_CS_H
		OUT DX,AL		;传送结束，拉起片选信号
		
		MOV MAX7219_ADDR, 0AH	;亮度为7/32，地址0xXA，数值0xX3
		MOV MAX7219_DATA, 03H
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA	;四片芯片都是该亮度
		MOV DX,C8255A
		MOV AL,MAX7219_CS_H
		OUT DX,AL		;传送结束，拉起片选信号
		
		MOV MAX7219_ADDR, 0BH
		MOV MAX7219_DATA, 07H	;扫描界限为8行，地址0xXB，数值0xX7
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA	;四片芯片都是该扫描界限
		MOV DX,C8255A
		MOV AL,MAX7219_CS_H
		OUT DX,AL		;传送结束，拉起片选信号
		
		MOV MAX7219_ADDR, 0CH
		MOV MAX7219_DATA, 01H	;关断寄存器为普通模式，地址0xXC，数值0xX1
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA	;四片芯片都是该普通模式
		MOV DX,C8255A
		MOV AL,MAX7219_CS_H
		OUT DX,AL		;传送结束，拉起片选信号
		
		MOV MAX7219_ADDR, 0FH
		MOV MAX7219_DATA, 00H	;显示器寄存器测试模式为关闭，地址0xXF，数值0xX0
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA
		CALL MAX7219_WRITE_DATA	;四片芯片都是该关闭模式
		MOV DX,C8255A
		MOV AL,MAX7219_CS_H
		OUT DX,AL		;传送结束，拉起片选信号
		
		RET			;返回原函数
	MAX7219_INIT ENDP
;;;;;;;;MAX7219单片数据写入;;;;;;;;
	MAX7219_WRITE_DATA PROC
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX		;保护现场
		
		MOV DX,C8255A	;设置输出端口为8255的A口（DX以下不再变动）
		
		;按照芯片输出时序，先传送地址。
		MOV BL, MAX7219_ADDR	;传送地址入BX寄存器
		MOV CL, 08H		;计数器置为8（一个字节八位）
	ADDR_LOOP:
		TEST BL, 80H  		;将BL与80H求与，测试BL最高位是否是1
		JNZ ADDR_EQU_1		;跳转到传送低电平方案
		MOV AL, MAX7219_DIN_L
		JMP ADDR_EQU_0		;跳出分支结构
	ADDR_EQU_1:
		MOV AL, MAX7219_DIN_H
	ADDR_EQU_0:
		OUT DX, AL	;输出数据（此时时钟线为低）
		INC AL
		OUT DX, AL	;拉高时钟线并输出
		SHL BX, 01H	;左移，准备输出下一位
		LOOP ADDR_LOOP	;循环8次（每次传送一位）
		
		;按照芯片输出时序，再传送数据。
		MOV BL, MAX7219_DATA	;传送数据入BX寄存器
		MOV CL, 08H		;计数器置为8（一个字节八位）
	DATA_LOOP:
		TEST BL, 80H  		;将BL与80H求与，测试BL最高位是否是1
		JNZ DATA_EQU_1		;跳转到传送低电平方案
		MOV AL, MAX7219_DIN_L
		JMP DATA_EQU_0		;跳出分支结构
	DATA_EQU_1:
		MOV AL, MAX7219_DIN_H
	DATA_EQU_0:
		OUT DX, AL	;输出数据（此时时钟线为低）
		INC AL
		OUT DX, AL	;拉高时钟线并输出
		SHL BX, 01H	;左移，准备输出下一位
		LOOP DATA_LOOP	;循环8次（每次传送一位）
		
		POP DX
		POP CX
		POP BX
		POP AX		;恢复现场
		RET		;返回原函数
	MAX7219_WRITE_DATA ENDP
;;;;;;;;74LS595输出三位数;;;;;;;;
	DIGITAL_OUTPUT PROC FAR
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX		;保护现场
		
		MOV DX, C8255A	;设置输出端口为8255的A口（DX以下不再变动）
		
		;先输出个位
		MOV AX, 00H		;将AH置0
		MOV AL, LS595_OUTPUT	;取出需要输出的三位数
		MOV BX, 10D
		DIV BL			;除以10（余数在AH，商在AL）
		PUSH  AX		;入栈（保留商，也就是十位和百位）
		MOV CL, 8H
		ROR AX, CL		;将余数（个位）移动至AL
		MOV BX, OFFSET DIGITAL_NUM	;取出数码管字库的数组首地址
		XLAT 			;查表（BX表示表格首地址，AL表示表内位移量）
		MOV BL, AL ;将数据放入BX寄存器（OUT指令只允许输出AX，判断需在BX中进行）
	OUPUT1_LOOP:
		TEST BL, 01H  		;将BL与80H求与，测试BL最高位是否是1
		JNZ OUPUT1_EQU_1	;跳转到传送高电平方案
		MOV AL, LS595_DAT_L
		JMP OUPUT1_EQU_0	;跳出分支结构
	OUPUT1_EQU_1:
		MOV AL, LS595_DAT_H
	OUPUT1_EQU_0:
		OUT DX, AL		;输出数据（此时时钟线为低）
		ADD AL, 08H		;拉高时钟线并输出
		OUT DX, AL 
		SHR BX, 01H		;右移，准备输出下一位
		LOOP OUPUT1_LOOP	;循环8次（每次传送一位）
		
		;随后输出十位
		POP AX			;取出上次除以10后的商和余数
		AND AX,00FFH		;清空AH（清空余数，只保留十位和百位的商）
		MOV BX, 10D
		DIV BL			;除以10（余数在AH，商在AL）
		PUSH  AX		;入栈（保留商，也就是百位）
		MOV CL, 8H
		ROR AX, CL		;将余数（十位）移动至AL
		MOV BX, OFFSET DIGITAL_NUM	;取出数码管字库的数组首地址
		XLAT 			;查表（BX表示表格首地址，AL表示表内位移量）
		MOV BL, AL ;将数据放入BX寄存器（OUT指令只允许输出AX，判断需在BX中进行）
	OUPUT2_LOOP:
		TEST BL, 01H  		;将BL与80H求与，测试BL最高位是否是1
		JNZ OUPUT2_EQU_1	;跳转到传送高电平方案
		MOV AL, LS595_DAT_L
		JMP OUPUT2_EQU_0	;跳出分支结构
	OUPUT2_EQU_1:
		MOV AL, LS595_DAT_H
	OUPUT2_EQU_0:
		OUT DX, AL		;输出数据（此时时钟线为低）
		ADD AL, 08H		;拉高时钟线并输出
		OUT DX, AL 
		SHR BX, 01H		;右移，准备输出下一位
		LOOP OUPUT2_LOOP	;循环8次（每次传送一位）
		
		;最后输出百位
		POP AX			;取出上次除以10后的商和余数
		MOV BX, OFFSET DIGITAL_NUM	;取出数码管字库的数组首地址
		XLAT 			;查表（BX表示表格首地址，AL表示表内位移量）
		MOV BL, AL ;将数据放入BX寄存器（OUT指令只允许输出AX，判断需在BX中进行）
		MOV CL, 8H		;计数器置为8（一个字节八位）
	OUPUT3_LOOP:
		TEST BL, 01H  		;将BL与80H求与，测试BL最高位是否是1
		JNZ OUPUT3_EQU_1	;跳转到传送高电平方案
		MOV AL, LS595_DAT_L
		JMP OUPUT3_EQU_0	;跳出分支结构
	OUPUT3_EQU_1:
		MOV AL, LS595_DAT_H
	OUPUT3_EQU_0:
		OUT DX, AL		;输出数据（此时时钟线为低）
		ADD AL, 08H		;拉高时钟线并输出
		OUT DX, AL 
		SHR BX, 01H		;右移，准备输出下一位
		LOOP OUPUT3_LOOP	;循环8次（每次传送一位）
		
		MOV AL, LS595_RCK_H
		OUT DX, AL  ;拉高存储时钟线，从移位寄存器转存带存储寄存器（相当于显示输出）
		
		MOV AL, LS595_RCK_L
		OUT DX, AL	;拉低存储时钟线，方便下一次输入数据
		
		POP DX
		POP CX
		POP BX
		POP AX		;恢复现场
		
		RET		;返回原函数
	DIGITAL_OUTPUT ENDP

;;;;;;;;定时器中断服务函数;;;;;;;;
	INT0 PROC 
		CLI		;关闭中断
		
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX		;保护现场
		
		MOV AL,CHAR_NUMBER		;取出需要输出的汉字位
		MOV BL,32D
		MUL BL		;乘以32（一个汉字占32字节）
		MOV BX,OFFSET NAME_CHAR
		ADD BX,AX	;将点阵字库数组的地址加上汉字偏移
				;得到对应汉字存储数组的首地址（相当于基址变址相对寻址）
		
		MOV CX,08H		;计数器置为8（每个点阵八行）
	NEXT_CHAR:
		MOV MAX7219_ADDR, CL	;给与芯片寄存器地址
		
		MOV AL,CL
		ADD AL,23D		;推定第四个点阵需要显示的行值
		PUSH AX			;保存AL（方便其他点阵的推定）
		XLAT			;查表，获取第四个点阵需要输出的值
		MOV MAX7219_DATA, AL	
		CALL MAX7219_WRITE_DATA	;将输出值交由函数负责输出
		
		POP AX
		SUB AL,8H		;推定第三个点阵需要显示的行值
		PUSH AX			;保存AL（方便其他点阵的推定）
		XLAT			;查表，获取第三个点阵需要输出的值
		MOV MAX7219_DATA, AL
		CALL MAX7219_WRITE_DATA	;将输出值交由函数负责输出
		
		POP AX
		SUB AL,8H		;推定第二个点阵需要显示的行值
		PUSH AX			;保存AL（方便其他点阵的推定）
		XLAT			;查表，获取第二个点阵需要输出的值
		MOV MAX7219_DATA, AL
		CALL MAX7219_WRITE_DATA	;将输出值交由函数负责输出
		
		POP AX
		SUB AL,8H		;推定第一个点阵需要显示的行值
		XLAT			;查表，获取第一个点阵需要输出的值
		MOV MAX7219_DATA, AL
		CALL MAX7219_WRITE_DATA	;将输出值交由函数负责输出
		
		MOV AL,MAX7219_CS_H
		OUT DX,AL		;传送结束，拉起片选信号
		
		LOOP NEXT_CHAR		;循环8次（每次四个芯片各传送一行）
		
		MOV AL,CHAR_NUMBER
		INC AL			;输出汉字位加一
		
		CMP AL,07H
		JC CHAR_NUMBER_ISNOT_7	;未超出汉字存储位数，跳出分支结构
		MOV AX,00H		;超出汉字存储位数，回到第一个汉字
	CHAR_NUMBER_ISNOT_7:
		MOV CHAR_NUMBER,AL	;保存下一次输出汉字位
		
		MOV DX,C8259OCW2
		MOV AL,20H
		OUT DX,AL		;告知8259A中断处理结束
		
		POP DX
		POP CX
		POP BX
		POP AX			;恢复现场
		
		STI			;打开中断
		
		IRET			;返回中断点
	INT0 ENDP
CODESE   ENDS
	END MAIN