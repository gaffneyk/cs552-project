/*
   CS/ECE 552, Spring '19
   Homework #6, Problem #1
  
   This module determines all of the control logic for the processor.
*/
module control (/*AUTOARG*/
                // Outputs
                err, 
                RegDst,
                SESel,
                RegWrite,
                DMemWrite,
                DMemEn,
                ALUSrc2,
                PCSrc,
                PCImm,
                MemToReg,
                DMemDump,
                Jump,
		OpCode1_0,
		WriteDataSel,
		Halt_n,
		ALUCtrl,
                // Inputs
                OpCode,
                Funct,
                rst
                );

   // inputs
   input [4:0]  OpCode;
   input [1:0]  Funct;
   input rst;
   
   // outputs
   output       err;
   output       RegWrite, DMemWrite, DMemEn, ALUSrc2, PCSrc, 
                PCImm, MemToReg, DMemDump, Jump, WriteDataSel, Halt_n;
   output [1:0] RegDst, OpCode1_0;
   output [2:0] SESel;
   output [3:0] ALUCtrl;

   /* YOUR CODE HERE */

errMod errMod1 (.OpCode(OpCode), .Funct(Funct), .rst(rst), .err(err));

RegDstMod RegDstMod1 (.OpCode(OpCode), .RegDst(RegDst));
SESelMod SESelMod1 (.OpCode(OpCode), .SESel(SESel));
RegWriteMod RegWriteMod1 (.OpCode(OpCode), .RegWrite(RegWrite));
DMemWriteMod DMemWriteMod1 (.OpCode(OpCode), .DMemWrite(DMemWrite));
DMemEnMod DMemEnMod1 (.OpCode(OpCode), .DMemEn(DMemEn));
ALUSrc2Mod ALUSrc2Mod1 (.OpCode(OpCode), .ALUSrc2(ALUSrc2));
PCSrcMod PCSrcMod1 (.OpCode(OpCode), .PCSrc(PCSrc));
PCImmMod PCImmMod1 (.OpCode(OpCode), .PCImm(PCImm));
MemToRegMod MemToRegMod1 (.OpCode(OpCode), .MemToReg(MemToReg));
DMemDumpMod DMemDumpMod1 (.OpCode(OpCode), .DMemDump(DMemDump));
JumpMod JumpMod1 (.OpCode(OpCode), .Jump(Jump));
assign OpCode1_0 = OpCode[1:0];
WriteDataSelMod WriteDataSelMod1 (.OpCode(OpCode),.WriteDataSel(WriteDataSel));
assign Halt_n = (^OpCode === 1'bx) | (OpCode != 5'b00000) ? 1'b0 : 1'b1;
ALU_Ctrl ALU_Ctrl1 (.OpCode(OpCode), .Funct(Funct), .ALU_Ctrl(ALUCtrl));

endmodule
