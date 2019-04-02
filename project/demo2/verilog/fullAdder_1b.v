/*
    CS/ECE 552 Spring '19
    Homework #3, Problem 2
    
    a 1-bit full adder
*/
module fullAdder_1b(A, B, C_in, S, C_out);
    input  A, B;
    input  C_in;
    output S;
    output C_out;

    // YOUR CODE HERE
not1	notA (.in1(A),.out(A_n));
not1	notB (.in1(B),.out(B_n));
not1	notC (.in1(C_in),.out(C_n));

xor2	xorAB (.in1(A),.in2(B),.out(xor_AB));
xor2	xorAB_C (.in1(xor_AB),.in2(C_in),.out(S));

not1	notAB (.in1(xor_AB),.out(xor_AB_n));

nor2	andAB (.in1(A_n),.in2(B_n),.out(and_AB));
nor2	andXorC (.in1(C_n),.in2(xor_AB_n),.out(and_XorC));

not1	notAndAB (.in1(and_AB),.out(and_AB_n));
not1	notAndXorC (.in1(and_XorC),.out(and_XorC_n));

nand2 orOut (.in1(and_AB_n),.in2(and_XorC_n),.out(C_out));

endmodule
