
module IF_stage (
		//outputs
		PCAdd2, Inst,
		//inputs
		hazard_f, branch_ID, branch_EX, branch_MEM, clk, rst, PCUpdateH, Halt_n
		);

	input 		hazard_f, branch_ID, branch_EX, branch_MEM, clk, rst, Halt_n;
	input [15:0]	PCUpdateH;

	output [15:0]	PCAdd2, Inst;

	wire		branch_det, no_hazard, inst_mem_done, inst_mem_stall, 
		inst_mem_cache_hit, inst_mem_err, insert_stall;
	wire [1:0]	PC_sel;
	wire [15:0]	PCUpdate, PCAddr, Inst_B;

	register PC (.readData(PCAddr), .err(PCErr), .clk(clk), .rst(rst), .writeData(PCUpdate), .writeEn(Halt_n));

	// memory2c InstMem (.data_out(Inst_B), .data_in(16'b0), .addr(PCAddr), .enable(1'b1), .wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst));
	stallmem InstMem (.DataOut(Inst_B), .Done(inst_mem_done), 
		.Stall(inst_mem_stall), .CacheHit(inst_mem_cache_hit), 
		.err(inst_mem_err), .Addr(PCAddr), .DataIn(16'b0), .Rd(1'b1),
		.Wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst));

	rca_16b PCrca2 (.A(PCAddr), .B(16'b10), .C_in(1'b0), .S(PCAdd2), .C_out(PCrca2Err));
	
	assign no_hazard = branch_det !== 1'b1 & hazard_f !== 1'b1 & insert_stall !== 1'b1;
	assign PC_sel = no_hazard ? 2'b00 : {branch_det, hazard_f};

	mux4_1_16b PC_in (.InA(PCAdd2), .InB(PCAddr), .InC(PCUpdateH), .InD(PCUpdateH), .S(PC_sel), .Out(PCUpdate));

	assign	branch_det = (branch_ID === 1'b1 | branch_EX === 1'b1 | branch_MEM === 1'b1);

	assign insert_stall = branch_det | inst_mem_stall;

	mux2_1_16b muxBranch_NOP (.InA(Inst_B), .InB(16'b0000100000000000), .S(insert_stall), .Out(Inst));
	


endmodule
