module IF_ID_reg(clk, hazard_f, PCAdd2In, InstIn, rstIn, errIn, dmem_stall, flush,
	PCAdd2Out, InstOut, rstOut, errOut);

	input clk;
	input hazard_f;
	input [15:0] PCAdd2In;
	input [15:0] InstIn;
	input rstIn;
	input errIn;
	input dmem_stall;
	input flush;

	output [15:0] PCAdd2Out;
	output [15:0] InstOut;
	output rstOut;
	output errOut;

	wire PCAdd2_err, Inst_err, aux_err;
	wire [15:0] aux_reg_out;
	wire [15:0] rst_reg_out;
	wire [15:0] InstRegOut;

	register PCAdd2_reg(
		.clk(clk),
		.rst(1'b0),
		.err(PCAdd2_err),
		.writeData(PCAdd2In),
		.readData(PCAdd2Out),
		.writeEn(~hazard_f & ~dmem_stall));

	mux2_1_16b FlushMux(.InA(InstRegOut), .InB(16'b0000100000000000), .S(flush), .Out(InstOut));

	register Inst_reg(
		.clk(clk),
		.rst(1'b0),
		.err(Inst_err),
		.writeData(InstIn),
		.readData(InstRegOut),
		.writeEn(~hazard_f & ~dmem_stall));

	register aux_reg(
		.clk(clk),
		.rst(1'b0),
		.err(aux_err),
		.writeData({15'b0, errIn}),
		.readData(aux_reg_out),
		.writeEn(~hazard_f & ~dmem_stall));

	register rst_reg(
		.clk(clk),
		.rst(1'b0),
		.err(),
		.writeData({15'b0, rstIn}),
		.readData(rst_reg_out),
		.writeEn(1'b1));

	assign rstOut = rst_reg_out[0];

	assign errOut = (PCAdd2_err | Inst_err | aux_err | aux_reg_out[0]) & ~rstOut;

endmodule
