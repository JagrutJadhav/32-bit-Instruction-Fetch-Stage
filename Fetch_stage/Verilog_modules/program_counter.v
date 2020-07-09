
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jagrut Jadhav
// Create Date: 06/30/2020 05:57:13 PM
// Module Name: program_counter
// Project Name:Pipelined Processor 

//////////////////////////////////////////////////////////////////////////////////


module Program_counter_2( input clk,
input CE,
input PC_rd,PC_wr,//// low signal => write counter address to counter , High => read counter address
input [4:0] addressin,
input reset,
output [4:0] addressout
 );
 reg [4:0] i= 5'b00000;   
 
 always @ (posedge clk) begin
    if (CE)begin
        if (PC_wr) begin // if high
            i <= addressin;
        end
        else begin
            i <= i+1;
        end
    end
    
    else if (reset) i <= 5'b00000;
    else i<= i;
     
 end  
 assign addressout = (PC_rd)?i:5'dz;
endmodule
