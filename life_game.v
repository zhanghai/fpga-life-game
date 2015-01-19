`timescale 1ns / 1ps

module life_game(
	input clock,
	input run,
	input [3:0] button,
	input mouse_clock,
	input mouse_button,
	input [8:0] mouse_delta_x,
	input [8:0] mouse_delta_y,
	input [9:0] x_position,
	input [8:0] y_position,
	input inside_video,
	output reg [7:0] color
	);

	parameter BLOCK_SIZE = 20;
	parameter BLOCK_COUNT_X = 640 / BLOCK_SIZE;
	parameter BLOCK_COUNT_Y = 480 / BLOCK_SIZE;

	parameter COLOR_EMPTY = 8'b111_111_11;

	reg [8:0] mouse_x = 320;
	reg [8:0] mouse_y = 240;
	wire mouse_x_index;
	wire mouse_y_index;
	reg map_0 [0:BLOCK_COUNT_X - 1] [0:BLOCK_COUNT_Y - 1];
	reg map_1 [0:BLOCK_COUNT_X - 1] [0:BLOCK_COUNT_Y - 1];
	reg map_index = 0;
	wire neighbor_equals_2_0 [0:BLOCK_COUNT_X - 1] [0:BLOCK_COUNT_Y - 1];
	wire neighbor_equals_3_0 [0:BLOCK_COUNT_X - 1] [0:BLOCK_COUNT_Y - 1];
	wire neighbor_equals_2_1 [0:BLOCK_COUNT_X - 1] [0:BLOCK_COUNT_Y - 1];
	wire neighbor_equals_3_1 [0:BLOCK_COUNT_X - 1] [0:BLOCK_COUNT_Y - 1];
	wire [4:0] x_index;
	wire [4:0] y_index;
	wire block_current;
	wire [7:0] color_life;

	initial begin
		map_0[1][0] = 1;
		map_0[2][1] = 1;
		map_0[0][2] = 1;
		map_0[1][2] = 1;
		map_0[2][2] = 1;
	end

	always @(posedge mouse_clock) begin
		mouse_x <= mouse_x + mouse_delta_x;
		mouse_y <= mouse_y + mouse_delta_y;
	end

	assign mouse_x_index = mouse_x / 5'd20;
	assign mouse_y_index = mouse_y / 5'd20;

	always @(posedge clock) begin
		if (run) begin
			map_index <= ~map_index;
		end
	end

genvar i, j;
generate
	for (i = 0; i < BLOCK_COUNT_X; i = i + 1) begin
		for (j = 0; j < BLOCK_COUNT_Y; j = j + 1) begin

	neighbor_checker_2({map_0[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y], map_0[i][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y], map_0[(i + 1) % BLOCK_COUNT_X][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y],
			map_0[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][j], map_0[(i + 1) % BLOCK_COUNT_X][j],
			map_0[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][(j + 1) % BLOCK_COUNT_Y], map_0[i][(j + 1) % BLOCK_COUNT_Y], map_0[(i + 1) % BLOCK_COUNT_X][(j + 1) % BLOCK_COUNT_Y]},
			neighbor_equals_2_0[i][j]);
	neighbor_checker_3({map_0[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y], map_0[i][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y], map_0[(i + 1) % BLOCK_COUNT_X][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y],
			map_0[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][j], map_0[(i + 1) % BLOCK_COUNT_X][j],
			map_0[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][(j + 1) % BLOCK_COUNT_Y], map_0[i][(j + 1) % BLOCK_COUNT_Y], map_0[(i + 1) % BLOCK_COUNT_X][(j + 1) % BLOCK_COUNT_Y]},
			neighbor_equals_3_0[i][j]);

	neighbor_checker_2({map_1[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y], map_1[i][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y], map_1[(i + 1) % BLOCK_COUNT_X][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y],
			map_1[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][j], map_1[(i + 1) % BLOCK_COUNT_X][j],
			map_1[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][(j + 1) % BLOCK_COUNT_Y], map_1[i][(j + 1) % BLOCK_COUNT_Y], map_1[(i + 1) % BLOCK_COUNT_X][(j + 1) % BLOCK_COUNT_Y]},
			neighbor_equals_2_1[i][j]);
	neighbor_checker_3({map_1[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y], map_1[i][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y], map_1[(i + 1) % BLOCK_COUNT_X][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y],
			map_1[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][j], map_1[(i + 1) % BLOCK_COUNT_X][j],
			map_1[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][(j + 1) % BLOCK_COUNT_Y], map_1[i][(j + 1) % BLOCK_COUNT_Y], map_1[(i + 1) % BLOCK_COUNT_X][(j + 1) % BLOCK_COUNT_Y]},
			neighbor_equals_3_1[i][j]);

	always @(posedge clock) begin
		if (run) begin
			if (map_index == 0) begin
				if (map_0[i][j]) begin
					map_1[i][j] <= mouse_button || neighbor_equals_2_0[i][j] || neighbor_equals_3_0[i][j];
				end else begin
					map_1[i][j] <= mouse_button || neighbor_equals_3_0[i][j];
				end
			end else begin
				if (map_1[i][j]) begin
					map_0[i][j] <= mouse_button || neighbor_equals_2_1[i][j] || neighbor_equals_3_1[i][j];
				end else begin
					map_0[i][j] <= mouse_button || neighbor_equals_3_1[i][j];
				end
			end
		end
//		map_0[i][j] <= 1;
//		map_1[i][j] <= 1;
	end

		end
	end
endgenerate

	assign x_index = x_position / 5'd20;
	assign y_index = y_position / 5'd20;
	assign block_current = map_index == 0 ? map_0[x_index][y_index] : map_1[x_index][y_index];
	color_generator color_generator(x_index, y_index, color_life);

	always @(*) begin
		if (inside_video) begin
			color = block_current ? color_life : COLOR_EMPTY;
		end else begin
			color = 0;
		end
	end

endmodule
