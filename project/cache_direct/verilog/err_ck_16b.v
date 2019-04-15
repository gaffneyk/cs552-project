module err_ck_16b(in, err);

	input [15:0] in;
	output err;

	wire [15:0] tmp;

	assign tmp[15] = in[15] === 1'bx;
	assign tmp[14] = in[14] === 1'bx;
	assign tmp[13] = in[13] === 1'bx;
	assign tmp[12] = in[12] === 1'bx;
	assign tmp[11] = in[11] === 1'bx;
	assign tmp[10] = in[10] === 1'bx;
	assign tmp[9] = in[9] === 1'bx;
	assign tmp[8] = in[8] === 1'bx;
	assign tmp[7] = in[7] === 1'bx;
	assign tmp[6] = in[6] === 1'bx;
	assign tmp[5] = in[5] === 1'bx;
	assign tmp[4] = in[4] === 1'bx;
	assign tmp[3] = in[3] === 1'bx;
	assign tmp[2] = in[2] === 1'bx;
	assign tmp[1] = in[1] === 1'bx;
	assign tmp[0] = in[0] === 1'bx;

	assign err = |tmp;

endmodule
