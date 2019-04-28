
module MEM_stage (
		//outputs
		DMemData, PCUpdate, dmem_stall, dmem_done,
		//inputs
		clk, rst, MSB, Zero, readData2, ALU_Out, DMemEn, DMemWrite, DMemDump, PCAdd2, PCImmAdd, PCImm, PCSrc, Jump, OpCode1_0
		);

	input		clk, rst, MSB, Zero, DMemEn, DMemWrite, DMemDump, PCImm, PCSrc, Jump;
	input [1:0]	OpCode1_0;
	input [15:0]	readData2, ALU_Out, PCAdd2, PCImmAdd;
	
	output [15:0]	DMemData, PCUpdate;

	output dmem_stall, dmem_done;

	wire dmem_cache_hit, dmem_err;


	// memory2c DataMem (.data_out(DMemData), .data_in(readData2), .addr(ALU_Out), .enable(DMemEn), .wr(DMemWrite), .createdump(DMemDump), .clk(clk), .rst(rst));
	stallmem DataMem (.DataOut(DMemData), .Done(dmem_done), .Stall(dmem_stall),
		.CacheHit(dmem_cache_hit), .err(dmem_err), .Addr(ALU_Out),
		.DataIn(readData2), .Rd(DMemEn), .Wr(DMemWrite), .createdump(DMemDump),
		.clk(clk), .rst(rst));

	pc_updater PCUpdater (.PC_2(PCAdd2), .PC_2_I(PCImmAdd), .PCImm(PCImm), .PCSrc(PCSrc), .Jump(Jump), .Op_1_0(OpCode1_0), .ALUResult(ALU_Out), .MSB(MSB), .Zero(Zero), .Out(PCUpdate));


endmodule
