module MEM_WB_reg(clk, CtrlIn, PCAdd2In, WriteRegSelIn, ALUOutIn, DMemDataIn,
	rstIn, errIn, dmem_stall, Halt_nIn, CtrlOut, PCAdd2Out, WriteRegSelOut, 
	ALUOutOut, DMemDataOut, Halt_nOut, rstOut, errOut);

	input clk;
	input [15:0] CtrlIn;
	input [15:0] PCAdd2In;
	input [15:0] ALUOutIn;
	input [15:0] DMemDataIn;
	input [2:0] WriteRegSelIn;
	input rstIn;
	input errIn;
	input dmem_stall;
	input Halt_nIn;

	output [15:0] CtrlOut;
	output [15:0] PCAdd2Out;
	output [15:0] ALUOutOut;
	output [15:0] DMemDataOut;
	output [2:0] WriteRegSelOut;
	output Halt_nOut;
	output rstOut;
	output errOut;

	wire Ctrl_err, PCAdd2_err, ALUOut_err, DMemData_err, aux_err;
	wire [15:0] aux_reg_out;
	wire [15:0] rst_reg_out;
	wire [15:0] Ctrl_reg_out

	register Ctrl_reg(
		.clk(clk),
		.rst(rstIn),
		.err(Ctrl_err),
		.writeData(CtrlIn),
		.readData(Ctrl_reg_out),
		.writeEn(~dmem_stall));

	register PCAdd2_reg(
		.clk(clk),
		.rst(rstIn),
		.err(PCAdd2_err),
		.writeData(PCAdd2In),
		.readData(PCAdd2Out),
		.writeEn(~dmem_stall));

	register ALUOut_reg(
		.clk(clk),
		.rst(rstIn),
		.err(ALUOut_err),
		.writeData(ALUOutIn),
		.readData(ALUOutOut),
		.writeEn(~dmem_stall));

	register DMemData_reg(
		.clk(clk),
		.rst(rstIn),
		.err(DMemData_err),
		.writeData(DMemDataIn),
		.readData(DMemDataOut),
		.writeEn(~dmem_stall));

	register aux_reg(
		.clk(clk),
		.rst(rstIn),
		.err(aux_err),
		.writeData({12'b0, WriteRegSelIn, errIn}),
		.readData(aux_reg_out),
		.writeEn(~dmem_stall));

	register rst_reg(
		.clk(clk),
		.rst(1'b0),
		.err(),
		.writeData({14'b0, Halt_nIn, rstIn}),
		.readData(rst_reg_out),
		.writeEn(1'b1));

	// Force a nop if dmem is stalling
	assign CtrlOut = dmem_stall ? 16'b0000100001000000 : Ctrl_reg_out;

	assign Halt_nOut = rst_reg_out[1];

	assign rstOut = rst_reg_out[0];

	assign WriteRegSelOut = aux_reg_out[3:1];

	assign errOut = (Ctrl_err | PCAdd2_err | ALUOut_err | DMemData_err | aux_err | aux_reg_out[0]) & ~rstOut;

endmodule
