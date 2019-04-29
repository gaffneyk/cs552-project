
module EX_stage (
		//outputs
		ALU_Out, MSB, Zero, PCImmAdd,
		//inputs
		ImmExt, readData1, readData2, ALUSrc2, ALUCtrl, PCAdd2,
		forward_a, forward_b, ex_mem_data, mem_wb_data
		);

	input		ALUSrc2;
	input [3:0]	ALUCtrl;
	input [15:0]	ImmExt, readData1, readData2, PCAdd2;
	input [1:0] forward_a, forward_b;
	input [15:0] ex_mem_data, mem_wb_data;

	output		MSB, Zero;
	output [15:0]	ALU_Out, PCImmAdd;

	wire [15:0]	ALUSrc2Data;

	wire [15:0] alu_in_a, alu_in_b;

	assign alu_in_a = (forward_a == 2'b10) ?
		ex_mem_data
	: (forward_a == 2'b01) ?
		mem_wb_data
	: 
		readData1;

	assign alu_in_b = (forward_b == 2'b10) ?
		ex_mem_data
	: (forward_b == 2'b01) ?
		mem_wb_data
	:
		readData2;

	mux2_1_16b MuxALUSrc2 (.InA(ImmExt), .InB(alu_in_b), .S(ALUSrc2), .Out(ALUSrc2Data));
	alu ALU1 (.InA(alu_in_a), .InB(ALUSrc2Data), .Op(ALUCtrl), .Out(ALU_Out), .MSB(MSB), .Zero(Zero));
	rca_16b PCrcaImm(.A(PCAdd2), .B(ImmExt), .C_in(1'b0), .S(PCImmAdd), .C_out(PCrcaImmC_out));


endmodule
