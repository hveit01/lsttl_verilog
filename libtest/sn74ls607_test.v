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
// 2 octal multiplexed regs open collector
`timescale 1ns / 100ps
`include "sn74ls607.v"

module sn74ls607_testbench;
reg [80*8-1:0] descr;
reg [7:0] a, b;
reg clk, ab;
wire [7:0] y;

sn74ls607 dut(.y(y), .a(a), .b(b), .clk(clk), .ab(ab));

initial
begin
	#1		{a, b, ab, clk} <= 18'bxxxxxxxx_xxxxxxxx_x_x; descr <= "init";

	$dumpfile("sn74ls607.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%8b b=%8b ab=%1b clk=%1b | y=%8b | %0s", 
		$time, a, b, ab, clk, y, descr);
	$display("No pullups - outputs H will be shown as Z");
	
	#100	{a, b, ab, clk} <= 18'bxxxxxxxx_10101010_0_0; descr <= "load/sel B";
	#100	{a, b, ab, clk} <= 18'bxxxxxxxx_10101010_0_1; descr <= "";
	#100	{a, b, ab, clk} <= 18'b11001100_xxxxxxxx_1_0; descr <= "load/sel A";
	#100	{a, b, ab, clk} <= 18'b11001100_xxxxxxxx_1_1; descr <= "";
	#100	{a, b, ab, clk} <= 18'bxxxxxxxx_xxxxxxxx_1_0; descr <= "clk=0";
	#100	$display("Note: must pass A, B inputs because of edge from OFF to clk=1");
			{a, b, ab, clk} <= 18'b11001100_10101010_1_1; descr <= "a stored"; // note: from clk=0 to now there was an edge!
	#100	{a, b, ab, clk} <= 18'bxxxxxxxx_xxxxxxxx_0_1; descr <= "b stored";
	#100	{a, b, ab, clk} <= 18'bxxxxxxxx_xxxxxxxx_1_1; descr <= "a stored";
	#100	{a, b, ab, clk} <= 18'bxxxxxxxx_xxxxxxxx_0_1; descr <= "b stored";

end

endmodule


