
module MemToRegMod (OpCode, MemToReg);

input [4:0]	OpCode;
output		MemToReg;

assign MemToReg = (OpCode == 5'b10001) ? 1'b1 : 1'b0;

endmodule
