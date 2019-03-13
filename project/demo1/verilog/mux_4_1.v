module mux_4_1(in0, in1, in2, in3, s, out);

	input in0;
	input in1;
	input in2;
	input in3;
	input [1:0] s;
	output out;

	wire w0;
	wire w1;
	mux_2_1 m0(in0, in1, s[0], w0);
	mux_2_1 m1(in2, in3, s[0], w1);
	mux_2_1 m_out(w0, w1, s[1], out);

endmodule
