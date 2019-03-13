/*
   CS/ECE 552, Spring '19
   Homework #5, Problem #1
  
   Random testbench for the 8x16b register file.
*/
module control_hier_bench(/*AUTOARG*/);
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire       err;
   wire       RegWrite, DMemWrite,              // From top of control_hier.v
              DMemEn, ALUSrc2, PCSrc, PCImm,    // From top of control_hier.v
              MemToReg, DMemDump, Jump;         // From top of control_hier.v
   wire [1:0] RegDst;                           // From top of control_hier.v
   wire [2:0] SESel;                            // From top of control_hier.v
   // End of automatics
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [4:0]  OpCode;                           // To top of control_hier.v
   reg [1:0]  Funct;                            // To top of control_hier.v
   // End of automatics

   integer    cycle_count;

   wire       clk;
   wire       rst;

   reg        fail;

   // Instantiate the module we want to verify

   control_hier DUT(/*AUTOINST*/
                    // Outputs
                    .err                          (err),
                    .RegDst                       (RegDst),
                    .SESel                        (SESel),
                    .RegWrite                     (RegWrite),
                    .DMemWrite                    (DMemWrite),
                    .DMemEn                       (DMemEn),
                    .ALUSrc2                      (ALUSrc2),
                    .PCSrc                        (PCSrc),
                    .PCImm                        (PCImm),
                    .MemToReg                     (MemToReg),
                    .DMemDump                     (DMemDump),
                    .Jump                         (Jump),
                    // Inputs
                    .OpCode                       (OpCode),
                    .Funct                        (Funct));

   /* YOUR CODE HERE */

   assign               clk = DUT.clk_generator.clk;
   assign               rst = DUT.clk_generator.rst;

   initial begin
      cycle_count = 0;
      $dumpvars;
      $display("Simulation 36 cycles");

   end

always @ (posedge clk)begin
      if (cycle_count < 32) begin
        OpCode = cycle_count;
	Funct = 2'b00;
      end
      if (cycle_count == 32) begin
        OpCode = 5'b0x010;
	Funct = 2'b00;
      end
      if (cycle_count == 33) begin
        OpCode = 5'b100z0;
      end
      if (cycle_count == 34) begin
        OpCode = 5'b11000;
	Funct = 2'b0x;
      end
      if (cycle_count == 35) begin
        OpCode = 5'b00110;
	Funct = 2'bz1;
      end
      // Delay for simulation to occur
      #10

      // Print log of what transpired
      $display("Funct: %2b OpCode: %5b err: %d RegDst: %2b SESel: %3b RegWrite: %d DMemWrite: %d DMemEn: %d ALUSrc2: %d PCSrc: %d PCImm: %d MemToReg: %d DMemDump: %d Jump: %d",
               Funct, OpCode,
               err, RegDst, SESel, RegWrite, DMemWrite, DMemEn, ALUSrc2, PCSrc, PCImm, MemToReg, DMemDump, Jump);

      cycle_count = cycle_count + 1;
      if (cycle_count > 35) begin
        $display("\nTEST FINISHED\n");
        $stop;
      end

   end

endmodule // control_hier_bench

