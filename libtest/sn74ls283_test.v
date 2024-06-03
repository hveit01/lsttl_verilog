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
// 4 bit full adder
`timescale 1ns / 100ps
`include "sn74ls283.v"

module sn74ls283_testbench;
reg [80*8-1:0] descr;
reg [3:0] a, b;
reg c0;
wire [3:0] sum;
wire c4;

sn74ls283 dut(.sum(sum), .c4(c4), .a(a), .b(b), .c0(c0));

initial
begin

	$dumpfile("sn74ls283.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: c0=%1b a=%4b b=%4b | c4=%1b sum=%4b | %0s", $time, c0, a, b, c4, sum, descr);
	
			{c0, a, b} <= 9'b0_0000_0000; descr = "";
	#30 	{c0, a, b} <= 9'b0_0001_0001;
	#30 	{c0, a, b} <= 9'b0_0010_0010;
	#30 	{c0, a, b} <= 9'b0_0100_0100;
	#30 	{c0, a, b} <= 9'b0_1000_1000;
	#30 	{c0, a, b} <= 9'b0_1000_0111;
	#30 	{c0, a, b} <= 9'b0_1111_1111;
	#30 	{c0, a, b} <= 9'b1_0001_0001;
	#30 	{c0, a, b} <= 9'b1_0010_0010;
	#30 	{c0, a, b} <= 9'b1_0100_0100;
	#30 	{c0, a, b} <= 9'b1_1000_1000;
	#30 	{c0, a, b} <= 9'b1_1000_0111;
	#30 	{c0, a, b} <= 9'b1_1111_1111;
end

endmodule


