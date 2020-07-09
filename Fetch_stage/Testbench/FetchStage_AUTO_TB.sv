`timescale 1ns / 1ps
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


module FetchStage_AUTO_TB();


logic [67:0] Fetch_out;
logic [4:0] PC_addressin;
logic PC_read;
logic [67:0] PM_inst_inp;
logic PM_rd;
logic clk;
logic reset;

/*FetchStage_AUTO
   DUT_2 (.Fetch_out(Fetch_out),
    .PC_addressin(PC_addressin),
    .PC_read(PC_read),
    .PM_inst_inp(PM_inst_inp),
    .PM_rd(PM_rd),
    .clk(clk),
    .reset(reset));
    
always begin
clk = ~clk; #5;
end*/
endmodule
