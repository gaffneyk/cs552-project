
module mux4_1_3b(InA, InB, InC, InD, S, Out);

    // parameter N for length of inputs and outputs (to use with larger inputs/outputs)
    parameter N = 3;

    input [N-1:0]   InA, InB, InC, InD;
    input [1:0]     S;
    output [N-1:0]  Out;

    // YOUR CODE HERE

mux4_1 bit_0 (.InA(InA[0]), .InB(InB[0]), .InC(InC[0]), .InD(InD[0]), .S(S), .Out(Out[0]));
mux4_1 bit_1 (.InA(InA[1]), .InB(InB[1]), .InC(InC[1]), .InD(InD[1]), .S(S), .Out(Out[1]));
mux4_1 bit_2 (.InA(InA[2]), .InB(InB[2]), .InC(InC[2]), .InD(InD[2]), .S(S), .Out(Out[2]));

endmodule