module pc_updater(PC_2, PC_2_I, PCImm, PCSrc, Jump, Op_1_0, ALUResult, MSB, Zero, Out);

	input [15:0] PC_2;
	input [15:0] PC_2_I;
	input PCImm;
	input PCSrc;
	input Jump;
	input [1:0] Op_1_0;
	input [15:0] ALUResult;
	input MSB;
	input Zero;

	output [15:0] Out;

	wire branch_mux_out;
	wire [15:0] first_mux_out;
	wire [15:0] second_mux_out;

	mux4_1 branch_mux(.InA(~Zero), .InB(Zero), .InC(MSB), .InD(~MSB), .S(Op_1_0), .Out(branch_mux_out));
	mux2_1_16b first_mux(.InA(PC_2), .InB(PC_2_I), .S(PCImm), .Out(first_mux_out));
	mux2_1_16b second_mux(.InA(first_mux_out), .InB(PC_2_I), .S(PCSrc & branch_mux_out), .Out(second_mux_out));
	mux2_1_16b third_mux(.InA(second_mux_out), .InB(ALUResult), .S(Jump), .Out(Out));

endmodule
