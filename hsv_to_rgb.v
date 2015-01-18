`timescale 1ns / 1ps

module hsv_to_rgb(
	// h belongs to [0, 11]
	input [3:0] h,
	input [2:0] s,
	input [2:0] v,
	output [2:0] r,
	output [2:0] g,
	output [1:0] b
	);

	wire [2:0] max = v;
	wire [2:0] _temp = v * s / 7;
	wire [2:0] min = v - _temp;
	wire [2:0] mid = v - _temp / 2;
	wire [2:0] b_;

	assign r = h == 0 || h == 1 || h == 2 || h == 10 || h == 11 ? max :
			h == 3 || h == 9 ? mid :
			min;
	assign g = h == 2 || h == 3 || h == 4 || h == 5 || h == 6 ? max :
			h == 1 || h == 7 ? mid :
			min;
	assign b_ = h == 6 || h == 7 || h == 8 || h == 9 || h == 10 ? max :
			h == 5 || h == 11 ? mid :
			min;
	assign b = b_ / 2;

endmodule
