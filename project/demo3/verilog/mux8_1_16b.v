module mux8_1_16b(In0, In1, In2, In3, In4, In5, In6, In7, S, Out);

	input [15:0] In0, In1, In2, In3, In4, In5, In6, In7;
	input [2:0] S;
	output [15:0] Out;

	wire [15:0] w0;
	wire [15:0] w1;

	mux4_1_16b m0(.InA(In0), .InB(In1), .InC(In2), .InD(In3), .S(S[1:0]), .Out(w0));
	mux4_1_16b m1(.InA(In4), .InB(In5), .InC(In6), .InD(In7), .S(S[1:0]), .Out(w1));
	mux2_1_16b m2(.InA(w0), .InB(w1), .S(S[2]), .Out(Out));

endmodule