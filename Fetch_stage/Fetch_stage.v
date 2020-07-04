`timescale 1 ps / 1 ps
//////////////////////////////////////
// Engineer : Jagrut Jadhav
/*
Modules Instantiated
- Program Counter
- Memory Address Register
- Memory Data Register
- Program Memory
- Instruction Register

*/
/////////////////////////////////////
module Fetch_stage_IP
   (FetchStage_Output,
    IR_rd,
    IR_wr,
    MAR_rd,
    MAR_wr,
    MDR_rd,
    MDR_wr,
    ProgramCounter_Address_in,
    ProgramCounter_rd,
    ProgramCounter_wr,
    ProgramMemory_Inst_inout,
    ProgramMemory_rd,
    ProgramMemory_wr,
    clk);
  output [66:0]FetchStage_Output;
  input IR_rd;
  input IR_wr;
  input MAR_rd;
  input MAR_wr;
  input MDR_rd;
  input MDR_wr;
  input [4:0]ProgramCounter_Address_in;
  input ProgramCounter_rd;
  input ProgramCounter_wr;
  inout [66:0]ProgramMemory_Inst_inout;
  input ProgramMemory_rd;
  input ProgramMemory_wr;
  input clk;

  wire IR_0_PCenable;
  wire [66:0]IR_0_fetchout;
  wire IR_rd_1;
  wire IR_wr_1;
  wire [4:0]MAR_0_addout;
  wire MAR_rd_1;
  wire MAR_wr_1;
  wire MDR_rd_1;
  wire MDR_wr_1;
  wire Net;
  wire [66:0]Net1;
  wire [4:0]ProgramCounter_Address_in_1;
  wire ProgramCounter_rd_1;
  wire ProgramCounter_wr_1;
  wire ProgramMemory_rd_1;
  wire ProgramMemory_wr_1;
  wire [4:0]program_counter_0_addressout;

  assign FetchStage_Output[66:0] = IR_0_fetchout;
  assign IR_rd_1 = IR_rd;
  assign IR_wr_1 = IR_wr;
  assign MAR_rd_1 = MAR_rd;
  assign MAR_wr_1 = MAR_wr;
  assign MDR_rd_1 = MDR_rd;
  assign MDR_wr_1 = MDR_wr;
  assign Net = clk;
  assign ProgramCounter_Address_in_1 = ProgramCounter_Address_in[4:0];
  assign ProgramCounter_rd_1 = ProgramCounter_rd;
  assign ProgramCounter_wr_1 = ProgramCounter_wr;
  assign ProgramMemory_rd_1 = ProgramMemory_rd;
  assign ProgramMemory_wr_1 = ProgramMemory_wr;
  IR IR_0
       (.IR_rd(IR_rd_1),
        .IR_wr(IR_wr_1),
        .PCenable(IR_0_PCenable),
        .clk(Net),
        .fetchout(IR_0_fetchout),
        .inst(ProgramMemory_Inst_inout[66:0]));
  MAR MAR_0
       (.MAR_rd(MAR_rd_1),
        .MAR_wr(MAR_wr_1),
        .addin(program_counter_0_addressout),
        .addout(MAR_0_addout),
        .clk(Net));
  MDR MDR_0
       (.MDR_rd(MDR_rd_1),
        .MDR_wr(MDR_wr_1),
        .clk(Net),
        .inst(ProgramMemory_Inst_inout[66:0]));
  program_counter program_counter_0
       (.CE(IR_0_PCenable),
        .PC_rd(ProgramCounter_rd_1),
        .PC_wr(ProgramCounter_wr_1),
        .addressin(ProgramCounter_Address_in_1),
        .addressout(program_counter_0_addressout),
        .clk(Net));
  program_memory program_memory_0
       (.PM_rd(ProgramMemory_rd_1),
        .PM_wr(ProgramMemory_wr_1),
        .address(MAR_0_addout),
        .clk(Net),
        .inst(ProgramMemory_Inst_inout[66:0]));
endmodule
