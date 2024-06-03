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
`include "sn74ls251.v"

module sn74ls251_testbench;
reg [80*8-1:0] descr;
reg [7:0] i;
reg oe, c, b, a;
wire q, q_;

sn74ls251 dut(.i(i), .oe(oe), .c(c), .b(b), .a(a), .q(q), .q_(q_));

initial
begin

	$dumpfile("sn74ls251.vcd");
	$dumpvars;
	$monitor("T=%5g: oe=%1b i=%8b cba=%1b%1b%1b | q=%1b q_=%1b | %0s", $time, oe, i, c, b, a, q, q_, descr);
	
	#40 	{oe, c, b, a, i} <= 12'b1_xxx_xxxxxxxx; descr <= "INIT";
	#40 	{oe, c, b, a, i} <= 12'b0_000_xxxxxxx0; descr <= "pass i0=0";
	#40 	{oe, c, b, a, i} <= 12'b0_000_xxxxxxx1; descr <= "pass i0=1";
	#40 	{oe, c, b, a, i} <= 12'b0_001_xxxxxx0x; descr <= "pass i1=0";
	#40 	{oe, c, b, a, i} <= 12'b0_001_xxxxxx1x; descr <= "pass i1=1";
	#40 	{oe, c, b, a, i} <= 12'b0_010_xxxxx0xx; descr <= "pass i2=0";
	#40 	{oe, c, b, a, i} <= 12'b0_010_xxxxx1xx; descr <= "pass i2=1";
	#40 	{oe, c, b, a, i} <= 12'b0_011_xxxx0xxx; descr <= "pass i3=0";
	#40 	{oe, c, b, a, i} <= 12'b0_011_xxxx1xxx; descr <= "pass i3=1";
	#40 	{oe, c, b, a, i} <= 12'b0_100_xxx0xxxx; descr <= "pass i4=0";
	#40 	{oe, c, b, a, i} <= 12'b0_100_xxx1xxxx; descr <= "pass i4=1";
	#40 	{oe, c, b, a, i} <= 12'b0_101_xx0xxxxx; descr <= "pass i5=0";
	#40 	{oe, c, b, a, i} <= 12'b0_101_xx1xxxxx; descr <= "pass i5=1";
	#40 	{oe, c, b, a, i} <= 12'b0_110_x0xxxxxx; descr <= "pass i6=0";
	#40 	{oe, c, b, a, i} <= 12'b0_110_x1xxxxxx; descr <= "pass i6=1";
	#40 	{oe, c, b, a, i} <= 12'b0_111_0xxxxxxx; descr <= "pass i7=0";
	#40 	{oe, c, b, a, i} <= 12'b0_111_1xxxxxxx; descr <= "pass i7=1";
	#40 	{oe, c, b, a, i} <= 12'b1_xxx_xxxxxxxx; descr <= "disable";

end

endmodule


