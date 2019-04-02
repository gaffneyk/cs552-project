
module errMod (OpCode, Funct, rst, err);

input [4:0]	OpCode;
input [1:0]	Funct;
input rst;
output		err;

assign err = ((^OpCode === 1'bx) | (^OpCode === 1'bz) | (^Funct === 1'bx) | (^Funct === 1'bz)) & ~rst;

endmodule
