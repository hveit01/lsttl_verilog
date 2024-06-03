// This code is part of the model collection of simulatable TTL devices.
// Note this does not necessarily mean they are synthesizable!!!
//
// Copyright (C) 2022  Holger Veit (hveit01@web.de)
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
// 2x4 AND-NOR test bench
`timescale 1ns / 100ps
`include "sn74ls55.v"

module sn74ls55_testbench;
reg [80*8-1:0] descr;
reg a, b, c, d, e, f, g, h;
wire y;

sn74ls55 dut(.y(y), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h));

initial
begin
	{a, b, c, d, e, f, g, h} <= 8'b1111_1111; descr <= "INIT";

	$dumpfile("sn74ls55.vcd");
	$dumpvars;
	$monitor("T=%5g: in=%1b%1b%1b%1b %1b%1b%1b%1b | y=%1b | %0s", $time, a, b, c, d, e, f, g, h, y, descr);
	
	#30 	{a, b, c, d, e, f, g, h} <= 8'b0xxx_0000; descr <= "";
	#30 	{a, b, c, d, e, f, g, h} <= 8'b1111_1111;
	#30 	{a, b, c, d, e, f, g, h} <= 8'bx0xx_0000;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b1111_1111;
	#30 	{a, b, c, d, e, f, g, h} <= 8'bxx0x_0000;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b1111_1111;
	#30 	{a, b, c, d, e, f, g, h} <= 8'bxxx0_0000;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b1111_xxxx;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b0000_0000;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b1111_1111;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b0000_0xxx;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b1111_1111;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b0000_x0xx;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b1111_1111;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b0000_xx0x;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b1111_1111;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b0000_xx0x;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b1111_1111;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b0000_xxx0;
	#30 	{a, b, c, d, e, f, g, h} <= 8'bxxxx_1111;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b0000_0000;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b1111_1111;
end

endmodule


