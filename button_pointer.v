`timescale 1ns / 1ps

module button_pointer(
    input button_left,
    input button_right,
    input button_up,
    input button_down,
    input button_select,
    output pointer_ready,
    output [8:0] pointer_delta_x,
    output [8:0] pointer_delta_y,
	 output pointer_select
    );

	parameter DELTA_UNIT = 7'd20;

	assign pointer_ready = button_left || button_right || button_up || button_down || button_select;

	assign pointer_delta_x[8] = button_left;
	assign pointer_delta_x[7:0] = button_left || button_right ? DELTA_UNIT : 7'd0;
	assign pointer_delta_y[8] = button_up;
	assign pointer_delta_y[7:0] = button_up || button_down ? DELTA_UNIT : 7'd0;
	
	assign pointer_select = button_select;

endmodule
