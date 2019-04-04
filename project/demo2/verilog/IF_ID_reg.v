module IF_ID_reg(clk, PCAdd2In, InstIn, rstIn, errIn, PCAdd2Out, InstOut, rstOut, errOut);

	input clk;
	input [15:0] PCAdd2In;
	input [15:0] InstIn;
	input rstIn;
	input errIn;

	output [15:0] PCAdd2Out;
	output [15:0] InstOut;
	output rstOut;
	output errOut;

	wire PCAdd2_err, Inst_err, aux_err;
	wire [15:0] aux_reg_out;

	register PCAdd2_reg(
		.clk(clk),
		.rst(1'b0),
		.err(PCAdd2_err),
		.writeData(PCAdd2In),
		.readData(PCAdd2Out),
		.writeEn(1'b1));

	register Inst_reg(
		.clk(clk),
		.rst(1'b0),
		.err(Inst_err),
		.writeData(InstIn),
		.readData(InstOut),
		.writeEn(1'b1));

	register aux_reg(
		.clk(clk),
		.rst(1'b0),
		.err(aux_err),
		.writeData({14'b0, rstIn, errIn}),
		.readData(aux_reg_out),
		.writeEn(1'b1));

	assign rstOut = aux_reg_out[1];

	assign errOut = (PCAdd2_err | Inst_err | aux_err | aux_reg_out[0]) & ~rstOut;

endmodule
