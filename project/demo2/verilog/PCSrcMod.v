
module PCSrcMod (OpCode, PCSrc);

input [4:0]	OpCode;
output		PCSrc;

assign PCSrc = ((~OpCode[4] & OpCode[2]) | (OpCode == 5'b00011)) ? 1'b1 : 1'b0;

endmodule
