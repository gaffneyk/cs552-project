/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   
   /* your code here */

register PC (.readData(PCAddr), .err(PCErr), .clk(clk), .rst(rst), .writeData(PCUpdate), .writeEn(Halt_n));

rca_16b PCrca2 (.A(PCAddr), .B(2'b10), .C_in(1'b0), .S(PCAdd2), .C_out(PCrca2Err));

memory2c InstMem (.data_out(Inst), .data_in(16'b0), .addr(PCAddr), .enable(Halt_n), .wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst));

control Ctrl(// Outputs
                .err(CtrlErr), .RegDst(RegDst), .SESel(SESel), .RegWrite(RegWrite), .DMemWrite(DMemWrite), .DMemEn(DMemEn), .ALUSrc2(ALUSrc2), .PCSrc(PCSrc), .PCImm(PCImm), 
		.MemToReg(MemToReg), .DMemDump(DMemDump), .Jump(Jump), .OpCode1_0(OpCode1_0), .WriteDataSel(WriteDataSel), .Halt_n(Halt_n), .ALUCtrl(ALUCtrl),
             // Inputs
                .OpCode(Inst[15:11]), .Funct(Inst[1:0]));

rf RegisterFiles (// Outputs
           	     .readData1(readData1), .readData2(readData2), .err(RFErr),
           	  // Inputs
           	     .clk(clk), .rst(rst), .readReg1Sel(Inst[10:8]), .readReg2Sel(Inst[7:5]), .writeRegSel(writeRegSel), .writeData(writeData), .writeEn());

memory2c DataMem (.data_out(DMemData), .data_in(readData2), .addr(), .enable(DMemEn), .wr(DMemWrite), .createdump(DMemDump), .clk(clk), .rst(rst));

mux4_1_3b MuxWriteReg (.InA(Inst[4:2]), .InB(Inst[7:5]), .InC(Inst[10:8]), .InD(3'b111), .S(RegDst), .Out(writeRegSel));
mux2_1_16b MuxWriteData (.InA(PCAdd2), .InB(), .S(WriteDataSel), .Out(writeData));



assign err = 0;
   
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
