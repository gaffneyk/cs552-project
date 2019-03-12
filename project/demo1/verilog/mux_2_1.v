module mux_2_1(in0, in1, s, out);

	input in0;
	input in1;
	input s;
	output out;

	assign out = (in0 & ~s) | (in1 & s);

endmodule
