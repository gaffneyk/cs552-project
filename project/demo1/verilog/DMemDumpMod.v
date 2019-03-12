
module DMemDumpMod (OpCode, DMemDump);

input [4:0]	OpCode;
output		DMemDump;

assign DMemDump = ~|OpCode;

endmodule
