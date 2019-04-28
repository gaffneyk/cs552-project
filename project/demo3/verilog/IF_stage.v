
module IF_stage (
		//outputs
		PCAdd2, Inst,
		//inputs
		hazard_f, branch_ID, branch_EX, branch_MEM, clk, rst, PCUpdateH,
		Halt_n, dmem_stall
		);

	input 		hazard_f, branch_ID, branch_EX, branch_MEM, clk, rst, Halt_n;
	input [15:0]	PCUpdateH;
	input [15:0] dmem_stall;

	output [15:0]	PCAdd2, Inst;

	wire		branch_det, no_hazard, inst_mem_done, inst_mem_stall, 
		inst_mem_cache_hit, inst_mem_err, insert_stall;
	wire [1:0]	PC_sel;
	wire [15:0]	PCUpdate, PCAddr, Inst_B;

	register PC (.readData(PCAddr), .err(PCErr), .clk(clk), .rst(rst), .writeData(PCUpdate), .writeEn(Halt_n));

	// memory2c InstMem (.data_out(Inst_B), .data_in(16'b0), .addr(PCAddr), .enable(1'b1), .wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst));
	mem_system InstMem (.DataOut(Inst_B), .Done(inst_mem_done), 
		.Stall(inst_mem_stall), .CacheHit(inst_mem_cache_hit), 
		.err(inst_mem_err), .Addr(PCAddr), .DataIn(16'b0), .Rd(~rst),
		.Wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst));

	rca_16b PCrca2 (.A(PCAddr), .B(16'b10), .C_in(1'b0), .S(PCAdd2), .C_out(PCrca2Err));
	
	assign branch_det = (branch_ID === 1'b1 | branch_EX === 1'b1 | branch_MEM === 1'b1);
	assign insert_stall = branch_det | (inst_mem_stall & ~inst_mem_done) | dmem_stall | rst;

	// If no hazard, stall, or branch, PCUpdate = PCAdd2
	// If branch, PCUpdate = PCUpdateH
	// If stall or hazard, PCUpdate = PCAddr
	assign PCUpdate = rst ?
		PCAddr
	: (!branch_det & !hazard_f & !insert_stall) ?
		PCAdd2
	: branch_det ?
		PCUpdateH
	: PCAddr;

	assign Inst = (branch_det | rst | ~inst_mem_done) ?
		16'b0000100000000000
	: Inst_B;

endmodule
