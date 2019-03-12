/*
    CS/ECE 552 Spring '19
    Homework #3, Problem 1

    2-1 mux template
*/
module mux2_1(InA, InB, S, Out);
    input   InA, InB;
    input   S;
    output  Out;

    // YOUR CODE HERE
not1	not_A (.in1(InA), .out(InA_n));
not1	not_B (.in1(InB), .out(InB_n));
not1	not_S (.in1(S), .out(S_n));

nor2 And_A (.in1(InA_n), .in2(S), .out(And_AS));
nor2 And_B (.in1(InB_n), .in2(S_n), .out(And_BS));

not1	And_A_n (.in1(And_AS), .out(And_AS_n));
not1	And_B_n (.in1(And_BS), .out(And_BS_n));

nand2	OrGate (.in1(And_AS_n), .in2(And_BS_n), .out(Or_Out));

assign Out = Or_Out;

endmodule
