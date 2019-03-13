/*
   CS/ECE 552, Spring '19
   Homework #5, Problem #2
  
   This module creates a wrapper around the 8x16b register file, to do
   do the bypassing logic for RF bypassing.
*/
module rf_bypass (
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

   wire [15:0] rf_readData1;
   wire [15:0] rf_readData2;

   rf rf0(
          // Outputs
          .readData1                    (rf_readData1[15:0]),
          .readData2                    (rf_readData2[15:0]),
          .err                          (err),
          // Inputs
          .clk                          (clk),
          .rst                          (rst),
          .readReg1Sel                  (readReg1Sel[2:0]),
          .readReg2Sel                  (readReg2Sel[2:0]),
          .writeRegSel                  (writeRegSel[2:0]),
          .writeData                    (writeData[15:0]),
          .writeEn                      (writeEn));

   wire s1;
   wire s2;

   assign s1 = (&(writeRegSel ~^ readReg1Sel) & writeEn);
   assign s2 = (&(writeRegSel ~^ readReg2Sel) & writeEn);

   mux_2_1_16b m1(rf_readData1, writeData, s1, readData1);
   mux_2_1_16b m2(rf_readData2, writeData, s2, readData2);

endmodule
