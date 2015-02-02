`timescale 1ns / 1ps

module color_circlizer(
	input [4:0] x_position,
	input [4:0] y_position,
   input [7:0] color_in,
   input [7:0] color_blank,
   output [7:0] color_out
   );

	parameter BLOCK_SIZE = 20;

	// 32 / 2 = 16
	wire [3:0] x = x_position > BLOCK_SIZE / 2 ? x_position - BLOCK_SIZE / 2 : BLOCK_SIZE / 2 - x_position;
	wire [3:0] y = y_position > BLOCK_SIZE / 2 ? y_position - BLOCK_SIZE / 2 : BLOCK_SIZE / 2 - y_position;

	// Use < to add some space between circles.
	assign color_out = x * x + y * y < (BLOCK_SIZE / 2) * (BLOCK_SIZE / 2) ? color_in : color_blank;

endmodule
