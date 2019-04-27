/*
    CS/ECE 552 Spring '19
    Homework #3, Problem 1

    4-1 mux template
*/
module mux4_1(InA, InB, InC, InD, S, Out);
    input        InA, InB, InC, InD;
    input [1:0]  S;
    output       Out;

    // YOUR CODE HERE

mux2_1	mux_AB (.InA(InA), .InB(InB), .S(S[0]), .Out(mux_AB_Out));
mux2_1	mux_CD (.InA(InC), .InB(InD), .S(S[0]), .Out(mux_CD_Out));
mux2_1	mux_ABCD (.InA(mux_AB_Out), .InB(mux_CD_Out), .S(S[1]), .Out(mux_ABCD_Out));

assign	Out = mux_ABCD_Out;

endmodule
