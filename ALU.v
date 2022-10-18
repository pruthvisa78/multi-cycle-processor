`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.09.2022 11:22:41
// Design Name: 
// Module Name: ALU
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


module ALU(
    input  [15:0] A,B,
    input  [9:0] Imm,
    input immsel,
    input [15:0] PC,
    input ALUCtrl,ALUSrcA,
    input [1:0] ALUSrcB,
    output [15:0] ALUResult,
    output Flag
    );
    wire  [15:0] SrcA;
    reg   [15:0]  SrcB;
    wire  [15:0] SignExt;
    reg   [15:0] ALUResult_temp;
    wire [6:0] Immediate;
    assign SrcA = ALUSrcA ? A:PC;
    
    always @(*)
    begin
        case(ALUSrcB)
            2'b00: SrcB = B;
            2'b01: SrcB = 16'd1;
            2'b10: SrcB = SignExt;
            default: SrcB = 16'd0;
        endcase          
    end
    
    always @(*)
    begin
        if(ALUCtrl)
            ALUResult_temp = SrcA + SrcB;
        else
            ALUResult_temp = SrcA - SrcB;
    end
   
    assign ALUResult = ALUResult_temp;
    assign Flag = ALUResult_temp[15];
    
    assign Immediate = immsel?{Imm[9:7],Imm[3:0]}:Imm[6:0];
    assign SignExt = Immediate[6]?{{9{1'b1}},Immediate}:{{9{1'b0}},Immediate};
endmodule
