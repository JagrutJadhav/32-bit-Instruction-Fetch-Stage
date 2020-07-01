`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jagrut Jadhav
// Create Date: 06/30/2020 05:57:13 PM
// Module Name: Current Instruction Register
// Project Name:Pipelined Processor 

//////////////////////////////////////////////////////////////////////////////////


module IR( input IR_rd,IR_wr, // wr => write to IR , rd => read from IR
input clk,
inout [66:0] inst,
output [66:0] fetchout,
output PCenable
 );
 reg [66:0] preinst;
 wire [66:0] instload;
 reg [66 :0] instram;
 reg PCena = 1'b0;
 always @ (posedge clk) begin
  
    instram <= instload;
if (IR_wr)begin
   instram <= inst;
end
else begin
  instram <= instram;
end
 if (preinst != instram)begin
  PCena <= 1'b1;
  preinst <= instload;
 end
 else begin
  PCena <= 1'b0;
 end
 end
 assign fetchout = IR_rd? instram:67'dz;
 assign inst = IR_rd? instram:67'dz;
endmodule
