`timescale 1ns / 1ps

module color_generator(
	input [4:0] x_index,
	input [4:0] y_index,
	output [7:0] color
	);

	wire [3:0] h;
	wire [2:0] s;

	// TODO: h = 2 * h for variance.
	assign h = x_index * 12 / 32;
	assign s = y_index / 6 + 4;
	
	hsv_to_rgb hsv_to_rgb(h, s, 3'b111, color[7:5], color[4:2], color[1:0]);

endmodule
