`timescale 1ns / 1ps

module anti_jitter(
	input clock,
   input [WIDTH - 1:0] in,
   output reg [WIDTH - 1:0] out
   );

	parameter WIDTH = 1;
	parameter HOLD = 100000;

	reg [31:0] counter = 0;
	reg [WIDTH - 1:0] last_seen = 0;

	always @(posedge clock) begin
		if (last_seen != in) begin
			counter <= 0;
		end else if (counter < HOLD) begin
			counter <= counter + 1;
		end else begin
			out <= last_seen;
		end
		last_seen <= in;
	end

endmodule
