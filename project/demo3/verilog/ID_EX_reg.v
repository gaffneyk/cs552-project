module ID_EX_reg(clk, ALUSrc2, ALUCtrl, PCImm, PCSrc, Jump, Opcode1_0, DMemEn,
	DMemWrite, DMemDump, MemToReg, WriteDataSel, RegWrite, PCAdd2In, 
	WriteRegSelIn, ReadData1In, ReadData2In, ImmExtIn, Halt_nIn, 
	id_rs, id_rt, rstIn, errIn, dmem_stall, flush,
	CtrlOut, PCAdd2Out, WriteRegSelOut, id_ex_rs, id_ex_rt, ReadData1Out, 
	ReadData2Out, ImmExtOut, Halt_nOut, rstOut, errOut);

	input clk;

	input ALUSrc2;			// 15
	input [3:0] ALUCtrl;	// 14:11
	input PCImm;			// 10
	input PCSrc;			// 9
	input Jump;				// 8
	input [1:0] Opcode1_0;	// 7:6
	input DMemEn;			// 5
	input DMemWrite;		// 4
	input DMemDump;			// 3
	input MemToReg;			// 2
	input WriteDataSel;		// 1
	input RegWrite;			// 0

	input [15:0] PCAdd2In;
	input [2:0] WriteRegSelIn, id_rs, id_rt;
	input [15:0] ReadData1In;
	input [15:0] ReadData2In;
	input [15:0] ImmExtIn;
	input Halt_nIn;
	input rstIn;
	input errIn;
	input dmem_stall;
	input flush;

	output [15:0] CtrlOut;
	output [15:0] PCAdd2Out;
	output [2:0] WriteRegSelOut, id_ex_rs, id_ex_rt;
	output [15:0] ReadData1Out;
	output [15:0] ReadData2Out;
	output [15:0] ImmExtOut;
	output Halt_nOut;
	output rstOut;
	output errOut;

	wire Ctrl_err, PCAdd2_err, ReadData1_err, ReadData2_err, ImmExt_err, aux_err;
	wire [15:0] aux_reg_out;
	wire [15:0] rst_reg_out;
	wire [15:0] Ctrl_reg_out;

	mux2_1_16b FlushMux(
		.InA(Ctrl_reg_out), 
		.InB({Ctrl_reg_out[15:11], 
			  3'b000, 
			  Ctrl_reg_out[7:6], 
			  3'b000, 
			  Ctrl_reg_out[2:1],
			  1'b0 & ~rstIn}),
		.S(flush), 
		.Out(CtrlOut));

	register Ctrl_reg(
		.clk(clk),
		.rst(rstIn),
		.err(Ctrl_err),
		.writeData({ALUSrc2, ALUCtrl, PCImm, PCSrc, Jump, Opcode1_0, DMemEn, DMemWrite, DMemDump, MemToReg, WriteDataSel, RegWrite & ~rstIn}),
		.readData(Ctrl_reg_out),
		.writeEn(~dmem_stall));

	register PCAdd2_reg(
		.clk(clk),
		.rst(rstIn),
		.err(PCAdd2_err),
		.writeData(PCAdd2In),
		.readData(PCAdd2Out),
		.writeEn(~dmem_stall));

	register ReadData1_reg(
		.clk(clk),
		.rst(rstIn),
		.err(ReadData1_err),
		.writeData(ReadData1In),
		.readData(ReadData1Out),
		.writeEn(~dmem_stall));

	register ReadData2_reg(
		.clk(clk),
		.rst(rstIn),
		.err(ReadData2_err),
		.writeData(ReadData2In),
		.readData(ReadData2Out),
		.writeEn(~dmem_stall));

	register ImmExt_reg(
		.clk(clk),
		.rst(rstIn),
		.err(ImmExt_err),
		.writeData(ImmExtIn),
		.readData(ImmExtOut),
		.writeEn(~dmem_stall));

	register aux_reg(
		.clk(clk),
		.rst(rstIn),
		.err(aux_err),
		.writeData({5'b0, Halt_nIn, id_rs, id_rt, WriteRegSelIn, errIn}),
		.readData(aux_reg_out),
		.writeEn(~dmem_stall));

	register rst_reg(
		.clk(clk),
		.rst(1'b0),
		.err(),
		.writeData({15'b0, rstIn}),
		.readData(rst_reg_out),
		.writeEn(1'b1));


	assign Halt_nOut = aux_reg_out[10] & ~flush;

	assign rstOut = rst_reg_out[0];

	assign id_ex_rs = aux_reg_out[9:7];

	assign id_ex_rt = aux_reg_out[6:4];

	assign WriteRegSelOut = aux_reg_out[3:1];

	assign errOut = (Ctrl_err | PCAdd2_err | ReadData1_err | ReadData2_err | ImmExt_err | aux_err | aux_reg_out[0]) & ~rstOut;

endmodule
