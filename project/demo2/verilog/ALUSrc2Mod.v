
module ALUSrc2Mod (OpCode, ALUSrc2);

input [4:0]	OpCode;
output		ALUSrc2;

assign ALUSrc2 = (OpCode == 5'b11000) ? 1'b0 :
	(OpCode[4] & OpCode[3]) ? 1'b1 : 1'b0;

endmodule
