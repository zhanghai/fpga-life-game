`timescale 1ns / 1ps

module life_game(
	input clock,
	input run,
	input [3:0] button,
	input [9:0] x_position,
	input [8:0] y_position,
	input inside_video,
	output reg [7:0] color
	);

	parameter BLOCK_SIZE = 20;
	parameter BLOCK_COUNT_X = 640 / BLOCK_SIZE;
	parameter BLOCK_COUNT_Y = 480 / BLOCK_SIZE;

	parameter COLOR_EMPTY = 8'b100_100_10;
	parameter COLOR_LIFE = 8'b000_111_11;

	reg map_0 [0:BLOCK_COUNT_X - 1] [0:BLOCK_COUNT_Y - 1];
	reg map_1 [0:BLOCK_COUNT_X - 1] [0:BLOCK_COUNT_Y - 1];
	reg map_index = 0;
	wire [3:0] neighbor_count_0 [0:BLOCK_COUNT_X - 1] [0:BLOCK_COUNT_Y - 1];
	wire [3:0] neighbor_count_1 [0:BLOCK_COUNT_X - 1] [0:BLOCK_COUNT_Y - 1];
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

	always @(posedge clock) begin
		if (run) begin
			map_index <= ~map_index;
		end
	end

genvar i, j;
generate
	for (i = 0; i < BLOCK_COUNT_X; i = i + 1) begin
		for (j = 0; j < BLOCK_COUNT_Y; j = j + 1) begin

	assign neighbor_count_0[i][j] = map_0[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y] + map_0[i][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y] + map_0[(i + 1) % BLOCK_COUNT_X][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y]
			+ map_0[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][j] + map_0[(i + 1) % BLOCK_COUNT_X][j]
			+ map_0[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][(j + 1) % BLOCK_COUNT_Y] + map_0[i][(j + 1) % BLOCK_COUNT_Y] + map_0[(i + 1) % BLOCK_COUNT_X][(j + 1) % BLOCK_COUNT_Y];
	assign neighbor_count_1[i][j] = map_1[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y] + map_1[i][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y] + map_1[(i + 1) % BLOCK_COUNT_X][(j - 1 + BLOCK_COUNT_Y) % BLOCK_COUNT_Y]
			+ map_1[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][j] + map_1[(i + 1) % BLOCK_COUNT_X][j]
			+ map_1[(i - 1 + BLOCK_COUNT_X) % BLOCK_COUNT_X][(j + 1) % BLOCK_COUNT_Y] + map_1[i][(j + 1) % BLOCK_COUNT_Y] + map_1[(i + 1) % BLOCK_COUNT_X][(j + 1) % BLOCK_COUNT_Y];
	always @(posedge clock) begin
		if (run) begin
			if (map_index == 0) begin
				if (map_0[i][j]) begin
					map_1[i][j] <= neighbor_count_0[i][j] == 2 || neighbor_count_0[i][j] == 3;
				end else begin
					map_1[i][j] <= neighbor_count_0[i][j] == 3;
				end
			end else begin
				if (map_1[i][j]) begin
					map_0[i][j] <= neighbor_count_1[i][j] == 2 || neighbor_count_1[i][j] == 3;
				end else begin
					map_0[i][j] <= neighbor_count_1[i][j] == 3;
				end
			end
		end
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
