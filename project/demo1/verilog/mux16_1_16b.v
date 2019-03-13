module mux16_1_16b(In0, In1, In2, In3, In4, In5, In6, In7, In8, In9, In10, In11, In12, In13, In14, In15, S, Out);

	input [15:0] In0, In1, In2, In3, In4, In5, In6, In7, In8, In9, In10, In11, In12, In13, In14, In15;
	input [3:0] S;
	output [15:0] Out;

	wire [15:0] w0;
	wire [15:0] w1;

	mux8_1_16b m0(In0, In1, In2, In3, In4, In5, In6, In7, S[2:0], w0);
	mux8_1_16b m1(In8, In9, In10, In11, In12, In13, In14, In15, S[2:0], w1);
	mux2_1_16b m2(.InA(w0), .InB(w1), .S(S[3]), .Out(Out));

endmodule