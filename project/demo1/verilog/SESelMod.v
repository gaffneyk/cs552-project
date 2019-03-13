
module SESelMod (OpCode, SESel);

input [4:0]	OpCode;
output [2:0]	SESel;

assign SESel[0] = ~OpCode[3];
assign SESel[1] = ((OpCode[3] & (OpCode[4] | OpCode[2] | OpCode[1])) | (OpCode[2] & OpCode[0]) | (OpCode == 5'b10010)) ? 1'b0 : 1'b1;
assign SESel[2] = ((~OpCode[4] & OpCode[3] & ~OpCode[2]) | (OpCode[4] & ~OpCode[3] & ~OpCode[2])) ? 1'b0 : 1'b1;

endmodule
