/*
    CS/ECE 552 Spring '19
    Homework #4, Problem 1
    
    A barrel shifter module.  It is designed to shift a number via rotate
    left, shift left, shift right arithmetic, or shift right logical based
    on the Op() value that is passed in (2 bit number).  It uses these
    shifts to shift the value any number of bits between 0 and 15 bits.
 */
module barrelShifter (In, Cnt, Op, Out);

   // declare constant for size of inputs, outputs (N) and # bits to shift (C)
   parameter   N = 16;
   parameter   C = 4;
   parameter   O = 2;

   input [N-1:0]   In;
   input [C-1:0]   Cnt;
   input [O-1:0]   Op;
   output [N-1:0]  Out;

   /* YOUR CODE HERE */

	wire [15:0] InRotL, InShL, InShRa, InShRl, RotL, ShL, ShRa, ShRl;
	assign InRotL = {In[14:0], In[15]};
	assign InShL = {In[14:0], 1'b0};
	assign InShRa = {In[15], In[15:1]};
	assign InShRl = {1'b0, In[15:1]};

// Rotate Left
	wire [15:0] RotL_0, RotL_1, RotL_2, RotL_0_Alt, RotL_1_Alt, RotL_2_Alt;
mux2_1_16b muxRot0 (.InA(In), .InB(InRotL), .S(Cnt[0]), .Out(RotL_0));
	assign RotL_0_Alt = {RotL_0[13:0], RotL_0[15:14]};
mux2_1_16b muxRot1 (.InA(RotL_0), .InB(RotL_0_Alt), .S(Cnt[1]), .Out(RotL_1));
	assign RotL_1_Alt = {RotL_1[11:0], RotL_1[15:12]};
mux2_1_16b muxRot2 (.InA(RotL_1), .InB(RotL_1_Alt), .S(Cnt[2]), .Out(RotL_2));
	assign RotL_2_Alt = {RotL_2[7:0], RotL_2[15:8]};
mux2_1_16b muxRot3 (.InA(RotL_2), .InB(RotL_2_Alt), .S(Cnt[3]), .Out(RotL));

// Shift Left
	wire [15:0] ShL_0, ShL_1, ShL_2, ShL_0_Alt, ShL_1_Alt, ShL_2_Alt;
mux2_1_16b muxSh0 (.InA(In), .InB(InShL), .S(Cnt[0]), .Out(ShL_0));
	assign ShL_0_Alt = {ShL_0[13:0], 2'b0};
mux2_1_16b muxSh1 (.InA(ShL_0), .InB(ShL_0_Alt), .S(Cnt[1]), .Out(ShL_1));
	assign ShL_1_Alt = {ShL_1[11:0], 4'b0};
mux2_1_16b muxSh2 (.InA(ShL_1), .InB(ShL_1_Alt), .S(Cnt[2]), .Out(ShL_2));
	assign ShL_2_Alt = {ShL_2[7:0], 8'b0};
mux2_1_16b muxSh3 (.InA(ShL_2), .InB(ShL_2_Alt), .S(Cnt[3]), .Out(ShL));


// Shift right arithmetic
	wire [15:0] ShRa_0, ShRa_1, ShRa_2, ShRa_0_Alt, ShRa_1_Alt, ShRa_2_Alt;
mux2_1_16b muxShRa0 (.InA(In), .InB(InShRa), .S(Cnt[0]), .Out(ShRa_0));
	assign ShRa_0_Alt = {{2{ShRa_0[15]}}, ShRa_0[15:2]};
mux2_1_16b muxShRa1 (.InA(ShRa_0), .InB(ShRa_0_Alt), .S(Cnt[1]), .Out(ShRa_1));
	assign ShRa_1_Alt = {{4{ShRa_1[15]}}, ShRa_1[15:4]};
mux2_1_16b muxShRa2 (.InA(ShRa_1), .InB(ShRa_1_Alt), .S(Cnt[2]), .Out(ShRa_2));
	assign ShRa_2_Alt = {{8{ShRa_2[15]}}, ShRa_2[15:8]};
mux2_1_16b muxShRa3 (.InA(ShRa_2), .InB(ShRa_2_Alt), .S(Cnt[3]), .Out(ShRa));


// Shift right logical
	wire [15:0] ShRl_0, ShRl_1, ShRl_2, ShRl_0_Alt, ShRl_1_Alt, ShRl_2_Alt;
mux2_1_16b muxShRl0 (.InA(In), .InB(InShRl), .S(Cnt[0]), .Out(ShRl_0));
	assign ShRl_0_Alt = {2'b0, ShRl_0[15:2]};
mux2_1_16b muxShRl1 (.InA(ShRl_0), .InB(ShRl_0_Alt), .S(Cnt[1]), .Out(ShRl_1));
	assign ShRl_1_Alt = {4'b0, ShRl_1[15:4]};
mux2_1_16b muxShRl2 (.InA(ShRl_1), .InB(ShRl_1_Alt), .S(Cnt[2]), .Out(ShRl_2));
	assign ShRl_2_Alt = {8'b0, ShRl_2[15:8]};
mux2_1_16b muxShRl3 (.InA(ShRl_2), .InB(ShRl_2_Alt), .S(Cnt[3]), .Out(ShRl));

// Select   
mux4_1_16b muxSel (.InA(RotL), .InB(ShL), .InC(ShRa), .InD(ShRl), .S(Op), .Out(Out));

endmodule
