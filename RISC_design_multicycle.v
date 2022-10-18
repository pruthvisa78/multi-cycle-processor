`timescale 1ns / 1ps
module RISC_design_multicycle(
    input clkin,reset,
    input [5:0] addr_test,
    output [15:0] rd_test
    );
    
    wire immsel,ALUCtrl,ALUSrcA,Flag,IorD,MemWrite,IRWrite,MemtoReg,RegWrite,PCsrc,Branch,PCWrite;
    wire [1:0]ALUSrcB;
    wire [15:0]wdata_mem, wdata_rfile,rd1,rd2,A,B,PC,ALUResult;
    wire [2:0]addr1,addr2,addw,opcode;
    wire [9:0]Imm;
    wire [3:0]func;
    reg [15:0]PC_reg,IR_reg,Data_reg,Areg,Breg,ALUout_reg;
    wire [5:0] addr;
    wire [15:0] data_out;
    clk_wiz_0 inst
  (
  // Clock out ports  
  .clk_out1(clk),
 // Clock in ports
  .clk_in1(clkin)
  );
    
 Instr_Data_Mem M1 (.clk(clk),.reset(reset),.addr(addr),.rd(data_out), .we(MemWrite),.wd(wdata_mem),.rd_test(rd_test),.addr_test(addr_test));
 Register_File M2 (.clk(clk),.addr1(addr1), .addr2(addr2),.addw(addw),.wd(wdata_rfile),.we(RegWrite),.rd1(rd1),.rd2(rd2));
 ALU M3(.A(A),.B(B),.Imm(Imm),.immsel(immsel),.PC(PC),.ALUCtrl(ALUCtrl),.ALUSrcA(ALUSrcA),.ALUSrcB(ALUSrcB),.ALUResult(ALUResult),.Flag(Flag));
 Control_Path M4 (.clk(clk),.reset(reset),.opcode(opcode),.func(func),.IorD(IorD),.MemWrite(MemWrite),.IRWrite(IRWrite),.MemtoReg(MemtoReg),.Immsel(immsel),.RegWrite(RegWrite),.ALUSrcA(ALUSrcA),.ALUsrcB(ALUSrcB),.PCsrc(PCsrc),.Branch(Branch),.PCWrite(PCWrite),.ALUctrl(ALUCtrl));
 
 always@(posedge clk)
 begin
   if (reset) begin
    PC_reg<=16'd0;
    IR_reg <= 16'd0;
    Data_reg<= 16'd0;
    Areg<=16'd0;
    Breg<=16'd0;
    ALUout_reg<=16'd0; 
   end
   else
   begin
    PC_reg<=PC_en?(PCsrc?ALUout_reg:ALUResult):PC_reg;
    IR_reg <= IRWrite? data_out: IR_reg;
    Data_reg<= data_out;
    Areg<=rd1;
    Breg<=rd2;
    ALUout_reg<=ALUResult; 
   end
 end
 assign addr1 = IR_reg[9:7];
 assign addr2 = IR_reg[6:4];
 assign addw = IR_reg[12:10];
 assign opcode = IR_reg[15:13];
 assign func = IR_reg[3:0];
 assign Imm = {IR_reg[12:10],IR_reg[6:0]};
 assign PC = PC_reg;
 assign PC_en= PCWrite | (Branch & Flag);  
 assign addr = IorD?ALUout_reg[5:0]: PC[5:0];
 assign wdata_rfile = MemtoReg? Data_reg:ALUout_reg;
 assign wdata_mem = Breg;
 assign A = Areg;
 assign B = Breg;
endmodule
