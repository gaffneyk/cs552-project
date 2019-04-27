module EX_MEM_reg(clk, CtrlIn, PCAdd2In, WriteRegSelIn, ReadData2In, ALUOutIn,
	MSBIn, ZeroIn, PCImmAddIn, Halt_nIn, rstIn, errIn, dmem_stall, CtrlOut, 
	PCAdd2Out, WriteRegSelOut, ReadData2Out, ALUOutOut, MSBOut, ZeroOut, 
	PCImmAddOut, Halt_nOut, rstOut, errOut);

	input clk;
	input [15:0] CtrlIn;
	input [15:0] PCAdd2In;
	input [15:0] ReadData2In;
	input [15:0] ALUOutIn;
	input [15:0] PCImmAddIn;
	input MSBIn;
	input ZeroIn;
	input [2:0] WriteRegSelIn;
	input Halt_nIn;
	input rstIn;
	input errIn;
	input dmem_stall;

	output [15:0] CtrlOut;
	output [15:0] PCAdd2Out;
	output [15:0] ReadData2Out;
	output [15:0] ALUOutOut;
	output [15:0] PCImmAddOut;
	output MSBOut;
	output ZeroOut;
	output [2:0] WriteRegSelOut;
	output Halt_nOut;
	output rstOut;
	output errOut;

	wire Ctrl_err, PCAdd2_err, ReadData2_err, ALUOut_err, PCImmAdd_err, aux_err;
	wire [15:0] aux_reg_out;
	wire [15:0] rst_reg_out;
	wire [15:0] halt_reg_out;

	register Ctrl_reg(
		.clk(clk),
		.rst(rstIn),
		.err(Ctrl_err),
		.writeData(CtrlIn),
		.readData(CtrlOut),
		.writeEn(~dmem_stall));

	register PCAdd2_reg(
		.clk(clk),
		.rst(rstIn),
		.err(PCAdd2_err),
		.writeData(PCAdd2In),
		.readData(PCAdd2Out),
		.writeEn(~dmem_stall));

	register ReadData2_reg(
		.clk(clk),
		.rst(rstIn),
		.err(ReadData2_err),
		.writeData(ReadData2In),
		.readData(ReadData2Out),
		.writeEn(~dmem_stall));

	register ALUOut_reg(
		.clk(clk),
		.rst(rstIn),
		.err(ALUOut_err),
		.writeData(ALUOutIn),
		.readData(ALUOutOut),
		.writeEn(~dmem_stall));

	register PCImmAdd_reg(
		.clk(clk),
		.rst(rstIn),
		.err(PCImmAdd_err),
		.writeData(PCImmAddIn),
		.readData(PCImmAddOut),
		.writeEn(~dmem_stall));

	register aux_reg(
		.clk(clk),
		.rst(rstIn),
		.err(aux_err),
		.writeData({10'b0, MSBIn, ZeroIn, WriteRegSelIn, errIn}),
		.readData(aux_reg_out),
		.writeEn(~dmem_stall));

	register rst_reg(
		.clk(clk),
		.rst(1'b0),
		.err(),
		.writeData({15'b0, rstIn}),
		.readData(rst_reg_out),
		.writeEn(1'b1));

	register halt_reg(
		.clk(clk),
		.rst(1'b0),
		.err(),
		.writeData({15'b0, Halt_nIn}),
		.readData(halt_reg_out),
		.writeEn(~dmem_stall));

	assign Halt_nOut = halt_reg_out[0];

	assign rstOut = rst_reg_out[0];

	assign MSBOut = aux_reg_out[5];

	assign ZeroOut = aux_reg_out[4];

	assign WriteRegSelOut = aux_reg_out[3:1];

	assign errOut = (Ctrl_err | PCAdd2_err | ReadData2_err | ALUOut_err | PCImmAdd_err | aux_err | aux_reg_out[0]) & ~rstOut;

endmodule
