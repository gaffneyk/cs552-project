
module JumpMod (OpCode, Jump);

input [4:0]	OpCode;
output		Jump;

assign Jump = ((OpCode == 5'b00101) | (OpCode == 5'b00111)) ? 1'b1 : 1'b0;

endmodule
