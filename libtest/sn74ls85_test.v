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
// 4 bit comparator
`timescale 1ns / 100ps
`include "sn74ls85.v"

module sn74ls85_testbench;
reg [80*8-1:0] descr;
reg [3:0] a, b;
reg ilt, ieq, igt;
wire olt, oeq, ogt;

sn74ls85 dut(.ogt(ogt), .oeq(oeq), .olt(olt), .a(a), .b(b), .igt(igt), .ieq(ieq), .ilt(ilt));

initial
begin

	$dumpfile("sn74ls85.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: a=%4b b=%4b gt/lt/eq=%1b%1b%1b | gt/lt/eq=%1b%1b%1b | %0s", $time, a, b, igt, ilt, ieq, ogt, olt, oeq, descr);
	
			{a, b, igt, ilt, ieq} <= 11'b1xxx_0xxx_xxx; descr = "";
	#40 	{a, b, igt, ilt, ieq} <= 11'b0xxx_1xxx_xxx;
	#40 	{a, b, igt, ilt, ieq} <= 11'b01xx_00xx_xxx;
	#40 	{a, b, igt, ilt, ieq} <= 11'b00xx_01xx_xxx;
	#40 	{a, b, igt, ilt, ieq} <= 11'b001x_000x_xxx;
	#40 	{a, b, igt, ilt, ieq} <= 11'b000x_001x_xxx;
	#40 	{a, b, igt, ilt, ieq} <= 11'b0001_0000_xxx;
	#40 	{a, b, igt, ilt, ieq} <= 11'b0000_0001_xxx;
	#40 	{a, b, igt, ilt, ieq} <= 11'b0000_0000_100;
	#40 	{a, b, igt, ilt, ieq} <= 11'b1111_1111_100;
	#40 	{a, b, igt, ilt, ieq} <= 11'b0000_0000_010;
	#40 	{a, b, igt, ilt, ieq} <= 11'b1111_1111_010;
	#40 	{a, b, igt, ilt, ieq} <= 11'b0000_0000_xx1;
	#40 	{a, b, igt, ilt, ieq} <= 11'b1111_1111_xx1;
	#40 	{a, b, igt, ilt, ieq} <= 11'b0000_0000_110;
	#40 	{a, b, igt, ilt, ieq} <= 11'b1111_1111_110;
	#40 	{a, b, igt, ilt, ieq} <= 11'b0000_0000_000;
	#40 	{a, b, igt, ilt, ieq} <= 11'b1111_1111_000;
end

endmodule


