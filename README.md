# 32-bit-Pipelined-Processor

Project Under Development


```
MIPS instruction R - type
________________ _______________________________________________________________________
|    OPCODE     |  RS     |    RT    |       RD      |    SHIFT      |      FUNCTION    |
|_______________|_SOURCE1_|__SOURCE2_|__Destination__|_______________|__________________|
|     6-bit     |   5 bit |   5 bit  |      5bit     |     5 bit     |        6 bit     |
|_______________|_________|__________|_______________|_______________|__________________|
------Function---
ADD    (0x20)
SUB    (0x1A)
MUL    (0x18)
DIV    (0x22)

MIPS instruction I -type 
________________ _______________________________________________________________________
|    OPCODE     |  RS     |    RT        |        Offset address                        |
|_______________|_SOURCE1_|_Destination__|______________________________________________|
|     6-bit     |   5 bit |   5 bit      |          16 bit                              |
|_______________|_________|______________|______________________________________________|
LW - load word
LA - load address
LI - load Immidiate
SW - store word
ADDI - add immidiate  

0x01 > register 1
0x02 > register 2
0x03 > register 3
0x04 > register 4

Instructions used
LW $1, 0x00(0x00)    =>  0x8C010000  (100011_00000_00001_0000000000000000)
LW $2, 0x01(0x00)    =>  0x8C020001  (100011_00000_00010_0000000000000001)
ADD $3,$1,$2         =>  0x00411820  (000000_00010_00001_00011_00000_100000)
SW $3, 0x02(0x00)    =>  0x8C030002  (100011_00000_00011_0000000000000010)
ADDI $4,$2,100       =>  0x20440006  (001000_00010_00100_0000000000000110)
```

*_ Instructions I made and used _*

* LW $1, 0x00(0x00)    =>  0x8C010000  (100011_00000_00001_0000000000000000)

* LW $2, 0x01(0x00)    =>  0x8C020001  (100011_00000_00010_0000000000000001)

* ADD $3,$1,$2         =>  0x00411820  (000000_00010_00001_00011_00000_100000)

* SW $3, 0x02(0x00)    =>  0x8C030002  (100011_00000_00011_0000000000000010)

* ADDI $4,$2,100       =>  0x20440006  (001000_00010_00100_0000000000000110) 

# Fetch Stage #
The Fetch stage designed by me takes 3 cycles to fetch the inctruction from the program memory and output the instruction from Instruction Register to Decode Stage.

*_ Fetch Stage Block Design:- _*

![](Fetch_stage/Fetch_stage.JPG)

The process of the fetch stage is as follows-
1. Program Counter Address => Memory Address Register
2. Memory Address Register Address => Program Memory
3. Program counter address => program counter address + 1
4. Program memory instruction @ MAR address => Memory Data Register
5. Memory Data Register => Instruction Register
6. Instruction Register => Decode stage

*_ Fetch Stage Simulation using System Verilog:- _*

![](Fetch_stage/Testbench/Fetch_Stage_simulation.JPG)
