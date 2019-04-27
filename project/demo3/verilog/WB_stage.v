
module WB_stage (
		//outputs
		writeData,
		//inputs
		PCAdd2, WriteDataSel, ALU_Out, DMemData, MemToReg
		);

	input		WriteDataSel, MemToReg;
	input [15:0]	PCAdd2, ALU_Out, DMemData;

	output [15:0]	writeData;

	wire [15:0]	MemToRegOut;


	mux2_1_16b MuxMemtoReg (.InA(ALU_Out), .InB(DMemData), .S(MemToReg), .Out(MemToRegOut));
	mux2_1_16b MuxWriteData (.InA(MemToRegOut), .InB(PCAdd2), .S(WriteDataSel), .Out(writeData));
	


endmodule
