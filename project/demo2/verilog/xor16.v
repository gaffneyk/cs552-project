module xor16 (in1,in2,out);
    input [15:0] in1,in2;
    output [15:0] out;


xor2 xor_0 (.in1(in1[0]),.in2(in2[0]),.out(out[0]));
xor2 xor_1 (.in1(in1[1]),.in2(in2[1]),.out(out[1]));
xor2 xor_2 (.in1(in1[2]),.in2(in2[2]),.out(out[2]));
xor2 xor_3 (.in1(in1[3]),.in2(in2[3]),.out(out[3]));
xor2 xor_4 (.in1(in1[4]),.in2(in2[4]),.out(out[4]));
xor2 xor_5 (.in1(in1[5]),.in2(in2[5]),.out(out[5]));
xor2 xor_6 (.in1(in1[6]),.in2(in2[6]),.out(out[6]));
xor2 xor_7 (.in1(in1[7]),.in2(in2[7]),.out(out[7]));
xor2 xor_8 (.in1(in1[8]),.in2(in2[8]),.out(out[8]));
xor2 xor_9 (.in1(in1[9]),.in2(in2[9]),.out(out[9]));
xor2 xor_10 (.in1(in1[10]),.in2(in2[10]),.out(out[10]));
xor2 xor_11 (.in1(in1[11]),.in2(in2[11]),.out(out[11]));
xor2 xor_12 (.in1(in1[12]),.in2(in2[12]),.out(out[12]));
xor2 xor_13 (.in1(in1[13]),.in2(in2[13]),.out(out[13]));
xor2 xor_14 (.in1(in1[14]),.in2(in2[14]),.out(out[14]));
xor2 xor_15 (.in1(in1[15]),.in2(in2[15]),.out(out[15]));

endmodule

