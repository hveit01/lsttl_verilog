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
// 4 input NAND schmitt trigger test bench
`timescale 1ns / 100ps
`include "sn74ls13.v"

module sn74ls13_testbench;
reg [80*8-1:0] descr;
reg a, b, c, d;
wire y;

sn74ls13 dut(.y(y), .a(a), .b(b), .c(c), .d(d));

initial
begin
	{a, b, c, d} <= 4'b0000; descr <= "IN=0000";

	$dumpfile("sn74ls13.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%1b b=%1b c=%1b d=%1b | y=%1b | %0s", $time, a, b, c, d, y, descr);
	
	#40 	{a, b, c, d} <= 4'b0xxx; descr <= "IN=0xxx";
	#40 	{a, b, c, d} <= 4'b1111; descr <= "IN=1111";
	#40 	{a, b, c, d} <= 4'bx0xx; descr <= "IN=x0xx";
	#40 	{a, b, c, d} <= 4'b1111; descr <= "IN=1111";
	#40 	{a, b, c, d} <= 4'bxx0x; descr <= "IN=xx0x";
	#40 	{a, b, c, d} <= 4'b1111; descr <= "IN=1111";
	#40 	{a, b, c, d} <= 4'bxxx0; descr <= "IN=xxx0";
	#40 	{a, b, c, d} <= 4'b1111; descr <= "IN=1111";
	#40 	{a, b, c, d} <= 4'b0000; descr <= "IN=0000";
end

endmodule


