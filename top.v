`timescale 1ns / 1ps

module top(
	input clock,
	input [7:0] sw,
	input btn_l, btn_r, btn_u, btn_d,
	output reg [7:0] led = 0,
	output vga_h_sync,
	output vga_v_sync,
	output [2:0] vga_r,
	output [2:0] vga_g,
	output [1:0] vga_b
   );

	wire [7:0] switch;
	// Left, right, up, down.
	wire [3:0] button;
	wire clock_25mhz;
	wire inside_video;
	wire [9:0] x_position;
	wire [8:0] y_position;
	wire [7:0] color;
	wire clock_125ms;
	wire clock_250ms;
	wire clock_500ms;
	wire clock_1s;
	wire clock_life_game;

	anti_jitter #(8) switch_anti_jitter(clock, sw[7:0], switch[7:0]);
	anti_jitter #(4) button_anti_jitter(clock, {btn_l, btn_r, btn_u, btn_d}, button[3:0]);

	clock_divider #(2) clock_divider_to_25mhz(clock, clock_25mhz);

	vga_controller vga_controller(clock_25mhz, switch[0], vga_h_sync, vga_v_sync, inside_video, x_position, y_position);

	clock_divider_to_125ms clock_divider_to_125ms(clock, clock_125ms);
	clock_divider #(1) clock_divider_to_250ms(clock_125ms, clock_250ms);
	clock_divider #(1) clock_divider_to_500ms(clock_250ms, clock_500ms);
	clock_divider #(1) clock_divider_to_1s(clock_500ms, clock_1s);
	multiplexer_4_1 clock_multiplexer({clock_125ms, clock_250ms, clock_500ms, clock_1s}, switch[6:5], clock_life_game);

	life_game life_game(clock_life_game, switch[7], button[3:0], x_position, y_position, inside_video, color);
	assign vga_r = color[7:5];
	assign vga_g = color[4:2];
	assign vga_b = color[1:0];

	always @(posedge clock_125ms) begin
		led <= led + 1'b1;
	end

endmodule
