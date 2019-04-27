
module EX_stage (
		//outputs
		ALU_Out, MSB, Zero, PCImmAdd,
		//inputs
		ImmExt, readData1, readData2, ALUSrc2, ALUCtrl, PCAdd2
		);

	input		ALUSrc2;
	input [3:0]	ALUCtrl;
	input [15:0]	ImmExt, readData1, readData2, PCAdd2;

	output		MSB, Zero;
	output [15:0]	ALU_Out, PCImmAdd;

	wire [15:0]	ALUSrc2Data;

	mux2_1_16b MuxALUSrc2 (.InA(ImmExt), .InB(readData2), .S(ALUSrc2), .Out(ALUSrc2Data));
	alu ALU1 (.InA(readData1), .InB(ALUSrc2Data), .Op(ALUCtrl), .Out(ALU_Out), .MSB(MSB), .Zero(Zero));
	rca_16b PCrcaImm(.A(PCAdd2), .B(ImmExt), .C_in(1'b0), .S(PCImmAdd), .C_out(PCrcaImmC_out));


endmodule
