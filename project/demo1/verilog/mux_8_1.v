module mux_8_1(in0, in1, in2, in3, in4, in5, in6, in7, s, out);

	input in0;
	input in1;
	input in2;
	input in3;
	input in4;
	input in5;
	input in6;
	input in7;
	input [2:0] s;
	output out;

	wire w0;
	wire w1;
	mux_4_1 m0(in0, in1, in2, in3, s[1:0], w0);
	mux_4_1 m1(in4, in5, in6, in7, s[1:0], w1);
	mux_2_1 m_out(w0, w1, s[2], out);

endmodule
