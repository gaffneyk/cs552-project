/*
   CS/ECE 552, Spring '19
   Homework #5, Problem #1
  
   This module creates a 16-bit register.  It has 1 write port, 2 read
   ports, 3 register select inputs, a write enable, a reset, and a clock
   input.  All register state changes occur on the rising edge of the
   clock. 
*/
module rf (
           // Outputs
           readData1, readData2, err,
           // Inputs
           clk, rst, readReg1Sel, readReg2Sel, writeRegSel, writeData, writeEn
           );
   
   input        clk, rst;
   input [2:0]  readReg1Sel;
   input [2:0]  readReg2Sel;
   input [2:0]  writeRegSel;
   input [15:0] writeData;
   input        writeEn;

   output [15:0] readData1;
   output [15:0] readData2;
   output        err;

   /* YOUR CODE HERE */
wire [15:0]	read_0,
		read_1,
		read_2,
		read_3,
		read_4,
		read_5,
		read_6,
		read_7;

reg16b reg0 (.writeEn((writeRegSel == 3'h0) & writeEn), .writeData(writeData), .clk(clk), .rst(rst), .dataOut(read_0));
reg16b reg1 (.writeEn((writeRegSel == 3'h1) & writeEn), .writeData(writeData), .clk(clk), .rst(rst), .dataOut(read_1));
reg16b reg2 (.writeEn((writeRegSel == 3'h2) & writeEn), .writeData(writeData), .clk(clk), .rst(rst), .dataOut(read_2));
reg16b reg3 (.writeEn((writeRegSel == 3'h3) & writeEn), .writeData(writeData), .clk(clk), .rst(rst), .dataOut(read_3));
reg16b reg4 (.writeEn((writeRegSel == 3'h4) & writeEn), .writeData(writeData), .clk(clk), .rst(rst), .dataOut(read_4));
reg16b reg5 (.writeEn((writeRegSel == 3'h5) & writeEn), .writeData(writeData), .clk(clk), .rst(rst), .dataOut(read_5));
reg16b reg6 (.writeEn((writeRegSel == 3'h6) & writeEn), .writeData(writeData), .clk(clk), .rst(rst), .dataOut(read_6));
reg16b reg7 (.writeEn((writeRegSel == 3'h7) & writeEn), .writeData(writeData), .clk(clk), .rst(rst), .dataOut(read_7));


assign readData1 = (readReg1Sel == 3'h0) ? read_0
	  : (readReg1Sel == 3'h1) ? read_1
	  : (readReg1Sel == 3'h2) ? read_2
	  : (readReg1Sel == 3'h3) ? read_3
	  : (readReg1Sel == 3'h4) ? read_4
	  : (readReg1Sel == 3'h5) ? read_5
	  : (readReg1Sel == 3'h6) ? read_6
	  : read_7;

assign readData2 = (readReg2Sel == 3'h0) ? read_0
	  : (readReg2Sel == 3'h1) ? read_1
	  : (readReg2Sel == 3'h2) ? read_2
	  : (readReg2Sel == 3'h3) ? read_3
	  : (readReg2Sel == 3'h4) ? read_4
	  : (readReg2Sel == 3'h5) ? read_5
	  : (readReg2Sel == 3'h6) ? read_6
	  : read_7;

assign err = 0;

endmodule
