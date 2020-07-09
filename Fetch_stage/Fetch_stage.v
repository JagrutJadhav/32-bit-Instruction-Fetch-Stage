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
module FetchStage_AUTO
   (ControlSig_1,
    ControlSig_2,
    Fetch_out,
    PC_addressin,
    PC_write,
    PM_inst_inp,
    PM_wr,
    clk,
    reset);
  input ControlSig_1;
  input ControlSig_2;
  output [67:0]Fetch_out;
  input [4:0]PC_addressin;
  input PC_write;
  input [67:0]PM_inst_inp;
  input PM_wr;
  input clk;
  input reset;

  wire ControlSig_1_1;
  wire ControlSig_2_1;
  wire IR_0_PCenable;
  wire [67:0]IR_0_fetchout;
  wire [4:0]MAR_0_addout;
  wire MAR_0_new_feed;
  wire MDR_2_0_new_feed;
  wire [67:0]MDR_2_0_upgraded_ipi_inst;
  wire Net1;
  wire [4:0]PC_addressin_1;
  wire PC_write_1;
  wire [67:0]PM_inst_inp_1;
  wire PM_wr_1;
  wire [4:0]Program_counter_2_0_addressout;
  wire [67:0]program_memory_0_inst;
  wire reset_1;

  assign ControlSig_1_1 = ControlSig_1;
  assign ControlSig_2_1 = ControlSig_2;
  assign Fetch_out[67:0] = IR_0_fetchout;
  assign Net1 = clk;
  assign PC_addressin_1 = PC_addressin[4:0];
  assign PC_write_1 = PC_write;
  assign PM_inst_inp_1 = PM_inst_inp[67:0];
  assign PM_wr_1 = PM_wr;
  assign reset_1 = reset;
  Control_Unit_Fetch Control_Unit_Fetch_0
       (.clk(Net1),
        .control_1(ControlSig_1_1),
        .control_2(ControlSig_2_1),
        .sig1(IR_0_PCenable),
        .sig2(MAR_0_new_feed),
        .sig3(MDR_2_0_new_feed));
  IR IR_0
       (.IR_rd(MAR_0_new_feed),
        .IR_wr(MDR_2_0_new_feed),
        .clk(Net1),
        .fetchout(IR_0_fetchout),
        .inst(MDR_2_0_upgraded_ipi_inst));
  MAR MAR_0
       (.MAR_rd(MAR_0_new_feed),
        .MAR_wr(IR_0_PCenable),
        .addin(Program_counter_2_0_addressout),
        .addout(MAR_0_addout),
        .clk(Net1));
  MDR_2 MDR_2_0
       (.MDR_rd(MDR_2_0_new_feed),
        .MDR_wr(MAR_0_new_feed),
        .clk(Net1),
        .inst(MDR_2_0_upgraded_ipi_inst),
        .instin(program_memory_0_inst));
  Program_counter_2 Program_counter_2_0
       (.CE(MAR_0_new_feed),
        .PC_rd(IR_0_PCenable),
        .PC_wr(PC_write_1),
        .addressin(PC_addressin_1),
        .addressout(Program_counter_2_0_addressout),
        .clk(Net1),
        .reset(reset_1));
  program_memory program_memory_0
       (.PM_rd(MAR_0_new_feed),
        .PM_wr(PM_wr_1),
        .address(MAR_0_addout),
        .clk(Net1),
        .input_inst(PM_inst_inp_1),
        .inst(program_memory_0_inst));
endmodule
