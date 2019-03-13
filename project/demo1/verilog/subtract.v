module subtract(InA, InB, Out);
	input [15:0] InA;
	input [15:0] InB;
	output [15:0] Out;

	wire w_dont_care;

	wire [15:0] w_inv_a;
	assign w_inv_a = ~InA;

	wire [15:0] w_inv_a_plus_1;
	rca_16b rca_inv_a_plus_1(.A(w_inv_a), .B(16'b1), .C_in(1'b0), .S(w_inv_a_plus_1), .C_out(w_dont_care));

	rca_16b rca_sub(.A(w_inv_a_plus_1), .B(InB), .C_in(1'b0), .S(Out), .C_out(w_dont_care));

endmodule