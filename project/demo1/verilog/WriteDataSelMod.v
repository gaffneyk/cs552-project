
module WriteDataSelMod (OpCode, WriteDataSel);

input [4:0]	OpCode;
output		WriteDataSel;

assign WriteDataSel = ((OpCode == 5'b00110) | (OpCode == 5'b00111)) ? 1'b1 : 1'b0;

endmodule
