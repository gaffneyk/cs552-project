module ID_EX_reg(clk, rst, CtrlIn, PCAdd2In, WriteRegSelIn, ReadData1In, ReadData2In, ImmExtIn, errIn, CtrlOut, PCAdd2Out, WriteRegSelOut, ReadData1Out, ReadData2Out, ImmExtOut, errOut);

	input clk, rst;
	input [15:0] CtrlIn;
	input [15:0] PCAdd2In;
	input [2:0] WriteRegSelIn;
	input [15:0] ReadData1In;
	input [15:0] ReadData2In;
	input [15:0] ImmExtIn;
	input errIn;

	output [15:0] CtrlOut;
	output [15:0] PCAdd2Out;
	output [2:0] WriteRegSelOut;
	output [15:0] ReadData1Out;
	output [15:0] ReadData2Out;
	output [15:0] ImmExtOut;
	output errOut;

	wire Ctrl_err, PCAdd2_err, ReadData1_err, ReadData2_err, ImmExt_err, aux_err;
	wire [15:0] aux_reg_out;

	register Ctrl_reg(
		.clk(clk),
		.rst(rst),
		.err(Ctrl_err),
		.writeData(CtrlIn),
		.readData(CtrlOut),
		.writeEn(1'b1));

	register PCAdd2_reg(
		.clk(clk),
		.rst(rst),
		.err(PCAdd2_err),
		.writeData(PCAdd2In),
		.readData(PCAdd2Out),
		.writeEn(1'b1));

	register ReadData1_reg(
		.clk(clk),
		.rst(rst),
		.err(ReadData1_err),
		.writeData(ReadData1In),
		.readData(ReadData1Out),
		.writeEn(1'b1));

	register ReadData2_reg(
		.clk(clk),
		.rst(rst),
		.err(ReadData2_err),
		.writeData(ReadData2In),
		.readData(ReadData2Out),
		.writeEn(1'b1));

	register ImmExt_reg(
		.clk(clk),
		.rst(rst),
		.err(ImmExt_err),
		.writeData(ImmExtIn),
		.readData(ImmExtOut),
		.writeEn(1'b1));

	register aux_reg(
		.clk(clk),
		.rst(rst),
		.err(aux_err),
		.writeData({12'b0, WriteRegSelIn, errIn}),
		.readData(aux_reg_out),
		.writeEn(1'b1));

	assign WriteRegSelOut = aux_reg_out[3:1];

	assign errOut = (Ctrl_err | PCAdd2_err | ReadData1_err | ReadData2_err | ImmExt_err | aux_err | aux_reg_out[0]) & ~rst;

endmodule
