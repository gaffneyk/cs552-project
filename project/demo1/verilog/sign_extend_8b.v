module sign_extend_8b(in, out);

	input  [7:0]  in;
	output [15:0] out;

	assign out[7:0] = in;
	assign out[15:8] = {8{in[7]}};

endmodule
