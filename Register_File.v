`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.09.2022 11:41:58
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Register_File(
    input clk,
    input [2:0] addr1,addr2,addw,
    input [15:0] wd,
    input we,
    output [15:0] rd1,rd2
    );
    
   reg [15:0] mem [0:7];
   
   always @(posedge clk)
   begin
        mem[0] <= 16'd0;
    if(we)
        mem[addw] <= addw?wd:16'd0;
  
   end
   
   assign rd1 = mem[addr1];
   assign rd2 = mem[addr2];
   
endmodule
