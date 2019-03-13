module sign_extend_11b(in, out);

	input  [10:0]  in;
	output [15:0] out;

	assign out[10:0] = in;
	assign out[15:11] = {5{in[10]}};

endmodule
