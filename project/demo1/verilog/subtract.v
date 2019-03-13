module subtract(InA, InB, Out);
	input [15:0] InA;
	input [15:0] InB;
	output [15:0] Out;

	wire w_dont_care;

	wire [15:0] w_inv_b;
	assign w_inv_b = ~InB;

	wire [15:0] w_inv_b_plus_1;
	rca_16b rca_inv_a_plus_1(.A(w_inv_b), .B(16'b1), .C_in(1'b0), .S(w_inv_b_plus_1), .C_out(w_dont_care));

	rca_16b rca_sub(.A(w_inv_b_plus_1), .B(InA), .C_in(1'b0), .S(Out), .C_out(w_dont_care));

endmodule