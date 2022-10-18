`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.09.2022 11:56:25
// Design Name: 
// Module Name: Control_Path
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


module Control_Path(
    input clk,reset,
    input [2:0] opcode,
    input [3:0] func,
    output reg IorD,MemWrite,IRWrite,
    output reg MemtoReg,Immsel,RegWrite,ALUSrcA,
    output reg [1:0] ALUsrcB,
    output reg PCsrc,Branch,PCWrite,ALUctrl
    );
    
    
  parameter FETCH = 4'd0, DECODE = 4'd1, MemAddr = 4'd2, MemRead = 4'd3, MemWriteBack = 4'd4, MemWriteState = 4'd5, Execute = 4'd6, ALUWriteBack = 4'd7, BranchState = 4'd8, ADDIExe = 4'd9, ADDIWriteBack = 4'd10, NOP = 4'd11; 
    
    reg [3:0] ps,ns;
    
    always @(posedge clk)
        begin
            if(reset)
                ps <= FETCH;
            else
                ps <= ns;
        end
   always @(*)
    begin
        case(ps)
            FETCH: ns = DECODE;
            DECODE: begin
                case(opcode)
                    3'b001: ns = Execute;
                    3'b010: ns = ADDIExe;
                    3'b011,3'b100: ns = MemAddr;
                    3'b101: ns = BranchState;
                    3'b110: ns = NOP;
                    default ns = DECODE;
                endcase
                end
            MemAddr: begin
                case(opcode)
                    3'b011: ns = MemRead;
                    3'b100: ns = MemWriteState;
                    default: ns = MemAddr;
                endcase
                end
           MemRead: ns = MemWriteBack;
           MemWriteBack: ns = FETCH;
           MemWriteState: ns = FETCH;
           Execute: ns = ALUWriteBack;
           ALUWriteBack: ns = FETCH;
           BranchState: ns = FETCH;
           ADDIExe: ns = ADDIWriteBack;
           ADDIWriteBack: ns = FETCH;
           NOP: ns = NOP;
           default: ns = FETCH;        
      endcase
    end 
    
    always @(*)
    begin
        case(ps)
            FETCH: begin
                IorD = 1'b0;
                MemWrite = 1'b0;
                IRWrite = 1'b1;
                MemtoReg= 1'b0;
                Immsel = 1'b0;
                RegWrite= 1'b0;
                ALUSrcA = 1'b0;
                ALUsrcB = 2'b01;
                PCsrc= 1'b0;
                Branch= 1'b0;
                PCWrite= 1'b1;
                ALUctrl= 1'b1;               
            end
            DECODE: begin
                IorD = 1'b0;
                MemWrite = 1'b0;
                IRWrite = 1'b0;
                MemtoReg= 1'b0;
                Immsel = 1'b1;
                RegWrite= 1'b0;
                ALUSrcA = 1'b0;
                ALUsrcB = 2'b10;
                PCsrc= 1'b0;
                Branch= 1'b0;
                PCWrite= 1'b0;
                ALUctrl= 1'b1;                
            end
            MemAddr: begin
                IorD = 1'b0;
                MemWrite = 1'b0;
                IRWrite = 1'b0;
                MemtoReg= 1'b0;
                Immsel = (opcode == 3'b100)?1'b1:1'b0;
                RegWrite= 1'b0;
                ALUSrcA = 1'b1;
                ALUsrcB = 2'b10;
                PCsrc= 1'b0;
                Branch= 1'b0;
                PCWrite= 1'b0;
                ALUctrl= 1'b1;               
            end
            MemRead: begin
                IorD = 1'b1;
                MemWrite = 1'b0;
                IRWrite = 1'b0;
                MemtoReg= 1'b0;
                Immsel = 1'b0;
                RegWrite= 1'b0;
                ALUSrcA = 1'b1;
                ALUsrcB = 2'b10;
                PCsrc= 1'b0;
                Branch= 1'b0;
                PCWrite= 1'b0;
                ALUctrl= 1'b1;               
            end
            MemWriteBack: begin
                IorD = 1'b0;
                MemWrite = 1'b0;
                IRWrite = 1'b0;
                MemtoReg= 1'b1;
                Immsel = 1'b0;
                RegWrite= 1'b1;
                ALUSrcA = 1'b1;
                ALUsrcB = 2'b10;
                PCsrc= 1'b0;
                Branch= 1'b0;
                PCWrite= 1'b0;
                ALUctrl= 1'b1;                
            end
            MemWriteState: begin
                IorD = 1'b1;
                MemWrite = 1'b1;
                IRWrite = 1'b0;
                MemtoReg= 1'b0;
                Immsel = 1'b1;
                RegWrite= 1'b0;
                ALUSrcA = 1'b1;
                ALUsrcB = 2'b10;
                PCsrc= 1'b0;
                Branch= 1'b0;
                PCWrite= 1'b0;
                ALUctrl= 1'b1;               
            end
            Execute: begin
                IorD = 1'b0;
                MemWrite = 1'b0;
                IRWrite = 1'b0;
                MemtoReg= 1'b0;
                Immsel = 1'b0;
                RegWrite= 1'b0;
                ALUSrcA = 1'b1;
                ALUsrcB = 2'b00;
                PCsrc= 1'b0;
                Branch= 1'b0;
                PCWrite= 1'b0;
                ALUctrl= 1'b0;               
            end
            ALUWriteBack: begin
                IorD = 1'b0;
                MemWrite = 1'b0;
                IRWrite = 1'b0;
                MemtoReg= 1'b0;
                Immsel = 1'b0;
                RegWrite= 1'b1;
                ALUSrcA = 1'b0;
                ALUsrcB = 2'b00;
                PCsrc= 1'b0;
                Branch= 1'b0;
                PCWrite= 1'b0;
                ALUctrl= 1'b0;             
            end
            BranchState: begin
                IorD = 1'b0;
                MemWrite = 1'b0;
                IRWrite = 1'b0;
                MemtoReg= 1'b0;
                Immsel = 1'b1;
                RegWrite= 1'b0;
                ALUSrcA = 1'b1;
                ALUsrcB = 2'b00;
                PCsrc= 1'b1;
                Branch= 1'b1;
                PCWrite= 1'b0;
                ALUctrl= 1'b0;               
            end
            ADDIExe: begin
                IorD = 1'b0;
                MemWrite = 1'b0;
                IRWrite = 1'b0;
                MemtoReg= 1'b0;
                Immsel = 1'b0;
                RegWrite= 1'b0;
                ALUSrcA = 1'b1;
                ALUsrcB = 2'b10;
                PCsrc= 1'b0;
                Branch= 1'b0;
                PCWrite= 1'b0;
                ALUctrl= 1'b1;                
            end
            ADDIWriteBack: begin
                IorD = 1'b0;
                MemWrite = 1'b0;
                IRWrite = 1'b0;
                MemtoReg= 1'b0;
                Immsel = 1'b0;
                RegWrite= 1'b1;
                ALUSrcA = 1'b0;
                ALUsrcB = 2'b00;
                PCsrc= 1'b0;
                Branch= 1'b0;
                PCWrite= 1'b0;
                ALUctrl= 1'b0;               
            end
            default: begin
                IorD = 1'b0;
                MemWrite = 1'b0;
                IRWrite = 1'b0;
                MemtoReg= 1'b0;
                Immsel = 1'b0;
                RegWrite= 1'b0;
                ALUSrcA = 1'b0;
                ALUsrcB = 2'b00;
                PCsrc= 1'b0;
                Branch= 1'b0;
                PCWrite= 1'b0;
                ALUctrl= 1'b0;               
            end
    endcase
    end
    endmodule
