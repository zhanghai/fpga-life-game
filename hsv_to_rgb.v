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

	wire [2:0] c;
	wire [2:0] h_;
	wire [1:0] _temp1;
	wire [1:0] _temp2;
	wire x;
	wire r_;
	wire g_;
	wire b_;
	wire m;

	assign c = (v + 1) * (s + 1) / 8 - 1;
	assign h_ = h / 2;
	assign _temp1 = h_ % 4;
	assign _temp2 = _temp1 >= 2 ? _temp1 - 2 : 2 - _temp1;
	assign x = c * (2 - _temp2) / 2;
	assign r_ = h_ == 0 || h_ == 5 ? c :
			h_ == 1 || h_ == 4 ? x :
			0;
	assign g_ = h_ == 1 || h_ == 2 ? c :
			h_ == 0 || h_ == 3 ? x :
			0;
	assign b_ = h_ == 3 || h_ == 4 ? c :
			h_ == 2 || h_ == 5 ? x :
			0;
	assign m = v - c;
	assign r = r_ + m;
	assign g = g_ + m;
	assign b = b_ + m;

endmodule
