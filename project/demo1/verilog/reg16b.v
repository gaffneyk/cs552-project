
module reg16b (writeEn, writeData, clk, rst, dataOut);

	input 		writeEn, clk, rst;
	input [15:0]	writeData;
	output [15:0]	dataOut;

	wire [15:0]	muxOut;

mux2_1 bit_0 (.InA(dataOut[0]), .InB(writeData[0]),.S(writeEn), .Out(muxOut[0]));
mux2_1 bit_1 (.InA(dataOut[1]), .InB(writeData[1]),.S(writeEn), .Out(muxOut[1]));
mux2_1 bit_2 (.InA(dataOut[2]), .InB(writeData[2]),.S(writeEn), .Out(muxOut[2]));
mux2_1 bit_3 (.InA(dataOut[3]), .InB(writeData[3]),.S(writeEn), .Out(muxOut[3]));
mux2_1 bit_4 (.InA(dataOut[4]), .InB(writeData[4]),.S(writeEn), .Out(muxOut[4]));
mux2_1 bit_5 (.InA(dataOut[5]), .InB(writeData[5]),.S(writeEn), .Out(muxOut[5]));
mux2_1 bit_6 (.InA(dataOut[6]), .InB(writeData[6]),.S(writeEn), .Out(muxOut[6]));
mux2_1 bit_7 (.InA(dataOut[7]), .InB(writeData[7]),.S(writeEn), .Out(muxOut[7]));
mux2_1 bit_8 (.InA(dataOut[8]), .InB(writeData[8]),.S(writeEn), .Out(muxOut[8]));
mux2_1 bit_9 (.InA(dataOut[9]), .InB(writeData[9]),.S(writeEn), .Out(muxOut[9]));
mux2_1 bit_10 (.InA(dataOut[10]), .InB(writeData[10]),.S(writeEn), .Out(muxOut[10]));
mux2_1 bit_11 (.InA(dataOut[11]), .InB(writeData[11]),.S(writeEn), .Out(muxOut[11]));
mux2_1 bit_12 (.InA(dataOut[12]), .InB(writeData[12]),.S(writeEn), .Out(muxOut[12]));
mux2_1 bit_13 (.InA(dataOut[13]), .InB(writeData[13]),.S(writeEn), .Out(muxOut[13]));
mux2_1 bit_14 (.InA(dataOut[14]), .InB(writeData[14]),.S(writeEn), .Out(muxOut[14]));
mux2_1 bit_15 (.InA(dataOut[15]), .InB(writeData[15]),.S(writeEn), .Out(muxOut[15]));

dff dff0 (.q(dataOut[0]), .d(muxOut[0]), .clk(clk), .rst(rst));
dff dff1 (.q(dataOut[1]), .d(muxOut[1]), .clk(clk), .rst(rst));
dff dff2 (.q(dataOut[2]), .d(muxOut[2]), .clk(clk), .rst(rst));
dff dff3 (.q(dataOut[3]), .d(muxOut[3]), .clk(clk), .rst(rst));
dff dff4 (.q(dataOut[4]), .d(muxOut[4]), .clk(clk), .rst(rst));
dff dff5 (.q(dataOut[5]), .d(muxOut[5]), .clk(clk), .rst(rst));
dff dff6 (.q(dataOut[6]), .d(muxOut[6]), .clk(clk), .rst(rst));
dff dff7 (.q(dataOut[7]), .d(muxOut[7]), .clk(clk), .rst(rst));
dff dff8 (.q(dataOut[8]), .d(muxOut[8]), .clk(clk), .rst(rst));
dff dff9 (.q(dataOut[9]), .d(muxOut[9]), .clk(clk), .rst(rst));
dff dff10 (.q(dataOut[10]), .d(muxOut[10]), .clk(clk), .rst(rst));
dff dff11 (.q(dataOut[11]), .d(muxOut[11]), .clk(clk), .rst(rst));
dff dff12 (.q(dataOut[12]), .d(muxOut[12]), .clk(clk), .rst(rst));
dff dff13 (.q(dataOut[13]), .d(muxOut[13]), .clk(clk), .rst(rst));
dff dff14 (.q(dataOut[14]), .d(muxOut[14]), .clk(clk), .rst(rst));
dff dff15 (.q(dataOut[15]), .d(muxOut[15]), .clk(clk), .rst(rst));



endmodule
