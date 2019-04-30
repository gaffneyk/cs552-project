
module IF_stage (
		//outputs
		PCAdd2, Inst,
		//inputs
		hazard_f, branch_ID, branch_EX, branch_MEM, clk, rst, PCUpdateH,
		Halt_n, dmem_stall, BranchTaken
		);

	input 		hazard_f, branch_ID, branch_EX, branch_MEM, clk, rst, Halt_n;
	input [15:0]	PCUpdateH;
	input 		dmem_stall, BranchTaken;

	output [15:0]	PCAdd2, Inst;

	wire		branch_det, no_hazard, inst_mem_done, inst_mem_stall, 
		inst_mem_cache_hit, inst_mem_err, insert_stall, insert_nop;
	wire [1:0]	PC_sel;
	wire [15:0]	PCUpdate, PCAddr, Inst_B;

	register PC (.readData(PCAddr), .err(PCErr), .clk(clk), .rst(rst), .writeData(PCUpdate), .writeEn(Halt_n));

	// memory2c InstMem (.data_out(Inst_B), .data_in(16'b0), .addr(PCAddr), .enable(1'b1), .wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst));
	mem_system #(0) InstMem (.DataOut(Inst_B), .Done(inst_mem_done), 
		.Stall(inst_mem_stall), .CacheHit(inst_mem_cache_hit), 
		.err(inst_mem_err), .Addr(PCAddr), .DataIn(16'b0), .Rd(~rst & ~branch_det),
		.Wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst));

	rca_16b PCrca2 (.A(PCAddr), .B(16'b10), .C_in(1'b0), .S(PCAdd2), .C_out(PCrca2Err));
	
	//assign branch_det = (branch_ID === 1'b1 | branch_EX === 1'b1 | branch_MEM === 1'b1);
	assign insert_stall = (~inst_mem_done) | dmem_stall | rst;
	assign insert_nop = rst | hazard_f | ~inst_mem_done;

	// If no hazard, stall, or branch, PCUpdate = PCAdd2
	// If branch, PCUpdate = PCUpdateH
	// If stall or hazard, PCUpdate = PCAddr
	assign PCUpdate = rst ?
		PCAddr
	: (!BranchTaken & !hazard_f & !insert_stall) ?
		PCAdd2
	: BranchTaken ?
		PCUpdateH
	: PCAddr;

	assign Inst = insert_nop ?
		16'b0000100000000000
	: Inst_B;

endmodule
