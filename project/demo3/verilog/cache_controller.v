module cache_controller(
	// Outputs
	addr_out, data_out, cache_offset, cache_enable, mem_offset, 
	write, comp, wr_out, rd_out, data_src, tag_src, done, stall, 
	mem_system_cache_hit, err,
	// Inputs
	addr_in, data_in, rd_in, wr_in, cache_valid, cache_dirty,
	cache_hit, clk, rst
	);

	parameter memtype = 0;

	input [15:0] addr_in,
				 data_in;

	input rd_in,
		  wr_in,
		  clk,
		  rst;

	input [1:0] cache_valid,
		  cache_dirty,
		  cache_hit;

	output [15:0] addr_out,
				  data_out;

	output [2:0] cache_offset;

	output reg [2:0] mem_offset;

	output reg [1:0] cache_enable;

	output reg done, comp, write, wr_out, rd_out, data_src, tag_src, 
		stall, mem_system_cache_hit, err;

	wire [15:0] current_state, reg_wr_rd_out;

	reg [15:0] next_state;

	reg [2:0] cache_offset_reg;

	reg [1:0] cache_enable_temp;

	wire [15:0] reg_addr_out, reg_data_out;

	wire reg_addr_err,
	     reg_data_err,
		 reg_state_err,
		 reg_wr_rd_err,
		 state_wr,
		 state_rd,
		 victim_way_out;

	reg reg_en, victim_way_in, cache_offset_src, addr_data_out_src;

	assign cache_offset = cache_offset_src ? 
		addr_out[2:0]
	:
		cache_offset_reg;

	assign addr_out = addr_data_out_src ?
		addr_in
	:
		reg_addr_out;


	assign data_out = addr_data_out_src ?
		data_in
	:
		reg_data_out;

	register reg_state(
		// Outputs
		.readData(current_state),
		.err(reg_state_err),
		// Inputs
		.writeData(next_state),
		.writeEn(1'b1),
		.clk(clk),
		.rst(rst));

	register reg_addr(
		// Outputs
		.readData(reg_addr_out),
		.err(reg_addr_err),
		// Inputs
		.writeData(addr_in),
		.writeEn(reg_en),
		.clk(clk),
		.rst(rst));

	register reg_data(
		// Outputs
		.readData(reg_data_out),
		.err(reg_data_err),
		// Inputs
		.writeData(data_in),
		.writeEn(reg_en),
		.clk(clk),
		.rst(rst));

	register reg_wr_rd(
		// Outputs
		.readData(reg_wr_rd_out),
		.err(reg_wr_rd_err),
		// Inputs
		.writeData({14'b0, wr_in, rd_in}),
		.writeEn(reg_en),
		.clk(clk),
		.rst(rst));

	dff victimway(
		.q(victim_way_out),
		.d(rst ? 1'b0 : victim_way_in),
		.clk(clk),
		.rst(rst));

	assign state_wr = reg_wr_rd_out[1];
	assign state_rd = reg_wr_rd_out[0];

	always @(rd_in or wr_in or current_state or cache_hit or cache_valid)
	casex (current_state[3:0])
	
	4'b0000: begin // Idle
		victim_way_in = (rd_in | wr_in) ? ~victim_way_out : victim_way_out;

		reg_en = 1;
		addr_data_out_src = 1;

		comp = 1;
		write = wr_in;

		rd_out = 0;
		wr_out = 0;
		
		cache_offset_src = 1;

		done = (rd_in | wr_in)
			& ((cache_hit[0] & cache_valid[0]) 
				| (cache_hit[1] & cache_valid[1]));

		mem_system_cache_hit = done;

		stall = (rd_in | wr_in) 
			& ~done;

		next_state = stall ?
			4'b0010 // -> Enable
		: 4'b0000; // -> Idle

		cache_enable = (rd_in | wr_in) ?
			2'b11
		: 2'b00;
	end

	4'b0010: begin // Enable
		reg_en = 0;
		addr_data_out_src = 0;
		cache_enable_temp = (~cache_valid[0]) ?
			2'b01 // Way 0 is invalid, enable way 0
		: (~cache_valid[1]) ?
			2'b10 // Way 1 is invalid, enable way 1
		: (victim_way_out) ?
			2'b10 // Both ways are valid, choose victim
		: 2'b01;

		next_state = (cache_enable_temp[0] & cache_valid[0] & cache_dirty[0]) ?
			4'b0011 // -> Access Read 0
		: (cache_enable_temp[1] & cache_valid[1] & cache_dirty[1]) ?
			4'b0011 // -> Access Read 0
		: 4'b0111; // -> Request 0
	end

	4'b0011: begin // Access Read 0
		cache_enable = cache_enable_temp;
		cache_offset_src = 0;
		cache_offset_reg = 3'b000;
		mem_offset = 3'b000;
		comp = 0;
		write = 0;
		tag_src = 1;
		wr_out = 1;
		rd_out = 0;
		next_state = 4'b0100; // -> Access Read 1
	end

	4'b0100: begin // Access Read 1
		cache_offset_reg = 3'b010;
		mem_offset = 3'b010;
		next_state = 4'b0101; // -> Access Read 2
	end

	4'b0101: begin // Access Read 2
		cache_offset_reg = 3'b100;
		mem_offset = 3'b100;
		next_state = 4'b0110; // -> Access Read 3
	end

	4'b0110: begin // Access Read 3
		cache_offset_reg = 3'b110;
		mem_offset = 3'b110;
		next_state = 4'b0111; // -> Request 0
	end

	4'b0111: begin // Request 0
		cache_enable = cache_enable_temp;
		mem_offset = 3'b000;
		tag_src = 0;
		wr_out = 0;
		rd_out = 1;
		next_state = 4'b1000; // -> Request 1
	end

	4'b1000: begin // Request 1
		mem_offset = 3'b010;
		next_state = 4'b1001; // -> Request 2, Access Write 0
	end

	4'b1001: begin // Request 2, Access Write 0
		cache_offset_src = 0;
		cache_offset_reg = 3'b000;
		mem_offset = 3'b100;
		comp = 0;
		write = 1;
		data_src = 1;
		next_state = 4'b1010; // -> Request 3, Access Write 1
	end

	4'b1010: begin // Request 3, Access Write 1
		cache_offset_reg = 3'b010;
		mem_offset = 3'b110;
		next_state = 4'b1011; // -> Access Write 2
	end

	4'b1011: begin // Access Write 2
		cache_offset_reg = 3'b100;
		next_state = 4'b1100; // -> Access Write 3
	end

	4'b1100: begin // Access Write 3
		cache_offset_reg = 3'b110;
		next_state = 4'b1101; // -> Done
	end

	4'b1101: begin // Done
		done = 1;
		stall = 0;
		data_src = 0;
		reg_en = 1;
		cache_offset_src = 1;
		comp = 1;
		write = state_wr ? 1 : 0;
		next_state = 4'b0000; // -> Idle
	end

	default: begin next_state = 4'b0000; err = 1; end

	endcase

endmodule
