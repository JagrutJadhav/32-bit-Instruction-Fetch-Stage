`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jagrut Jadhav
// Create Date: 06/30/2020 05:57:13 PM
// Module Name: Memory data Register
// Project Name:Pipelined Processor 

//////////////////////////////////////////////////////////////////////////////////


module MDR_2(input MDR_rd,MDR_wr, // wr => write to MDR , rd => read from MDR
             input clk,
             input [31:0] instin,
             output reg [31:0] inst
 );


 reg [31:0] instram;
 reg [31:0]instout;

 always @ (posedge clk) begin
 if(MDR_wr)begin
    instram <= instin;
 end
 else if (MDR_rd )begin
    inst <= instram;
 end
 else begin
   instram <= instram;
 end
 
 end
endmodule
