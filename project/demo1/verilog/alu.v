/*
    CS/ECE 552 Spring '19
    Homework #4, Problem 2

    A 16-bit ALU module.  It is designed to choose
    the correct operation to perform on 2 16-bit numbers from rotate
    left, shift left, shift right arithmetic, shift right logical, add,
    or, xor, & and.  Upon doing this, it should output the 16-bit result
    of the operation, as well as output a Zero bit and an Overflow
    (OFL) bit.
*/
module alu (A, B, Cin, Op, invA, invB, sign, Out, Zero, Ofl);

   // declare constant for size of inputs, outputs (N),
   // and operations (O)
   parameter    N = 16;
   parameter    O = 3;
   
   input [N-1:0] A;
   input [N-1:0] B;
   input         Cin;
   input [O-1:0] Op;
   input         invA;
   input         invB;
   input         sign;
   output [N-1:0] Out;
   output         Ofl;
   output         Zero;

   /* YOUR CODE HERE */

wire [N-1:0] Amux, Bmux, A_n, B_n, shift_out, RCA_out, and_out, or_out, xor_out, other_out;
wire C_out, Op1_n, Op0_n;

assign A_n = ~A;
assign B_n = ~B;

mux2_1_16b Anot (.InA(A), .InB(A_n), .S(invA), .Out(Amux));
mux2_1_16b Bnot (.InA(B), .InB(B_n), .S(invB), .Out(Bmux));


barrelShifter shifter (.In(Amux), .Cnt(Bmux[3:0]), .Op(Op[1:0]), .Out(shift_out));


rca_16b RCA (.A(Amux), .B(Bmux), .C_in(Cin), .S(RCA_out), .C_out(C_out));

xor2 Ofl_xor(.in1(RCA.RCA12_15.C_2),.in2(C_out),.out(xOfl_out));
not1 Op0n (.in1(Op[0]) ,.out(Op0_n));
not1 Op1n (.in1(Op[1]) ,.out(Op1_n));

assign Ofl = ((xOfl_out & Op[2] & Op0_n & Op1_n & sign) | (C_out & Op[2] & Op0_n & Op1_n & ~(sign)));


//and16 AND_16 (.in1(Amux),.in2(Bmux),.out(and_out));
//or16 OR_16 (.in1(Amux),.in2(Bmux),.out(or_out));
//xor16 XOR_16 (.in1(Amux),.in2(Bmux),.out(xor_out));

assign and_out = (Amux & Bmux);
assign or_out = (Amux | Bmux);
assign xor_out = (Amux ^ Bmux);

mux4_1_16b mux_others (.InA(RCA_out), .InB(and_out), .InC(or_out), .InD(xor_out), .S(Op[1:0]), .Out(other_out));

mux2_1_16b mux_final (.InA(shift_out), .InB(other_out), .S(Op[2]), .Out(Out));

assign Zero = ~(|Out);


endmodule
