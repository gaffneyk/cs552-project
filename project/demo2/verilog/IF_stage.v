
module IF_stage (
		//outputs
		PCAdd2, PCAddr, branch_det,
		//inputs
		hazard_f, branch_EX_MEM, branch_ID_EX, clk, rst, PCUpdateH, Halt_n
		);

	input 		hazard_f, branch_EX_MEM, branch_ID_EX, clk, rst, Halt_n;
	input [15:0]	PCUpdateH;

	output 		branch_det;
	output [15:0]	PCAdd2, PCAddr;

	wire [1:0]	PC_sel;
	wire [15:0]	PCUpdate;

	register PC (.readData(PCAddr), .err(PCErr), .clk(clk), .rst(rst), .writeData(PCUpdate), .writeEn(Halt_n));
	rca_16b PCrca2 (.A(PCAddr), .B(16'b10), .C_in(1'b0), .S(PCAdd2), .C_out(PCrca2Err));
	
	assign PC_sel = {branch_det, hazard_f};
	mux4_1_16b PC_in (.InA(PCAdd2), .InB(PCAddr), .InC(PCUpdateH), .InD(PCUpdateH), .S(PC_sel), .Out(PCUpdate));

	assign	branch_det = (branch_EX_MEM | branch_ID_EX);
	


endmodule
