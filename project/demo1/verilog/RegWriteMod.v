
module RegWriteMod (OpCode, RegWrite);

input [4:0]	OpCode;
output		RegWrite;

assign RegWrite = ((OpCode == 5'b00110) | (OpCode == 5'b00111)) ? 1'b1 :
		((~OpCode[4] & ~OpCode[3]) | (OpCode == 5'b10000) | (OpCode == 5'b01100) | (OpCode == 5'b01101) | (OpCode == 5'b01110) | (OpCode == 5'b01111)) ? 1'b0 : 1'b1;

endmodule
