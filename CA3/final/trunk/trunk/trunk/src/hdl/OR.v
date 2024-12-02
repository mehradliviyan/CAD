module Or 
(
	input a,
	input b,
	output out
);
	c1 
	OR_
	(
		.A0(a), 
		.A1(1'b1), 
		.SA(b), 
		.B0(1'b0), 
		.B1(1'b0), 
		.SB(1'b0), 
		.S0(1'b0), 
		.S1(1'b0), 
		.f(out)
	);
	
endmodule