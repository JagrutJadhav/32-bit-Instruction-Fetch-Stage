`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jagrut Jadhav
// Create Date: 06/30/2020 05:57:13 PM
// Module Name: program_memory
// Project Name:Pipelined Processor 
/*
Simple Instructions 

000 => Add
001 => Substract
010 => Multiply
011 => Divide

*/
//////////////////////////////////////////////////////////////////////////////////


module program_memory(input [4:0] address,
input PM_rd,PM_wr,// low signal => write into program memory , High => read from program memory
input clk, 
input [67:0] input_inst,
output reg [67:0] inst
 
);

reg [67:0] ram [31:0];
reg [67:0] outinst;
always @ (posedge clk) begin
if(!PM_wr && PM_rd)
inst <= ram[address];
else if (PM_wr && !PM_rd)begin
    ram[address] <= input_inst;
    //ram[address] <= inst;
end
else inst <= 68'dz;
end
endmodule
