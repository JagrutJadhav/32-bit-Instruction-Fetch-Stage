`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jagrut Jadhav
// Create Date: 06/30/2020 05:57:13 PM
// Module Name: Memory data Register
// Project Name:Pipelined Processor 

//////////////////////////////////////////////////////////////////////////////////


module MDR( input MDR_rd,MDR_wr, // wr => write to MDR , rd => read from MDR
input clk,
inout [35:0] inst
 );

 wire [35:0] instload;
 reg [35 :0] instram,instout;
 
 always @ (posedge clk) begin
 if(MDR_wr)begin
    instram <= inst;
 end
 else begin
    instram <= instram;
 end
 
 end
 assign inst = MDR_rd? instout:36'dz;
endmodule
