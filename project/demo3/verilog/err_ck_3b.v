module err_ck_3b(in, err);

	input [2:0] in;
	output err;

	wire [2:0] tmp;

	assign tmp[2] = in[2] === 1'bx;
	assign tmp[1] = in[1] === 1'bx;
	assign tmp[0] = in[0] === 1'bx;

	assign err = |tmp;

endmodule
