`timescale 1ns / 1ps

module neighbor_checker_2(
    input [7:0] neighbors,
    output is_equal
    );

	assign is_equal = neighbors == 8'b00000011 ||
			neighbors == 8'b00000101 ||
			neighbors == 8'b00000110 ||
			neighbors == 8'b00001001 ||
			neighbors == 8'b00001010 ||
			neighbors == 8'b00001100 ||
			neighbors == 8'b00010001 ||
			neighbors == 8'b00010010 ||
			neighbors == 8'b00010100 ||
			neighbors == 8'b00011000 ||
			neighbors == 8'b00100001 ||
			neighbors == 8'b00100010 ||
			neighbors == 8'b00100100 ||
			neighbors == 8'b00101000 ||
			neighbors == 8'b00110000 ||
			neighbors == 8'b01000001 ||
			neighbors == 8'b01000010 ||
			neighbors == 8'b01000100 ||
			neighbors == 8'b01001000 ||
			neighbors == 8'b01010000 ||
			neighbors == 8'b01100000 ||
			neighbors == 8'b10000001 ||
			neighbors == 8'b10000010 ||
			neighbors == 8'b10000100 ||
			neighbors == 8'b10001000 ||
			neighbors == 8'b10010000 ||
			neighbors == 8'b10100000 ||
			neighbors == 8'b11000000;

endmodule

module neighbor_checker_3(
    input [7:0] neighbors,
    output is_equal
    );

	assign is_equal = neighbors == 8'b00000111 ||
			neighbors == 8'b00001011 ||
			neighbors == 8'b00001101 ||
			neighbors == 8'b00001110 ||
			neighbors == 8'b00010011 ||
			neighbors == 8'b00010101 ||
			neighbors == 8'b00010110 ||
			neighbors == 8'b00011001 ||
			neighbors == 8'b00011010 ||
			neighbors == 8'b00011100 ||
			neighbors == 8'b00100011 ||
			neighbors == 8'b00100101 ||
			neighbors == 8'b00100110 ||
			neighbors == 8'b00101001 ||
			neighbors == 8'b00101010 ||
			neighbors == 8'b00101100 ||
			neighbors == 8'b00110001 ||
			neighbors == 8'b00110010 ||
			neighbors == 8'b00110100 ||
			neighbors == 8'b00111000 ||
			neighbors == 8'b01000011 ||
			neighbors == 8'b01000101 ||
			neighbors == 8'b01000110 ||
			neighbors == 8'b01001001 ||
			neighbors == 8'b01001010 ||
			neighbors == 8'b01001100 ||
			neighbors == 8'b01010001 ||
			neighbors == 8'b01010010 ||
			neighbors == 8'b01010100 ||
			neighbors == 8'b01011000 ||
			neighbors == 8'b01100001 ||
			neighbors == 8'b01100010 ||
			neighbors == 8'b01100100 ||
			neighbors == 8'b01101000 ||
			neighbors == 8'b01110000 ||
			neighbors == 8'b10000011 ||
			neighbors == 8'b10000101 ||
			neighbors == 8'b10000110 ||
			neighbors == 8'b10001001 ||
			neighbors == 8'b10001010 ||
			neighbors == 8'b10001100 ||
			neighbors == 8'b10010001 ||
			neighbors == 8'b10010010 ||
			neighbors == 8'b10010100 ||
			neighbors == 8'b10011000 ||
			neighbors == 8'b10100001 ||
			neighbors == 8'b10100010 ||
			neighbors == 8'b10100100 ||
			neighbors == 8'b10101000 ||
			neighbors == 8'b10110000 ||
			neighbors == 8'b11000001 ||
			neighbors == 8'b11000010 ||
			neighbors == 8'b11000100 ||
			neighbors == 8'b11001000 ||
			neighbors == 8'b11010000 ||
			neighbors == 8'b11100000;

endmodule
