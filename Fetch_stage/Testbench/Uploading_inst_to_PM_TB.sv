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

logic [67:0] FetchStage_Output;
logic IR_rd;
logic IR_wr;
logic MAR_rd;
logic MAR_wr;
logic MDR_rd;
logic MDR_wr;
logic [4:0] PC_addressin;
logic PC_rd;
logic PC_wr;
logic [67:0] PM_inst_io;
logic PM_rd;
logic PM_wr;
logic clk;
logic [4:0] addressin;
logic [67:0] inst;
logic [5:0] writeaddress;


Fetch_stage_IP DUT(.FetchStage_Output(FetchStage_Output),
    .IR_rd(IR_rd),
    .IR_wr(IR_wr),
    .MAR_rd(MAR_rd),
    .MAR_wr(MAR_wr),
    .MDR_rd(MDR_rd),
    .MDR_wr(MDR_wr),
    .ProgramCounter_Address_in(PC_addressin),
    .ProgramCounter_rd(PC_rd),
    .ProgramCounter_wr(PC_wr),
    .ProgramMemory_rd(PM_rd),
    .ProgramMemory_wr(PM_wr),
    .Input_instruction(inst),
    .Input_instruction_address(addressin),
    .clk(clk));
 ///////////////////////////////////////////////////////////////////////////for input instruction to program memory/////////////////////////////////////// 
task Programmemory_input(input logic[5:0] add,input [67:0] ins); begin
@ (posedge clk);
addressin = add;
@ (negedge clk);
inst = ins;
end
endtask 

    
/*function logic[67:0] Programmemory_input(input logic[5:0] add); begin
case(add)
5'h00: return 68'h9_00000000_00000003;
5'h01: return 68'hD_0000000B_00000004;
5'h02: return 68'h0_00000000_0000000B;
5'h03: return 68'hB_00000000_00000005;
default: return 68'd0000;
endcase
end
endfunction*/         ////////////////////////////////////////////////Uncomment for using Function

/*always @ (posedge clk) begin
if (writeaddress <= 5'h04) begin
    $display("input address = %h", addressin);
    inst = Programmemory_input(addressin);
    writeaddress = addressin;
    addressin = addressin+1;
    $display("write address = %h", writeaddress); 
end
end*/                  /////////////////////////////////////////////Uncomment if using Function 

always @(posedge clk)begin
PM_rd =1'b1;
$display("instruction at address %h = %h", addressin,inst);
addressin= addressin+1;
end
        
initial begin
IR_rd = 1'b0;
IR_wr = 1'b0;
MAR_rd = 1'b0;
MAR_wr = 1'b0;
MDR_rd = 1'b0;
MDR_wr = 1'b0;
PC_addressin = 5'd0;
PC_rd = 1'b0;
PC_wr = 1'b0;
addressin = 5'h00;
//writeaddress = 5'h00;        /////////////////////////////uncomment if using function
PM_rd = 1'b0;
clk = 1'b0;
PM_wr=1'b1;
#1 Programmemory_input(5'h00,68'h9_00000000_00000003);
#1 Programmemory_input(5'h01, 68'hD_0000000B_00000004);
#1 Programmemory_input(5'h02,68'h0_00000000_0000000B);
#1 Programmemory_input(5'h03,68'hB_00000000_00000005);
#1 Programmemory_input(5'h04,68'h0_00000000_00000000); 
PM_wr=1'b0;
addressin = 5'h00;
inst = 68'd0;

end

always begin
clk = ~clk; #5;
end
endmodule
