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
// 8 bit multiplexer
`timescale 1ns / 100ps
`include "sn74ls351.v"

module sn74ls351_testbench;
reg [80*8-1:0] descr;
reg [7:0] d;
reg g, c, b, a;
wire y;

sn74ls351 dut(.d(d), .g(g), .c(c), .b(b), .a(a), .y(y));

initial
begin

	$dumpfile("sn74ls351.vcd");
	$dumpvars;
	$monitor("T=%5g: g=%1b d=%8b cba=%1b%1b%1b | y=%1b | %0s", $time, g, d, c, b, a, y, descr);
	
	#40 	{g, c, b, a, d} <= 12'b1_xxx_xxxxxxxx; descr <= "INIT";
	#40 	{g, c, b, a, d} <= 12'b0_000_xxxxxxx0; descr <= "pass d0=0";
	#40 	{g, c, b, a, d} <= 12'b0_000_xxxxxxx1; descr <= "pass d0=1";
	#40 	{g, c, b, a, d} <= 12'b0_001_xxxxxx0x; descr <= "pass d1=0";
	#40 	{g, c, b, a, d} <= 12'b0_001_xxxxxx1x; descr <= "pass d1=1";
	#40 	{g, c, b, a, d} <= 12'b0_010_xxxxx0xx; descr <= "pass d2=0";
	#40 	{g, c, b, a, d} <= 12'b0_010_xxxxx1xx; descr <= "pass d2=1";
	#40 	{g, c, b, a, d} <= 12'b0_011_xxxx0xxx; descr <= "pass d3=0";
	#40 	{g, c, b, a, d} <= 12'b0_011_xxxx1xxx; descr <= "pass d3=1";
	#40 	{g, c, b, a, d} <= 12'b0_100_xxx0xxxx; descr <= "pass d4=0";
	#40 	{g, c, b, a, d} <= 12'b0_100_xxx1xxxx; descr <= "pass d4=1";
	#40 	{g, c, b, a, d} <= 12'b0_101_xx0xxxxx; descr <= "pass d5=0";
	#40 	{g, c, b, a, d} <= 12'b0_101_xx1xxxxx; descr <= "pass d5=1";
	#40 	{g, c, b, a, d} <= 12'b0_110_x0xxxxxx; descr <= "pass d6=0";
	#40 	{g, c, b, a, d} <= 12'b0_110_x1xxxxxx; descr <= "pass d6=1";
	#40 	{g, c, b, a, d} <= 12'b0_111_0xxxxxxx; descr <= "pass d7=0";
	#40 	{g, c, b, a, d} <= 12'b0_111_1xxxxxxx; descr <= "pass d7=1";
	#40 	{g, c, b, a, d} <= 12'b1_xxx_xxxxxxxx; descr <= "disable";

end

endmodule


