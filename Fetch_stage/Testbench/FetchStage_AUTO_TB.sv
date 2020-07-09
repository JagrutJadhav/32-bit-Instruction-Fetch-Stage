`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jagrut Jadhav
// Create Date: 06/30/2020 05:57:13 PM
// Module Name: Fetch Stage Testbench
// Project Name:Pipelined Processor 
/*

000 > ADD
001 > SUB
010 > MUL
011 > DIV
100 > LDA
101 > STA

1 > Address Addressing mode
0 > Data Addressing mode

1011 > register B
1100 > register C

Instructions examples
LDA 0x03        // 100 1 0x00000000 0x00000003
MOB B , 0x04    // 110 1 0x0000000B 0x00000004
ADD B           // 000 0 0x00000000 0x0000000B
STA 0x05        // 101 1 0x00000000 0x00000005
*/
//////////////////////////////////////////////////////////////////////////////////


module Fetch_TestBench();


logic [67:0] Fetch_out;
logic [4:0] PC_addressin;
logic PC_write;
logic [67:0] PM_inst_inp;
logic PM_wr;
logic clk;
logic reset;
logic [67:0] PM [5:0];
logic start;
logic ControlSig_1;
logic ControlSig_2;
//////////
logic [1:0] count;
logic [67:0] inst;
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
PM_inst_inp <= 68'dz;
ControlSig_2 <= 1'b0;
ControlSig_1 <= 1'b0;
PM_wr <= 1'b0;
clk <= 1'b0;
//PC_wr(1'b1);
for (int i=0 ; i<= 5'h03; i=i+1)
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
output reg [67:0] inst);

logic [67:0] PM [5:0];
initial $readmemh("Instructions.mem",PM);
reg [67:0] instruction;
always @ (posedge clk) begin
//$display("Entered Program memory");
if (PM_read) begin
    inst <= PM[PM_add];
    //$display("instrucion = %h",instruction);
end
end
endmodule

