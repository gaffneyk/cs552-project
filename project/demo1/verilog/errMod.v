
module errMod (OpCode, Funct, err);

input [4:0]	OpCode;
input [1:0]	Funct;
output		err;

assign err = ((^OpCode === 1'bx) | (^OpCode === 1'bz) | (^Funct === 1'bx) | (^Funct === 1'bz));

endmodule
