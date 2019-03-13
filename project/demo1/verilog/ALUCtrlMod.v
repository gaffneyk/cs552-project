
module ALU_Ctrl (OpCode, Funct, ALU_Ctrl);

input [4:0]	OpCode;
input [1:0]	Funct;
output [3:0]	ALU_Ctrl;

assign ALU_Ctrl = ((OpCode == 5'b01000) | ((OpCode == 5'b11011) & (Funct == 2'b01))) ? 4'b0000 : 
		((OpCode == 5'b01010) | ((OpCode == 5'b11011) & (Funct == 2'b11))) ? 4'b0010 :
		((OpCode == 5'b01011) | ((OpCode == 5'b11011) & (Funct == 2'b10))) ? 4'b0011 :
		((OpCode == 5'b10100) | ((OpCode == 5'b11010) & (Funct == 2'b00))) ? 4'b0100 :
		((OpCode == 5'b10101) | ((OpCode == 5'b11010) & (Funct == 2'b01))) ? 4'b0101 :
		((OpCode == 5'b10110) | ((OpCode == 5'b11010) & (Funct == 2'b10))) ? 4'b0110 :
		((OpCode == 5'b10111) | ((OpCode == 5'b11010) & (Funct == 2'b11))) ? 4'b0111 :
		(OpCode == 5'b11001)  ? 4'b1000 :
		(OpCode == 5'b11100)  ? 4'b1001 :
		(OpCode == 5'b11101)  ? 4'b1010 :
		(OpCode == 5'b11110)  ? 4'b1011 :
		(OpCode == 5'b11111)  ? 4'b1100 :
		(OpCode == 5'b11000)  ? 4'b1101 :
		(OpCode == 5'b10010)  ? 4'b1110 : 4'b0001;

endmodule
