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



wire [15:0]	CtrlOut_ID_EX, CtrlOut_EX_MEM, CtrlOut_MEM_WB, PCAdd2Out_IF, PCAdd2Out_IF_ID, PCAdd2Out_ID_EX, PCAdd2Out_EX_MEM, PCAdd2Out_MEM_WB, PCUpdateMEM, Inst_IF, Inst_IF_ID, 
		writeData_WB,readData1_ID, ReadData1Out_ID_EX, readData2_ID, ReadData2Out_ID_EX, ReadData2Out_EX_MEM, ImmExt_ID, ImmExtOut_ID_EX, ALU_Out_EX, ALUOutOut_EX_MEM, 
		ALUOutOut_MEM_WB, PCImmAdd_EX, PCImmAddOut_EX_MEM, DMemData_MEM, DMemDataOut_MEM_WB;
wire [3:0]	ALUCtrl_ID;
wire [2:0]	writeRegSelOut_ID, writeRegSelOut_ID_EX, writeRegSelOut_EX_MEM, writeRegSelOut_MEM_WB;
wire [1:0]	OpCode1_0_ID;

wire [2:0] id_rs, id_rt, id_ex_rs, id_ex_rt;
wire [1:0] forward_a, forward_b;

wire PCSrc_ID, hazard_f, PCImm_ID, Jump_ID, DMemEn_ID, DMemWrite_ID,
	DMemDump_ID, MemToReg_ID, WriteDataSel_ID, RegWriteOut_ID, 
	ALUSrc2_ID, MSB_EX, MSBOut_EX_MEM, Zero_EX, ZeroOut_EX_MEM, Halt_n, 
	rst_IF_ID, rst_ID_EX, rst_EX_MEM, rst_MEM_WB, Halt_n_ID, Halt_n_ID_EX,
	dmem_stall, dmem_done;


	IF_stage IF (//outputs
		.PCAdd2(PCAdd2Out_IF), .Inst(Inst_IF),
		//inputs
		.hazard_f(hazard_f), .branch_MEM(CtrlOut_EX_MEM[9]), 
		.branch_EX(CtrlOut_ID_EX[9]), .branch_ID(PCSrc_ID), 
		.clk(clk), .rst(rst), .PCUpdateH(PCUpdateMEM), .Halt_n(1'b1),
		.dmem_stall(dmem_stall));



	IF_ID_reg IF_ID (//outputs
		.PCAdd2Out(PCAdd2Out_IF_ID), .InstOut(Inst_IF_ID), .rstOut(rst_IF_ID), .errOut(),
		//inputs
		.clk(clk), .hazard_f(hazard_f), .PCAdd2In(PCAdd2Out_IF), .InstIn(Inst_IF), .rstIn(rst), .errIn(),
		.dmem_stall(dmem_stall));



	ID_stage ID (//outputs
		.writeRegSelOut(writeRegSelOut_ID), .readData1(readData1_ID), .readData2(readData2_ID), .ImmExt(ImmExt_ID), .hazard_f(hazard_f), .ALUCtrl(ALUCtrl_ID), .PCImm(PCImm_ID), 
		.PCSrc(PCSrc_ID), .Jump(Jump_ID), .OpCode1_0(OpCode1_0_ID),.DMemEn(DMemEn_ID), .DMemWrite(DMemWrite_ID), .DMemDump(DMemDump_ID), .MemToReg(MemToReg_ID), .WriteDataSel(WriteDataSel_ID), 
		.RegWriteOut(RegWriteOut_ID), .ALUSrc2(ALUSrc2_ID), .Halt_n(Halt_n_ID), .rs(id_rs), .rt(id_rt),
		//inputs
		.Inst(Inst_IF_ID), .clk(clk), .rst(rst_IF_ID), .writeRegSelIn(writeRegSelOut_MEM_WB), .writeData(writeData_WB), .RegWriteIn(CtrlOut_MEM_WB[0]), .writeRegSel_ID_EX(writeRegSelOut_ID_EX),
		.writeRegSel_EX_MEM(writeRegSelOut_EX_MEM), .writeRegSel_MEM_WB(writeRegSelOut_MEM_WB), .RegWrite_ID_EX(CtrlOut_ID_EX[0]), .RegWrite_EX_MEM(CtrlOut_EX_MEM[0]), .RegWrite_MEM_WB(CtrlOut_MEM_WB[0]));



	ID_EX_reg ID_EX (//outputs
		.CtrlOut(CtrlOut_ID_EX), .PCAdd2Out(PCAdd2Out_ID_EX), 
		.WriteRegSelOut(writeRegSelOut_ID_EX), 
		.ReadData1Out(ReadData1Out_ID_EX), .ReadData2Out(ReadData2Out_ID_EX), 
		.ImmExtOut(ImmExtOut_ID_EX), .Halt_nOut(Halt_n_ID_EX), 
		.id_ex_rs(id_ex_rs), .id_ex_rt(id_ex_rt), .rstOut(rst_ID_EX), 
		.errOut(),
		//inputs
		.clk(clk), .ALUSrc2(ALUSrc2_ID), .ALUCtrl(ALUCtrl_ID), .PCImm(PCImm_ID), .PCSrc(PCSrc_ID), .Jump(Jump_ID), .Opcode1_0(OpCode1_0_ID), .DMemEn(DMemEn_ID), 
		.DMemWrite(DMemWrite_ID), .DMemDump(DMemDump_ID), .MemToReg(MemToReg_ID), .WriteDataSel(WriteDataSel_ID), .RegWrite(RegWriteOut_ID), .PCAdd2In(PCAdd2Out_IF_ID), 
		.WriteRegSelIn(writeRegSelOut_ID), .ReadData1In(readData1_ID), .ReadData2In(readData2_ID), .ImmExtIn(ImmExt_ID), .Halt_nIn(Halt_n_ID), .rstIn(rst_IF_ID), .errIn(),
		.dmem_stall(dmem_stall), .id_rs(id_rs), .id_rt(id_rt));



	EX_stage EX (//outputs
		.ALU_Out(ALU_Out_EX), .MSB(MSB_EX), .Zero(Zero_EX), .PCImmAdd(PCImmAdd_EX),
		//inputs
		.ImmExt(ImmExtOut_ID_EX), .readData1(ReadData1Out_ID_EX), .readData2(ReadData2Out_ID_EX), .ALUSrc2(CtrlOut_ID_EX[15]), .ALUCtrl(CtrlOut_ID_EX[14:11]), .PCAdd2(PCAdd2Out_ID_EX));



	EX_MEM_reg EX_MEM (//outputs
		.CtrlOut(CtrlOut_EX_MEM), .PCAdd2Out(PCAdd2Out_EX_MEM), .WriteRegSelOut(writeRegSelOut_EX_MEM), .ReadData2Out(ReadData2Out_EX_MEM), .ALUOutOut(ALUOutOut_EX_MEM), 
		.MSBOut(MSBOut_EX_MEM), .ZeroOut(ZeroOut_EX_MEM), .PCImmAddOut(PCImmAddOut_EX_MEM), .Halt_nOut(Halt_n_EX_MEM), .rstOut(rst_EX_MEM), .errOut(),
		//inputs
		.clk(clk), .CtrlIn(CtrlOut_ID_EX), .PCAdd2In(PCAdd2Out_ID_EX), .WriteRegSelIn(writeRegSelOut_ID_EX), .ReadData2In(ReadData2Out_ID_EX), .ALUOutIn(ALU_Out_EX), 
		.MSBIn(MSB_EX), .ZeroIn(Zero_EX), .PCImmAddIn(PCImmAdd_EX), .Halt_nIn(Halt_n_ID_EX), .rstIn(rst_ID_EX), .errIn(),
		.dmem_stall(dmem_stall));



	MEM_stage MEM (//outputs
		.DMemData(DMemData_MEM), .PCUpdate(PCUpdateMEM), .dmem_stall(dmem_stall),
		.dmem_done(dmem_done),
		//inputs
		.clk(clk), .rst(rst_EX_MEM), .MSB(MSBOut_EX_MEM), .Zero(ZeroOut_EX_MEM), .readData2(ReadData2Out_EX_MEM), .ALU_Out(ALUOutOut_EX_MEM), .DMemEn(CtrlOut_EX_MEM[5]), 
		.DMemWrite(CtrlOut_EX_MEM[4]), .DMemDump(CtrlOut_EX_MEM[3]), .PCAdd2(PCAdd2Out_EX_MEM), .PCImmAdd(PCImmAddOut_EX_MEM), .PCImm(CtrlOut_EX_MEM[10]), .PCSrc(CtrlOut_EX_MEM[9]), 
		.Jump(CtrlOut_EX_MEM[8]), .OpCode1_0(CtrlOut_EX_MEM[7:6]));



	MEM_WB_reg MEM_WB (//outputs
		.CtrlOut(CtrlOut_MEM_WB), .PCAdd2Out(PCAdd2Out_MEM_WB), .WriteRegSelOut(writeRegSelOut_MEM_WB), .ALUOutOut(ALUOutOut_MEM_WB), .DMemDataOut(DMemDataOut_MEM_WB), 
		.rstOut(rst_MEM_WB), .errOut(), .Halt_nOut(Halt_n),
		//inputs
		.clk(clk), .CtrlIn(CtrlOut_EX_MEM), .PCAdd2In(PCAdd2Out_EX_MEM), .WriteRegSelIn(writeRegSelOut_EX_MEM), .ALUOutIn(ALUOutOut_EX_MEM), .DMemDataIn(DMemData_MEM), 
		.rstIn(rst_EX_MEM), .errIn(), .dmem_stall(dmem_stall), .Halt_nIn(Halt_n_EX_MEM));



	WB_stage WB (//outputs
		.writeData(writeData_WB),
		//inputs
		.PCAdd2(PCAdd2Out_MEM_WB), .WriteDataSel(CtrlOut_MEM_WB[1]), .ALU_Out(ALUOutOut_MEM_WB), .DMemData(DMemDataOut_MEM_WB), .MemToReg(CtrlOut_MEM_WB[2]));

	forwarding_unit forwarding(
		.id_ex_rs(id_ex_rs), 
		.id_ex_rt(id_ex_rt), 
		.ex_mem_rd(writeRegSelOut_EX_MEM), 
		.ex_mem_reg_write(CtrlOut_EX_MEM[0]),
		.mem_wb_rd(writeRegSelOut_MEM_WB), 
		.mem_wb_reg_write(CtrlOut_MEM_WB[0]), 
		.forward_a(forward_a), 
		.forward_b(forward_b));


//assign err = (PCErr | PCrca2Err | CtrlErr | RFErr) & ~rst;

endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
