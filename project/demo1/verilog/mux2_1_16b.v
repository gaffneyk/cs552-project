
module mux_2_1_16b(InA, InB, S, Out);

    // parameter N for length of inputs and outputs (to use with larger inputs/outputs)
    parameter N = 16;

    input [N-1:0]   InA, InB;
    input [1:0]     S;
    output [N-1:0]  Out;


mux_2_1 bit_0 (.InA(InA[0]), .InB(InB[0]),.S(S), .Out(Out[0]));
mux_2_1 bit_1 (.InA(InA[1]), .InB(InB[1]),.S(S), .Out(Out[1]));
mux_2_1 bit_2 (.InA(InA[2]), .InB(InB[2]),.S(S), .Out(Out[2]));
mux_2_1 bit_3 (.InA(InA[3]), .InB(InB[3]),.S(S), .Out(Out[3]));
mux_2_1 bit_4 (.InA(InA[4]), .InB(InB[4]),.S(S), .Out(Out[4]));
mux_2_1 bit_5 (.InA(InA[5]), .InB(InB[5]),.S(S), .Out(Out[5]));
mux_2_1 bit_6 (.InA(InA[6]), .InB(InB[6]),.S(S), .Out(Out[6]));
mux_2_1 bit_7 (.InA(InA[7]), .InB(InB[7]),.S(S), .Out(Out[7]));
mux_2_1 bit_8 (.InA(InA[8]), .InB(InB[8]),.S(S), .Out(Out[8]));
mux_2_1 bit_9 (.InA(InA[9]), .InB(InB[9]),.S(S), .Out(Out[9]));
mux_2_1 bit_10 (.InA(InA[10]), .InB(InB[10]),.S(S), .Out(Out[10]));
mux_2_1 bit_11 (.InA(InA[11]), .InB(InB[11]),.S(S), .Out(Out[11]));
mux_2_1 bit_12 (.InA(InA[12]), .InB(InB[12]),.S(S), .Out(Out[12]));
mux_2_1 bit_13 (.InA(InA[13]), .InB(InB[13]),.S(S), .Out(Out[13]));
mux_2_1 bit_14 (.InA(InA[14]), .InB(InB[14]),.S(S), .Out(Out[14]));
mux_2_1 bit_15 (.InA(InA[15]), .InB(InB[15]),.S(S), .Out(Out[15]));

endmodule
