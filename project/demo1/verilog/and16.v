
module and16 (in1,in2,out);
    input [15:0] in1,in2;
    output [15:0] out;

not1 not1_0 (.in1(in1[0]),.out(n1_0_n));
not1 not1_1 (.in1(in1[1]),.out(n1_1_n));
not1 not1_2 (.in1(in1[2]),.out(n1_2_n));
not1 not1_3 (.in1(in1[3]),.out(n1_3_n));
not1 not1_4 (.in1(in1[4]),.out(n1_4_n));
not1 not1_5 (.in1(in1[5]),.out(n1_5_n));
not1 not1_6 (.in1(in1[6]),.out(n1_6_n));
not1 not1_7 (.in1(in1[7]),.out(n1_7_n));
not1 not1_8 (.in1(in1[8]),.out(n1_8_n));
not1 not1_9 (.in1(in1[9]),.out(n1_9_n));
not1 not1_10 (.in1(in1[10]),.out(n1_10_n));
not1 not1_11 (.in1(in1[11]),.out(n1_11_n));
not1 not1_12 (.in1(in1[12]),.out(n1_12_n));
not1 not1_13 (.in1(in1[13]),.out(n1_13_n));
not1 not1_14 (.in1(in1[14]),.out(n1_14_n));
not1 not1_15 (.in1(in1[15]),.out(n1_15_n));
not1 not2_0 (.in1(in2[0]),.out(n2_0_n));
not1 not2_1 (.in1(in2[1]),.out(n2_1_n));
not1 not2_2 (.in1(in2[2]),.out(n2_2_n));
not1 not2_3 (.in1(in2[3]),.out(n2_3_n));
not1 not2_4 (.in1(in2[4]),.out(n2_4_n));
not1 not2_5 (.in1(in2[5]),.out(n2_5_n));
not1 not2_6 (.in1(in2[6]),.out(n2_6_n));
not1 not2_7 (.in1(in2[7]),.out(n2_7_n));
not1 not2_8 (.in1(in2[8]),.out(n2_8_n));
not1 not2_9 (.in1(in2[9]),.out(n2_9_n));
not1 not2_10 (.in1(in2[10]),.out(n2_10_n));
not1 not2_11 (.in1(in2[11]),.out(n2_11_n));
not1 not2_12 (.in1(in2[12]),.out(n2_12_n));
not1 not2_13 (.in1(in2[13]),.out(n2_13_n));
not1 not2_14 (.in1(in2[14]),.out(n2_14_n));
not1 not2_15 (.in1(in2[15]),.out(n2_15_n));

nor2 nor0 (.in1(n1_0_n),.in2(n2_0_n),.out(out[0]));
nor2 nor1 (.in1(n1_1_n),.in2(n2_1_n),.out(out[1]));
nor2 nor2 (.in1(n1_2_n),.in2(n2_2_n),.out(out[2]));
nor2 nor3 (.in1(n1_3_n),.in2(n2_3_n),.out(out[3]));
nor2 nor4 (.in1(n1_4_n),.in2(n2_4_n),.out(out[4]));
nor2 nor5 (.in1(n1_5_n),.in2(n2_5_n),.out(out[5]));
nor2 nor6 (.in1(n1_6_n),.in2(n2_6_n),.out(out[6]));
nor2 nor7 (.in1(n1_7_n),.in2(n2_7_n),.out(out[7]));
nor2 nor8 (.in1(n1_8_n),.in2(n2_8_n),.out(out[8]));
nor2 nor9 (.in1(n1_9_n),.in2(n2_9_n),.out(out[9]));
nor2 nor10 (.in1(n1_10_n),.in2(n2_10_n),.out(out[10]));
nor2 nor11 (.in1(n1_11_n),.in2(n2_11_n),.out(out[11]));
nor2 nor12 (.in1(n1_12_n),.in2(n2_12_n),.out(out[12]));
nor2 nor13 (.in1(n1_13_n),.in2(n2_13_n),.out(out[13]));
nor2 nor14 (.in1(n1_14_n),.in2(n2_14_n),.out(out[14]));
nor2 nor15 (.in1(n1_15_n),.in2(n2_15_n),.out(out[15]));

endmodule