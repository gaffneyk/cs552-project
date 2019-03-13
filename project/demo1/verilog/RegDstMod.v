
module RegDstMod (OpCode, RegDst);

input [4:0]	OpCode;
output [1:0]	RegDst;

assign	RegDst = ((OpCode == 5'b11000) | (OpCode == 5'b10010)) ? 2'b10 :
	(OpCode[4] ^ OpCode[3]) ? 2'b01 :
	(OpCode[4] & OpCode[3]) ? 2'b00 : 2'b11;

endmodule
