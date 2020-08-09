`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jagrut Jadhav
// Create Date: 06/30/2020 05:57:13 PM
// Module Name: Fetch Stage Testbench
// Project Name:Pipelined Processor 
/*

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
*/
//////////////////////////////////////////////////////////////////////////////////


module Fetch_TestBench();


logic [31:0] Fetch_out;
logic [4:0] PC_addressin;
logic PC_write;
logic [31:0] PM_inst_inp;
logic PM_wr;
logic clk;
logic reset;
logic [31:0] PM [5:0];
logic start;
logic ControlSig_1;
logic ControlSig_2;
//////////
logic [1:0] count;
logic [31:0] inst;
logic [1:0] control;
FetchStage_AUTO
   DUT_2 (.Fetch_out(Fetch_out),
    .PC_addressin(PC_addressin),
    .PC_write(PC_write),
    .PM_inst_inp(PM_inst_inp),
    .PM_wr(PM_wr),
    .clk(clk),
    .reset(reset),
    .ControlSig_1(ControlSig_1),
    .ControlSig_2(ControlSig_2));
    
PM_dummy PM_dum( .PM_add(DUT_2.MAR_0.addout),
.PM_read(DUT_2.MDR_2_0.MDR_wr),// low signal => write into program memory , High => read from program memory
.clk(clk), 
.inst(inst));

  
initial $readmemh("Instructions.mem",PM);
initial begin
reset <= 1'b0;
PC_write <= 1'b0;
count <= 2'd0;
PM_inst_inp <= 32'dz;
ControlSig_2 <= 1'b0;
ControlSig_1 <= 1'b0;
PM_wr <= 1'b0;
clk <= 1'b0;
//PC_wr(1'b1);
   for (int i=0 ; i<= 4'h03; i=i+1)
$display("instruction at address %h = %h",i,PM[i]);
end


assign  DUT_2.MDR_2_0.instin = inst;

always @ (ControlSig_2,
ControlSig_1) begin

$display("SIG 1 = %b  ,  SIG 2 = %b,  SIG 3 = %b,  SIG 4 = %b .......... Control signal = %b",DUT_2.Control_Unit_Fetch_0.sig1, DUT_2.Control_Unit_Fetch_0.sig2,DUT_2.Control_Unit_Fetch_0.sig3,DUT_2.Control_Unit_Fetch_0.sig4,{ControlSig_2,
ControlSig_1});
$display("Program Counter inside ADDRESS %h",DUT_2.Program_counter_2_0.i);
$display(".Program Counter ADDRESS line success %h",DUT_2.Program_counter_2_0.addressout);
$display("..MAR address inside ADDRESS %h    MAR_wr =%b     MAR_rd=%b",DUT_2.MAR_0.address,DUT_2.MAR_0.MAR_wr,DUT_2.MAR_0.MAR_rd);
$display("...MAR address line out = %h , Instruction line of PM = %h",DUT_2.MAR_0.addout, inst);
$display("....MDR Instruction inside = %h     MDR_wr=%b     MDR_rd=%b ",DUT_2.MDR_2_0.instram,DUT_2.MDR_2_0.MDR_wr,DUT_2.MDR_2_0.MDR_rd);
$display("....IR Instruction input line = %h     IR_wr=%b     IR_rd=%b ",DUT_2.IR_0.instram,DUT_2.IR_0.IR_wr,DUT_2.IR_0.IR_rd);
end
always #20 ControlSig_2 = ~ ControlSig_2;
always #10 ControlSig_1 = ~ControlSig_1;

always begin
clk = ~clk; #5;
end
endmodule



module PM_dummy(input [4:0] PM_add,
input PM_read,// low signal => write into program memory , High => read from program memory
input clk, 
output reg [31:0] inst);

logic [31:0] PM [5:0];
initial $readmemh("Instructions.mem",PM);
reg [31:0] instruction;
always @ (posedge clk) begin
//$display("Entered Program memory");
if (PM_read) begin
    inst <= PM[PM_add];
    //$display("instrucion = %h",instruction);
end
end
endmodule

