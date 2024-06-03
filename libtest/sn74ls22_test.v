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
// 4 input NAND with OC test bench
`timescale 1ns / 100ps
`include "sn74ls22.v"

module sn74ls22_testbench;
reg [80*8-1:0] descr;
reg a, b, c, d;
wire oc;
wire pu;

sn74ls22 dutoc(.y(oc), .a(a), .b(b), .c(c), .d(d));
sn74ls22 dutpu(.y(pu), .a(a), .b(b), .c(c), .d(d));
pullup(pu);

initial
begin
	{a, b, c, d} <= 4'b1111; descr <= "";

	$dumpfile("sn74ls22.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%1b b=%1b c=%1b d=%1b | oc=%1b pu=%1b | %0s", $time, a, b, c, d, oc, pu, descr);
	
	#40 	{a, b, c, d} <= 4'b0xxx;
	#40 	{a, b, c, d} <= 4'b1111;
	#40 	{a, b, c, d} <= 4'bx0xx;
	#40 	{a, b, c, d} <= 4'b1111;
	#40 	{a, b, c, d} <= 4'bxx0x;
	#40 	{a, b, c, d} <= 4'b1111;
	#40 	{a, b, c, d} <= 4'bxxx0;
	#40 	{a, b, c, d} <= 4'b1111;
	#40 	{a, b, c, d} <= 4'b0000;
end

endmodule


