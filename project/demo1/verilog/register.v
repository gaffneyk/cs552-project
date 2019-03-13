module register(readData, err, clk, rst, writeData, writeEn);

	input        clk, rst;
	input [15:0] writeData;
	input        writeEn;

	output [15:0] readData;
	output        err;

	wire w_err_wd;
	wire load;

	err_ck_16b err_wd(writeData, w_err_wd);
	assign err = w_err_wd;

	assign load = clk | ~writeEn;

	dff dff0(.q(readData[0]), .d(writeData[0]), .clk(load), .rst(rst));
	dff dff1(.q(readData[1]), .d(writeData[1]), .clk(load), .rst(rst));
	dff dff2(.q(readData[2]), .d(writeData[2]), .clk(load), .rst(rst));
	dff dff3(.q(readData[3]), .d(writeData[3]), .clk(load), .rst(rst));
	dff dff4(.q(readData[4]), .d(writeData[4]), .clk(load), .rst(rst));
	dff dff5(.q(readData[5]), .d(writeData[5]), .clk(load), .rst(rst));
	dff dff6(.q(readData[6]), .d(writeData[6]), .clk(load), .rst(rst));
	dff dff7(.q(readData[7]), .d(writeData[7]), .clk(load), .rst(rst));
	dff dff8(.q(readData[8]), .d(writeData[8]), .clk(load), .rst(rst));
	dff dff9(.q(readData[9]), .d(writeData[9]), .clk(load), .rst(rst));
	dff dff10(.q(readData[10]), .d(writeData[10]), .clk(load), .rst(rst));
	dff dff11(.q(readData[11]), .d(writeData[11]), .clk(load), .rst(rst));
	dff dff12(.q(readData[12]), .d(writeData[12]), .clk(load), .rst(rst));
	dff dff13(.q(readData[13]), .d(writeData[13]), .clk(load), .rst(rst));
	dff dff14(.q(readData[14]), .d(writeData[14]), .clk(load), .rst(rst));
	dff dff15(.q(readData[15]), .d(writeData[15]), .clk(load), .rst(rst));

endmodule
