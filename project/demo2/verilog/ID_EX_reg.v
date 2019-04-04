module ID_EX_reg(clk, ALUSrc2, ALUCtrl, PCImm, PCSrc, Jump, Opcode1_0, DMemEn, DMemWrite, DMemDump, MemToReg, WriteDataSel, RegWrite, PCAdd2In, WriteRegSelIn, ReadData1In, ReadData2In, ImmExtIn, Halt_nIn, rstIn, errIn, CtrlOut, PCAdd2Out, WriteRegSelOut, ReadData1Out, ReadData2Out, ImmExtOut, Halt_nOut, rstOut, errOut);

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
	input [2:0] WriteRegSelIn;
	input [15:0] ReadData1In;
	input [15:0] ReadData2In;
	input [15:0] ImmExtIn;
	input Halt_nIn;
	input rstIn;
	input errIn;

	output [15:0] CtrlOut;
	output [15:0] PCAdd2Out;
	output [2:0] WriteRegSelOut;
	output [15:0] ReadData1Out;
	output [15:0] ReadData2Out;
	output [15:0] ImmExtOut;
	output Halt_nOut;
	output rstOut;
	output errOut;

	wire Ctrl_err, PCAdd2_err, ReadData1_err, ReadData2_err, ImmExt_err, aux_err;
	wire [15:0] aux_reg_out;

	register Ctrl_reg(
		.clk(clk),
		.rst(1'b0),
		.err(Ctrl_err),
		.writeData({ALUSrc2, ALUCtrl, PCImm, PCSrc, Jump, Opcode1_0, DMemEn, DMemWrite, DMemDump, MemToReg, WriteDataSel, RegWrite}),
		.readData(CtrlOut),
		.writeEn(1'b1));

	register PCAdd2_reg(
		.clk(clk),
		.rst(1'b0),
		.err(PCAdd2_err),
		.writeData(PCAdd2In),
		.readData(PCAdd2Out),
		.writeEn(1'b1));

	register ReadData1_reg(
		.clk(clk),
		.rst(1'b0),
		.err(ReadData1_err),
		.writeData(ReadData1In),
		.readData(ReadData1Out),
		.writeEn(1'b1));

	register ReadData2_reg(
		.clk(clk),
		.rst(1'b0),
		.err(ReadData2_err),
		.writeData(ReadData2In),
		.readData(ReadData2Out),
		.writeEn(1'b1));

	register ImmExt_reg(
		.clk(clk),
		.rst(1'b0),
		.err(ImmExt_err),
		.writeData(ImmExtIn),
		.readData(ImmExtOut),
		.writeEn(1'b1));

	register aux_reg(
		.clk(clk),
		.rst(1'b0),
		.err(aux_err),
		.writeData({10'b0, Halt_nIn, WriteRegSelIn, rstIn, errIn}),
		.readData(aux_reg_out),
		.writeEn(1'b1));

	assign Halt_nOut = aux_reg_out[5];

	assign WriteRegSelOut = aux_reg_out[4:2];

	assign rstOut = aux_reg_out[1];

	assign errOut = (Ctrl_err | PCAdd2_err | ReadData1_err | ReadData2_err | ImmExt_err | aux_err | aux_reg_out[0]) & ~rstOut;

endmodule
