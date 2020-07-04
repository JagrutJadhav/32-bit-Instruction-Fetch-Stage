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
input [35:0] input_inst,
inout [35:0] inst
 
);

reg [35:0] ram [31:0];
reg [35:0] outinst;
always @ (posedge clk) begin
if(!PM_wr && PM_rd)
outinst <= ram[address];
else if (PM_wr && !PM_rd)begin
    ram[address] <= input_inst;
    ram[address] <= inst;
end
else outinst<=outinst;
end
assign inst = (!PM_wr && PM_rd)? outinst:36'dz;
endmodule
