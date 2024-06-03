// This code is part of the model collection of simulatable TTL devices.
// Note this does not necessarily mean they are synthesizable!!!
//
// Copyright (C) 2024  Holger Veit (hveit01@web.de)
//
//    This program is free software; you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation; either version 3 of the License, or (at
//    your option) any later version.
//
//    This program is distributed in the hope that it will be useful, but
//    WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
//    General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program; if not, see <http://www.gnu.org/licenses/>.
//
//
// BCD DECIMAL decoder test bench
`timescale 1ns / 100ps
`include "sn74ls147.v"

module sn74ls147_testbench;
reg [80*8-1:0] descr;
reg [8:0] i;

sn74ls147 dut(.i(i), .a(a), .b(b), .c(c), .d(d));

initial
begin
	i <= 9'b111111111; descr <= "INIT";

	$dumpfile("sn74ls147.vcd");
	$dumpvars;
	$monitor("T=%5g: i=%9b | dcba=%1b%1b%1b%1b | %0s", $time, i, d, c, b, a, descr);
	
	#40 	i <= 9'b0xxxxxxxx; descr <= "9";
	#40 	i <= 9'b10xxxxxxx; descr <= "8";
	#40 	i <= 9'b110xxxxxx; descr <= "7";
	#40 	i <= 9'b1110xxxxx; descr <= "6";
	#40 	i <= 9'b11110xxxx; descr <= "5";
	#40 	i <= 9'b111110xxx; descr <= "4";
	#40 	i <= 9'b1111110xx; descr <= "3";
	#40 	i <= 9'b11111110x; descr <= "2";
	#40 	i <= 9'b111111110; descr <= "1";
	#40     i <= 9'b111111111; descr <= "no select";
end

endmodule


