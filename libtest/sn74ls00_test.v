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
// 2 input NAND test bench
`timescale 1ns / 100ps
`include "sn74ls00.v"

module sn74ls00_testbench;
reg [80*8-1:0] descr;
reg a, b;
wire y;

sn74ls00 dut(.y(y), .a(a), .b(b));

initial
begin
	{a, b} <= 2'b11; descr <= "INIT";

	$dumpfile("sn74ls00.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%1b b=%1b | y=%1b | %0s", $time, a, b, y, descr);
	
	#20 	{a, b} <= 2'b00; descr <= "";
	#20 	{a, b} <= 2'b11;
	#20 	{a, b} <= 2'b10;
	#20 	{a, b} <= 2'b11;
	#20 	{a, b} <= 2'b01;
	#20 	{a, b} <= 2'b11;
	#20 	{a, b} <= 2'b00;
end

endmodule


