`timescale 1ns / 1ps

module color_generator_test;

	// Inputs
	reg [4:0] x_index;
	reg [4:0] y_index;

	// Outputs
	wire [7:0] color;

	// Instantiate the Unit Under Test (UUT)
	color_generator uut (
		.x_index(x_index), 
		.y_index(y_index), 
		.color(color)
	);

	initial begin
		x_index = 0;
		y_index = 0;
		repeat (23) begin
			repeat (31) begin
				#2;
				x_index = x_index + 1;
			end
			y_index = y_index + 1;
		end
	end

	initial begin
		// Initialize Inputs
		x_index = 0;
		y_index = 0;

		// Wait 100 ns for global reset to finish
		#100;

		// Add stimulus here
	end

endmodule

