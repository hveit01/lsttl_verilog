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
// 4x2 AND-NOR test bench
`timescale 1ns / 100ps
`include "sn74ls54.v"

module sn74ls54_testbench;
reg [80*8-1:0] descr;
reg a, b, c, d, e, f, g, h;
wire y;

sn74ls54 dut(.y(y), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h));

initial
begin
	{a, b, c, d, e, f, g, h} <= 8'b11_11_11_11; descr <= "INIT";

	$dumpfile("sn74ls54.vcd");
	$dumpvars;
	$monitor("T=%5g: in=%1b%1b %1b%1b %1b%1b %1b%1b | y=%1b | %0s", $time, a, b, c, d, e, f, g, h, y, descr);
	
	#30 	{a, b, c, d, e, f, g, h} <= 8'b0x_00_00_00; descr <= "";
	#30 	{a, b, c, d, e, f, g, h} <= 8'b11_11_11_11;
	#30 	{a, b, c, d, e, f, g, h} <= 8'bx0_00_00_00;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b11_xx_xx_xx;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b00_0x_00_00;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b11_11_11_11;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b00_x0_00_00;
	#30 	{a, b, c, d, e, f, g, h} <= 8'bxx_11_xx_xx;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b00_00_00_00;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b11_11_11_11;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b00_00_0x_00;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b11_11_11_11;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b00_00_x0_00;
	#30 	{a, b, c, d, e, f, g, h} <= 8'bxx_xx_11_xx;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b00_00_00_00;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b11_11_11_11;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b00_00_00_0x;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b11_11_11_11;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b00_00_00_x0;
	#30 	{a, b, c, d, e, f, g, h} <= 8'bxx_xx_xx_11;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b00_00_00_00;
	#30 	{a, b, c, d, e, f, g, h} <= 8'b11_11_11_11;
end

endmodule


