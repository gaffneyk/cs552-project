module MEM_WB_reg(clk, CtrlIn, PCAdd2In, WriteRegSelIn, ALUOutIn, DMemDataIn, rstIn, errIn, CtrlOut, PCAdd2Out, WriteRegSelOut, ALUOutOut, DMemDataOut, rstOut, errOut);

	input clk;
	input [15:0] CtrlIn;
	input [15:0] PCAdd2In;
	input [15:0] ALUOutIn;
	input [15:0] DMemDataIn;
	input [2:0] WriteRegSelIn;
	input rstIn;
	input errIn;

	output [15:0] CtrlOut;
	output [15:0] PCAdd2Out;
	output [15:0] ALUOutOut;
	output [15:0] DMemDataOut;
	output [2:0] WriteRegSelOut;
	output rstOut;
	output errOut;

	wire Ctrl_err, PCAdd2_err, ALUOut_err, DMemData_err, aux_err;
	wire [15:0] aux_reg_out;

	register Ctrl_reg(
		.clk(clk),
		.rst(rstIn),
		.err(Ctrl_err),
		.writeData(CtrlIn),
		.readData(CtrlOut),
		.writeEn(1'b1));

	register PCAdd2_reg(
		.clk(clk),
		.rst(rstIn),
		.err(PCAdd2_err),
		.writeData(PCAdd2In),
		.readData(PCAdd2Out),
		.writeEn(1'b1));

	register ALUOut_reg(
		.clk(clk),
		.rst(rstIn),
		.err(ALUOut_err),
		.writeData(ALUOutIn),
		.readData(ALUOutOut),
		.writeEn(1'b1));

	register DMemData_reg(
		.clk(clk),
		.rst(rstIn),
		.err(DMemData_err),
		.writeData(DMemDataIn),
		.readData(DMemDataOut),
		.writeEn(1'b1));

	register aux_reg(
		.clk(clk),
		.rst(rstIn),
		.err(aux_err),
		.writeData({11'b0, WriteRegSelIn, rstOut, errIn}),
		.readData(aux_reg_out),
		.writeEn(1'b1));

	assign WriteRegSelOut = aux_reg_out[4:2];

	assign rstOut = aux_reg_out[1];

	assign errOut = (Ctrl_err | PCAdd2_err | ALUOut_err | DMemData_err | aux_err | aux_reg_out[0]) & ~rstOut;

endmodule
