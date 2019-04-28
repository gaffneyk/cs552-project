module cache_controller(
	// Outputs
	cache_offset, cache_enable, mem_offset, write, comp, wr_out, 
	rd_out, data_src, tag_src, done, stall, mem_system_cache_hit, 
	err,
	// Inputs
	addr_in, data_in, rd_in, wr_in, cache_valid, cache_dirty, 
	cache_hit, clk, rst
	);

	input clk,
		  rst;

	input [1:0] cache_valid,
		  cache_dirty,
		  cache_hit;

	output reg [2:0] cache_offset,
				 mem_offset;

	output reg [1:0] cache_enable;

	output reg done, comp, write, data_src, tag_src, stall, 
		mem_system_cache_hit, rd_out, wr_out, err;

	wire [15:0] current_state;

	reg [15:0] next_state;

	wire reg_state_err,
		 victim_way_out;

	reg victim_way_in;

	register reg_state(
		// Outputs
		.readData(current_state),
		.err(reg_state_err),
		// Inputs
		.writeData(next_state),
		.writeEn(1'b1),
		.clk(clk),
		.rst(rst));

	dff victimway(
		.q(victim_way_out),
		.d(rst ? 1'b0 : victim_way_in),
		.clk(clk),
		.rst(rst));

	always @(rd_in or wr_in or current_state)
	casex (current_state[3:0])
	
	4'b0000: begin // Idle
		done = 0;
		stall = 0;
		rd_out = 0;
		wr_out = 0;
		victim_way_in = victim_way_out;

		next_state = (rd_in | wr_in) ?
			4'b0001 // -> Compare
		: 4'b0000; // -> Idle

		cache_enable = (rd_in | wr_in) ?
			2'b11 // -> Compare
		: 2'b00; // -> Idle
	end

	4'b0001: begin // Compare
		stall = 1;
		cache_offset = addr_out[2:0];
		comp = 1;
		write = wr_in ? 1 : 0;
		victim_way_in = ~victim_way_out;

		done = ((cache_hit[0] & cache_valid[0]) | (cache_hit[1] & cache_valid[1])) ? 1 : 0;

		mem_system_cache_hit = ((cache_hit[0] & cache_valid[0]) | (cache_hit[1] & cache_valid[1])) ? 1 : 0;

		next_state = ((cache_hit[0] & cache_valid[0]) | (cache_hit[1] & cache_valid[1])) ?
			4'b0000 // -> Idle
		: 4'b0010;
	end

	4'b0010: begin // Enable
		cache_enable = (~cache_valid[0]) ?
			2'b01 // Way 0 is invalid, enable way 0
		: (~cache_valid[1]) ?
			2'b10 // Way 1 is invalid, enable way 1
		: (victim_way_out) ?
			2'b10 // Both ways are valid, choose victim
		: 2'b01;

		next_state = (cache_enable[0] & cache_valid[0] & cache_dirty[0]) ?
			4'b0011 // -> Access Read 0
		: (cache_enable[1] & cache_valid[1] & cache_dirty[1]) ?
			4'b0011 // -> Access Read 0
		: 4'b0111;
	end

	4'b0011: begin // Access Read 0
		cache_offset = 3'b000;
		mem_offset = 3'b000;
		comp = 0;
		write = 0;
		tag_src = 1;
		wr_out = 1;
		rd_out = 0;
		next_state = 4'b0100; // -> Access Read 1
	end

	4'b0100: begin // Access Read 1
		cache_offset = 3'b010;
		mem_offset = 3'b010;
		next_state = 4'b0101; // -> Access Read 2
	end

	4'b0101: begin // Access Read 2
		cache_offset = 3'b100;
		mem_offset = 3'b100;
		next_state = 4'b0110; // -> Access Read 3
	end

	4'b0110: begin // Access Read 3
		cache_offset = 3'b110;
		mem_offset = 3'b110;
		next_state = 4'b0111; // -> Request 0
	end

	4'b0111: begin // Request 0
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
		cache_offset = 3'b000;
		mem_offset = 3'b100;
		comp = 0;
		write = 1;
		data_src = 1;
		next_state = 4'b1010; // -> Request 3, Access Write 1
	end

	4'b1010: begin // Request 3, Access Write 1
		cache_offset = 3'b010;
		mem_offset = 3'b110;
		next_state = 4'b1011; // -> Access Write 2
	end

	4'b1011: begin // Access Write 2
		cache_offset = 3'b100;
		next_state = 4'b1100; // -> Access Write 3
	end

	4'b1100: begin // Access Write 3
		cache_offset = 3'b110;
		next_state = 4'b1101;
	end

	4'b1101: begin // Done
		done = 1;
		data_src = 0;
		cache_offset = addr_out[2:0];
		comp = 1;
		write = wr_in ? 1 : 0;
		next_state = 4'b0000; // -> Idle
	end

	default: begin next_state = 4'b0000; err = 1; end

	endcase

endmodule
