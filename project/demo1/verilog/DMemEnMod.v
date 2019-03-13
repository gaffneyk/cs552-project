
module DMemEnMod (OpCode, DMemEn);

input [4:0]	OpCode;
output		DMemEn;

assign DMemEn = ((OpCode == 5'b10000) | (OpCode == 5'b10001) | (OpCode == 5'b10011)) ? 1'b1 : 1'b0;

endmodule
