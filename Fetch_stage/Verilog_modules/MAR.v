`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jagrut Jadhav
// Create Date: 06/30/2020 05:57:13 PM
// Module Name: Memory Address Register
// Project Name:Pipelined Processor 

//////////////////////////////////////////////////////////////////////////////////


module MAR( input MAR_rd,MAR_wr, // wr => write to MAR , rd => read from MAR
input [4:0] addin,
input clk,
output reg [4:0] addout
 );
 reg [4:0] address;
 
 always @ (posedge clk) begin
 if(MAR_rd)begin
    addout <= address;
 end
 else if(MAR_wr) begin
    address <= addin;
 end
 else begin
    address <= address;
 end
 end
endmodule
