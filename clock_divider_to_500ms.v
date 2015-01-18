`timescale 1ns / 1ps

module clock_divider_to_500ms(
   input clock_100mhz,
   output reg clock_500ms = 0
   );

	parameter COUNTER_MAX = 25000000;

	reg [25:0] counter = 0;

	always @(posedge clock_100mhz) begin
		if (counter < COUNTER_MAX - 1) begin
			counter <= counter + 1;
		end else begin
			counter <= 0;
			clock_500ms <= ~clock_500ms;
		end
	end

endmodule
