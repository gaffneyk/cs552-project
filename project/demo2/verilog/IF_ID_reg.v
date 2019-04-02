module IF_ID_reg(clk, rst, PCAdd2In, InstIn, errIn, PCAdd2Out, InstOut, errOut);

	input clk, rst;
	input [15:0] PCAdd2In;
	input [15:0] InstIn;
	input errIn;

	output [15:0] PCAdd2Out;
	output [15:0] InstOut;
	output errOut;

	wire PCAdd2_err, Inst_err, aux_err;
	wire [15:0] aux_reg_out;

	register PCAdd2_reg(
		.clk(clk),
		.rst(rst),
		.err(PCAdd2_err),
		.writeData(PCAdd2In),
		.readData(PCAdd2Out),
		.writeEn(1'b1));

	register Inst_reg(
		.clk(clk),
		.rst(rst),
		.err(Inst_err),
		.writeData(InstIn),
		.readData(InstOut),
		.writeEn(1'b1));

	register aux_reg(
		.clk(clk),
		.rst(rst),
		.err(aux_err),
		.writeData({15'b0, errIn}),
		.readData(aux_reg_out),
		.writeEn(1'b1));

	assign errOut = (PCAdd2_err | Inst_err | aux_err | aux_reg_out[0]) & ~rst;

endmodule
