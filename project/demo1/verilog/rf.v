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
   wire [7:0] w_decoder;
   decoder_8_1 decoder(writeRegSel, w_decoder);

   wire [7:0] reg_write_en;
   assign reg_write_en = w_decoder & {8{writeEn}};

   wire [15:0] reg_read_data [7:0];
   wire [8:0] reg_err;

   wire [15:0] reg_inter;
   register reg_write(
    .readData(reg_inter),
    .err(reg_err[8]),
    .clk(clk), .rst(rst),
    .writeData(writeData),
    .writeEn(1'b1));

   register register_0(
    .readData(reg_read_data[0]),
    .err(reg_err[0]),
    .clk(clk), .rst(rst),
    .writeData(reg_inter),
    .writeEn(reg_write_en[0]));

   register register_1(
    .readData(reg_read_data[1]),
    .err(reg_err[1]),
    .clk(clk), .rst(rst),
    .writeData(reg_inter),
    .writeEn(reg_write_en[1]));

   register register_2(
    .readData(reg_read_data[2]),
    .err(reg_err[2]),
    .clk(clk), .rst(rst),
    .writeData(reg_inter),
    .writeEn(reg_write_en[2]));

   register register_3(
    .readData(reg_read_data[3]),
    .err(reg_err[3]),
    .clk(clk), .rst(rst),
    .writeData(reg_inter),
    .writeEn(reg_write_en[3]));

   register register_4(
    .readData(reg_read_data[4]),
    .err(reg_err[4]),
    .clk(clk), .rst(rst),
    .writeData(reg_inter),
    .writeEn(reg_write_en[4]));

   register register_5(
    .readData(reg_read_data[5]),
    .err(reg_err[5]),
    .clk(clk), .rst(rst),
    .writeData(reg_inter),
    .writeEn(reg_write_en[5]));

   register register_6(
    .readData(reg_read_data[6]),
    .err(reg_err[6]),
    .clk(clk), .rst(rst),
    .writeData(reg_inter),
    .writeEn(reg_write_en[6]));

   register register_7(
    .readData(reg_read_data[7]),
    .err(reg_err[7]),
    .clk(clk), .rst(rst),
    .writeData(reg_inter),
    .writeEn(reg_write_en[7]));

   mux_8_1_16b mux1(
    reg_read_data[0],
    reg_read_data[1],
    reg_read_data[2],
    reg_read_data[3],
    reg_read_data[4],
    reg_read_data[5],
    reg_read_data[6],
    reg_read_data[7],
    readReg1Sel,
    readData1);

   mux_8_1_16b mux2(
    reg_read_data[0],
    reg_read_data[1],
    reg_read_data[2],
    reg_read_data[3],
    reg_read_data[4],
    reg_read_data[5],
    reg_read_data[6],
    reg_read_data[7],
    readReg2Sel,
    readData2);

   wire w_err_w;
   wire w_err_r1;
   wire w_err_r2;
   err_ck_3b err_ck_w(writeRegSel, w_err_w);
   err_ck_3b err_ck_r1(readReg1Sel, w_err_r1);
   err_ck_3b err_ck_r2(readReg2Sel, w_err_r2);

   assign err = |reg_err | w_err_w | w_err_r1 | w_err_r2;

endmodule
