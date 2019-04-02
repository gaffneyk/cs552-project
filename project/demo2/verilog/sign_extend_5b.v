module sign_extend_5b(in, out);

	input  [4:0]  in;
	output [15:0] out;

	assign out[4:0] = in;
	assign out[15:5] = {11{in[4]}};

endmodule
