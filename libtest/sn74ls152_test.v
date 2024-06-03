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
`include "sn74ls152.v"

module sn74ls152_testbench;
reg [80*8-1:0] descr;
reg [7:0] i;
reg c, b, a;
wire w;

sn74ls152 dut(.i(i), .c(c), .b(b), .a(a), .w(w));

initial
begin

	$dumpfile("sn74ls152.vcd");
	$dumpvars;
	$monitor("T=%5g: i=%8b cba=%1b%1b%1b | w=%1b | %0s", $time, i, c, b, a, w, descr);
	
			{c, b, a, i} <= 11'bxxx_xxxxxxxx; descr <= "INIT";
	#40 	{c, b, a, i} <= 11'b000_xxxxxxx0; descr <= "pass i0=0";
	#40 	{c, b, a, i} <= 11'b000_xxxxxxx1; descr <= "pass i0=1";
	#40 	{c, b, a, i} <= 11'b001_xxxxxx0x; descr <= "pass i1=0";
	#40 	{c, b, a, i} <= 11'b001_xxxxxx1x; descr <= "pass i1=1";
	#40 	{c, b, a, i} <= 11'b010_xxxxx0xx; descr <= "pass i2=0";
	#40 	{c, b, a, i} <= 11'b010_xxxxx1xx; descr <= "pass i2=1";
	#40 	{c, b, a, i} <= 11'b011_xxxx0xxx; descr <= "pass i3=0";
	#40 	{c, b, a, i} <= 11'b011_xxxx1xxx; descr <= "pass i3=1";
	#40 	{c, b, a, i} <= 11'b100_xxx0xxxx; descr <= "pass i4=0";
	#40 	{c, b, a, i} <= 11'b100_xxx1xxxx; descr <= "pass i4=1";
	#40 	{c, b, a, i} <= 11'b101_xx0xxxxx; descr <= "pass i5=0";
	#40 	{c, b, a, i} <= 11'b101_xx1xxxxx; descr <= "pass i5=1";
	#40 	{c, b, a, i} <= 11'b110_x0xxxxxx; descr <= "pass i6=0";
	#40 	{c, b, a, i} <= 11'b110_x1xxxxxx; descr <= "pass i6=1";
	#40 	{c, b, a, i} <= 11'b111_0xxxxxxx; descr <= "pass i7=0";
	#40 	{c, b, a, i} <= 11'b111_1xxxxxxx; descr <= "pass i7=1";

end

endmodule


