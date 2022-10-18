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


module Instr_Data_Mem(
    input clk,reset,
    input [5:0] addr,addr_test,
    input [15:0] wd,
    input we,
    output [15:0] rd,rd_test
    );
    
   reg [15:0] IDMem [0:63];
   
   always @(posedge clk)
   begin
    if(reset)
        begin
            IDMem[6'd0] <= 16'b010_001_000_0000000;
            IDMem[6'd1] <= 16'b010_010_000_0000111;
            IDMem[6'd2] <= 16'b010_011_000_0010100;
            IDMem[6'd3] <= 16'b011_100_011_0000000;
            IDMem[6'd4] <= 16'b001_101_010_001_0001;
            IDMem[6'd5] <= 16'b011_110_011_0000001;
            IDMem[6'd6] <= 16'b101_000_100_110_0010;
            IDMem[6'd7] <= 16'b100_000_011_110_0000;
            IDMem[6'd8] <= 16'b100_000_011_100_0001;
            IDMem[6'd9] <= 16'b101_000_110_100_0001;
            IDMem[6'd10]<= 16'b010_100_110_0000000;
            IDMem[6'd11]<= 16'b010_011_011_0000001;
            IDMem[6'd12]<= 16'b010_101_101_1111111;
            IDMem[6'd13]<= 16'b101_111_000_101_0111;
            IDMem[6'd14]<= 16'b010_001_001_0000001;
            IDMem[6'd15]<= 16'b101_111_001_010_0010;
            IDMem[6'd16]<= 16'b110_0000000000000;
            IDMem[6'd17] <= 16'd0;
            IDMem[6'd18] <= 16'd0;
            IDMem[6'd19] <= 16'd0;
            IDMem[6'd20] <= 16'b0000000000001010;
            IDMem[6'd21] <= 16'b0000000000000100;
            IDMem[6'd22] <= 16'b1111110000000101;
            IDMem[6'd23] <= 16'b0000000000001111;
            IDMem[6'd24] <= 16'b0000000000010100;
            IDMem[6'd25] <= 16'b0000000000000110;
            IDMem[6'd26] <= 16'b1111111111111110;
            IDMem[6'd27] <= 16'b1111100000001001;
            IDMem[6'd28] <= 16'd0;
            IDMem[6'd29] <= 16'd0;
            IDMem[6'd30] <= 16'd0;
            IDMem[6'd31] <= 16'd0;
            IDMem[6'd32] <= 16'd0;
            IDMem[6'd33] <= 16'd0;
            IDMem[6'd34] <= 16'd0;
            IDMem[6'd35] <= 16'd0;
            IDMem[6'd36] <= 16'd0;
            IDMem[6'd37] <= 16'd0;
            IDMem[6'd38] <= 16'd0;
            IDMem[6'd39] <= 16'd0;
            IDMem[6'd40] <= 16'd0;
            IDMem[6'd41] <= 16'd0;
            IDMem[6'd42] <= 16'd0;
            IDMem[6'd43] <= 16'd0;
            IDMem[6'd44] <= 16'd0;
            IDMem[6'd45] <= 16'd0; 
            IDMem[6'd46] <= 16'd0;
            IDMem[6'd47] <= 16'd0;
            IDMem[6'd48] <= 16'd0;
            IDMem[6'd49] <= 16'd0;
            IDMem[6'd50] <= 16'd0;
            IDMem[6'd51] <= 16'd0;
            IDMem[6'd52] <= 16'd0;
            IDMem[6'd53] <= 16'd0;
            IDMem[6'd54] <= 16'd0;
            IDMem[6'd55] <= 16'd0;
            IDMem[6'd56] <= 16'd0;
            IDMem[6'd57] <= 16'd0;
            IDMem[6'd58] <= 16'd0;
            IDMem[6'd59] <= 16'd0;
            IDMem[6'd60] <= 16'd0;
            IDMem[6'd61] <= 16'd0;
            IDMem[6'd62] <= 16'd0;
            IDMem[6'd63] <= 16'd0;   
        end
   else if(we)
        IDMem[addr] <= wd;
   end
   assign rd = IDMem[addr];
   assign rd_test = IDMem[addr_test];
   
endmodule
