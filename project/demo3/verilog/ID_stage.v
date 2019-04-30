
module ID_stage (
		//outputs
		Halt_n, writeRegSelOut, readData1, readData2, ImmExt, hazard_f, 
		ALUCtrl, PCImm, PCSrc, Jump, OpCode1_0, DMemEn, DMemWrite, DMemDump, 
		MemToReg, WriteDataSel, RegWriteOut, ALUSrc2, rs, rt,
		//inputs
		Inst, clk, rst, writeRegSelIn, writeData, RegWriteIn, 
		writeRegSel_ID_EX, writeRegSel_EX_MEM, writeRegSel_MEM_WB, 
		RegWrite_ID_EX, RegWrite_EX_MEM, RegWrite_MEM_WB
		);

	input		clk, rst, RegWriteIn, RegWrite_ID_EX, RegWrite_EX_MEM, RegWrite_MEM_WB;
	input [2:0]	writeRegSelIn, writeRegSel_ID_EX, writeRegSel_EX_MEM, writeRegSel_MEM_WB;
	input [15:0]	Inst, writeData;

	output		Halt_n, hazard_f, PCImm, PCSrc, Jump, DMemEn, DMemWrite, DMemDump, MemToReg, WriteDataSel, RegWriteOut, ALUSrc2;
	output [1:0]	OpCode1_0;
	output [2:0]	writeRegSelOut;
	output [2:0] rs, rt;
	output [3:0] 	ALUCtrl;
	output [15:0]	readData1, readData2, ImmExt;
	
	wire	 RegWriteH, DMemWriteH, DMemEnH, PCSrcH, DMemDumpH, PCImmH, JumpH;
	wire [1:0] RegDst;
	wire [2:0]	SESel, Reg1Sel, Reg2Sel;
	wire [15:0]	Inst, ZEx5bOut, ZEx8bOut, SEx5bOut, SEx8bOut, SEx11bOut;

	
	control Ctrl(// Outputs
                .err(CtrlErr), .RegDst(RegDst), .SESel(SESel), .RegWrite(RegWriteH), .DMemWrite(DMemWriteH), .DMemEn(DMemEnH), .ALUSrc2(ALUSrc2), .PCSrc(PCSrcH), .PCImm(PCImmH), 
		.MemToReg(MemToReg), .DMemDump(DMemDumpH), .Jump(JumpH), .OpCode1_0(OpCode1_0), .WriteDataSel(WriteDataSel), .Halt_n(Halt_n), .ALUCtrl(ALUCtrl),
             	     // Inputs
                .OpCode(Inst[15:11]), .Funct(Inst[1:0]), .rst(rst));

	rf_bypass RegisterFiles (// Outputs
           	     .readData1(readData1), .readData2(readData2), .err(RFErr),
           	  	  // Inputs
           	     .clk(clk), .rst(rst), .readReg1Sel(Inst[10:8]), .readReg2Sel(Inst[7:5]), .writeRegSel(writeRegSelIn), .writeData(writeData), .writeEn(RegWriteIn));

	// mux to write register
	mux4_1_3b MuxWriteReg (.InA(Inst[4:2]), .InB(Inst[7:5]), .InC(Inst[10:8]), .InD(3'b111), .S(RegDst), .Out(writeRegSelOut));
	
	//sign extending and mux
	zero_extend_5b ZEx5b (.in(Inst[4:0]), .out(ZEx5bOut));
	zero_extend_8b ZEx8b (.in(Inst[7:0]), .out(ZEx8bOut));
	sign_extend_5b SEx5b (.in(Inst[4:0]), .out(SEx5bOut));
	sign_extend_8b SEx8b (.in(Inst[7:0]), .out(SEx8bOut));
	sign_extend_11b SEx11b (.in(Inst[10:0]), .out(SEx11bOut));
	mux8_1_16b MuxExtend (.In0(ZEx5bOut), .In1(ZEx8bOut), .In2(SEx5bOut), .In3(SEx5bOut), .In4(SEx8bOut), .In5(SEx8bOut), .In6(SEx11bOut), .In7(SEx11bOut), .S(SESel), .Out(ImmExt));

	//Hazard Detection
	assign	Reg1Sel = Inst[10:8];
	assign	Reg2Sel = Inst[7:5];

	// assign	hazard_f = (((Reg1Sel === writeRegSel_ID_EX) & RegWrite_ID_EX) ? 1'b1 :
	// 		((Reg1Sel === writeRegSel_EX_MEM) & RegWrite_EX_MEM) ? 1'b1 :
	// 		((Reg1Sel === writeRegSel_MEM_WB) & RegWrite_MEM_WB) ? 1'b1 :
	// 		((Reg2Sel === writeRegSel_ID_EX) & RegWrite_ID_EX) ? 1'b1 :
	// 		((Reg2Sel === writeRegSel_EX_MEM) & RegWrite_EX_MEM) ? 1'b1 :
	// 		((Reg2Sel === writeRegSel_MEM_WB) & RegWrite_MEM_WB) ? 1'b1 : 1'b0)
	// 		& ~rst;

	assign hazard_f = 1'b0;

	assign rs = Reg1Sel;
	assign rt = Reg2Sel;

	//RegWriteH, DMemWriteH, DMemEnH, PCSrcH, DMemDumpH, PCImmH, JumpH
	assign RegWriteOut = (hazard_f) ? 1'b0 : RegWriteH;
	assign DMemWrite = (hazard_f) ? 1'b0 : DMemWriteH;
	assign DMemEn = (hazard_f) ? 1'b0 : DMemEnH;
	assign PCSrc = (hazard_f) ? 1'b0 : PCSrcH;
	assign DMemDump = (hazard_f) ? 1'b0 : DMemDumpH;
	assign PCImm = (hazard_f) ? 1'b0 : PCImmH;
	assign Jump = (hazard_f) ? 1'b0 : JumpH;	


endmodule
