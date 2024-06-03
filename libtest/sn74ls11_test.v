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
// 3 input AND test bench
`timescale 1ns / 100ps
`include "sn74ls11.v"

module sn74ls11_testbench;
reg [80*8-1:0] descr;
reg a, b, c;
wire y;

sn74ls11 dut(.y(y), .a(a), .b(b), .c(c));

initial
begin
	{a, b, c} <= 3'b111; descr <= "IN=111";

	$dumpfile("sn74ls11.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%1b b=%1b c=%1b| y=%1b | %0s", $time, a, b, c, y, descr);
	
	#30 	{a, b, c} <= 3'b0xx; descr <= "IN=0xx";
	#30 	{a, b, c} <= 3'b111; descr <= "IN=111";
	#30 	{a, b, c} <= 3'bx0x; descr <= "IN=x0x";
	#30 	{a, b, c} <= 3'b111; descr <= "IN=111";
	#30 	{a, b, c} <= 3'bxx0; descr <= "IN=xx0";
	#30 	{a, b, c} <= 3'b111; descr <= "IN=111";
	#30 	{a, b, c} <= 3'b000; descr <= "IN=000";
end

endmodule


