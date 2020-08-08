`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jagrut Jadhav
// Create Date: 06/30/2020 05:57:13 PM
// Module Name: Current Instruction Register
// Project Name:Pipelined Processor 

//////////////////////////////////////////////////////////////////////////////////


module IR(input IR_rd,IR_wr, // wr => write to IR , rd => read from IR
          input clk,
          input [31:0] inst,
          output reg [31:0] fetchout
 );
 
 reg [31 :0] instram;

 always @ (posedge clk) begin
  
if (IR_wr && !IR_rd)begin
   instram <= inst;
end
else if (!IR_wr && IR_rd)begin
   fetchout <= instram;
end
else begin
  fetchout <= 32'dz;
end
 
 end
endmodule
