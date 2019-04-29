module forwarding_unit(id_ex_rs, id_ex_rt, ex_mem_rd, ex_mem_reg_write,
	mem_wb_rd, mem_wb_reg_write, forward_a, forward_b);

	input [2:0] id_ex_rs, id_ex_rt, ex_mem_rd, mem_wb_rd;
	input ex_mem_reg_write, mem_wb_reg_write;
	output [1:0] forward_a, forward_b;

	assign forward_a = 
		(ex_mem_reg_write 
			& |ex_mem_rd 
			& ex_mem_rd == id_ex_rs) ?
			2'b10
		: (mem_wb_reg_write 
			& |mem_wb_rd 
			& ~(ex_mem_reg_write & |ex_mem_rd & ex_mem_rd == id_ex_rs) 
			& mem_wb_rd == id_ex_rs) ?
			2'b01
		:
			2'b00;

	assign forward_b =
		(ex_mem_reg_write
			& |ex_mem_rd 
			& ex_mem_rd == id_ex_rt) ?
			2'b10
		: (mem_wb_reg_write
			& |mem_wb_rd
			& ~(ex_mem_reg_write & |ex_mem_rd & ex_mem_rd == id_ex_rt)
			& mem_wb_rd == id_ex_rt) ?
			2'b01
		:
			2'b00;

endmodule
