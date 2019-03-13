
module alu(InA, InB, Op, Out, MSB, Zero);

  input [15:0] InA;
  input [15:0] InB;
  input [3:0]  Op;

  output [15:0] Out;
  output MSB;
  output Zero;

  wire [15:0] w_sub;
  wire [15:0] w_add;
  wire [15:0] w_and_n;
  wire [15:0] w_xor;
  wire [15:0] w_rol;
  wire [15:0] w_sll;
  wire [15:0] w_ror;
  wire [15:0] w_srl;
  wire [15:0] w_btr;
  wire [15:0] w_seq;
  wire [15:0] w_slt;
  wire [15:0] w_sle;
  wire [15:0] w_sco;
  wire [15:0] w_pass;
  wire [15:0] w_rolori;
  wire w_cout;

  // 0000 Subtraction
  subtract sub(.InA(InA), .InB(InB), .Out(w_sub));

  // 0001 Addition
  rca_16b rca_add(.A(InA), .B(InB), .C_in(1'b0), .S(w_add), .C_out(w_cout));

  // 0010 AND NOT
  assign w_and_n = InA & ~InB;

  // 0011 XOR
  assign w_xor = InA ^ InB;

  // 0100 Rotate left
  barrelShifter bs_rol(.In(InA), .Cnt(InB[3:0]), .Op(2'b00), .Out(w_rol));

  // 0101 Shift left logical
  barrelShifter bs_sll(.In(InA), .Cnt(InB[3:0]), .Op(2'b01), .Out(w_sll));

  // 0110 Rotate right
  barrelShifter bs_ror(.In(InA), .Cnt(InB[3:0]), .Op(2'b10), .Out(w_ror));

  // 0111 Shift right logical
  barrelShifter bs_srl(.In(InA), .Cnt(InB[3:0]), .Op(2'b11), .Out(w_srl));

  // 1000 Bit reverse
  assign w_btr[15] = InA[0];
  assign w_btr[14] = InA[1];
  assign w_btr[13] = InA[2];
  assign w_btr[12] = InA[3];
  assign w_btr[11] = InA[4];
  assign w_btr[10] = InA[5];
  assign w_btr[9] = InA[6];
  assign w_btr[8] = InA[7];
  assign w_btr[7] = InA[8];
  assign w_btr[6] = InA[9];
  assign w_btr[5] = InA[10];
  assign w_btr[4] = InA[11];
  assign w_btr[3] = InA[12];
  assign w_btr[2] = InA[13];
  assign w_btr[1] = InA[14];
  assign w_btr[0] = InA[15];

  // 1001 Set if equal
  assign w_seq = ~|w_sub;

  // 1010 Set if less than
  assign w_slt = ((InA[15] ~^ InB[15]) & w_sub[15]) | (InA[15] & ~InB[15]);

  // 1011 Set if less than or equal
  assign w_sle = w_slt | w_seq;

  // 1100 Set if generates carry out
  assign w_sco = {15'b0, w_cout};

  // 1101 Passthrough
  assign w_pass = InB;

  // 1110, 1111 Shift left 8 bits or immediate
  wire [15:0] w_rol_8b;
  barrelShifter bs_rol_8b(.In(InA), .Cnt(4'b1000), .Op(2'b01), .Out(w_rol_8b));
  assign w_rolori = w_rol_8b | InB;

  // Final mux
  mux16_1_16b mux(
    .In0(w_sub),
    .In1(w_add),
    .In2(w_and_n),
    .In3(w_xor),
    .In4(w_rol),
    .In5(w_sll),
    .In6(w_ror),
    .In7(w_srl),
    .In8(w_btr),
    .In9(w_seq),
    .In10(w_slt),
    .In11(w_sle),
    .In12(w_sco),
    .In13(w_pass),
    .In14(w_rolori),
    .In15(w_rolori),
    .S(Op),
    .Out(Out));

  // MSB
  assign MSB = InA[15];

  // Zero
  assign Zero = ~|InA;


endmodule
