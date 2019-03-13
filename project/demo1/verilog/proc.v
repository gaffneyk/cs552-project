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
wire [15:0] ImmExtSL;

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
           	     .clk(clk), .rst(rst), .readReg1Sel(Inst[10:8]), .readReg2Sel(Inst[7:5]), .writeRegSel(writeRegSel), .writeData(writeData), .writeEn(RegWrite));

alu ALU1 (.InA(readData1), .InB(ALUSrc2Data), .Op(ALUCtrl), .Out(ALU_Out), .MSB(MSB), .Zero(Zero));

memory2c DataMem (.data_out(DMemData), .data_in(readData2), .addr(ALU_Out), .enable(DMemEn), .wr(DMemWrite), .createdump(DMemDump), .clk(clk), .rst(rst));

mux4_1_3b MuxWriteReg (.InA(Inst[4:2]), .InB(Inst[7:5]), .InC(Inst[10:8]), .InD(3'b111), .S(RegDst), .Out(writeRegSel));
mux2_1_16b MuxWriteData (.InA(MemToRegOut), .InB(PCAdd2), .S(WriteDataSel), .Out(writeData));
mux2_1_16b MuxALUSrc2 (.InA(ImmExt), .InB(readData2), .S(ALUSrc2), .Out(ALUSrc2Data));


zero_extend_5b ZEx5b (.in(Inst[4:0]), .out(ZEx5bOut));
zero_extend_8b ZEx8b (.in(Inst[7:0]), .out(ZEx8bOut));
sign_extend_5b SEx5b (.in(Inst[4:0]), out(SEx5bOut));
sign_extend_8b SEx8b (.in(Inst[7:0]), out(SEx8bOut));
sign_extend_11b SEx11b (.in(Inst[10:0]), .out(SEx11bOut));

mux8_1_16b MuxExtend (.In0(ZEx5bOut), .In1(ZEx8bOut), .In2(SEx5bOut), .In3(SEx5bOut), .In4(SEx8bOut), .In5(SEx8bOut), .In6(SEx11bOut), .In7(SEx11bOut), .S(SESel), .Out(ImmExt));
mux2_1_16b MuxMemtoReg (.InA(ALU_Out), .InB(DMemData), .S(MemToReg), .Out(MemToRegOut));

assign ImmExtSL = {ImmExt[14:0],1'b0};
rca_16b PCrcaImm(.A(PCAdd2), .B(ImmExtSL), .C_in(1'b0), .S(PCImmAdd), .C_out(PCrcaImmC_out));

assign err = 0;
   
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
