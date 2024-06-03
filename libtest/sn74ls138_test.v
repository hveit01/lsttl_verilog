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
// 3-to-8 decoder test bench
`timescale 1ns / 100ps
`include "sn74ls138.v"

module sn74ls138_testbench;
reg [80*8-1:0] descr;
reg a, b, c, g1, g2a_, g2b_;
wire [7:0] y;

sn74ls138 dut(.y(y), .a(a), .b(b), .c(c), .g1(g1), .g2a_(g2a_), .g2b_(g2b_));

initial
begin
	$dumpfile("sn74ls138.vcd");
	$dumpvars;
	$monitor("T=%5g: g1=%1b g2a=%1b g2b=%1b cba=%1b%1b%1b | y=%8b | %0s", $time, g1, g2a_, g2b_, c, b, a, y, descr);
	
			{g1, g2a_, g2b_, c, b, a} <= 6'b011xxx; descr <= "init";

	#50 	{g1, g2a_, g2b_, c, b, a} <= 6'bx1xxxx; descr <= "all high";
	#50 	{g1, g2a_, g2b_, c, b, a} <= 6'bxx1xxx; descr <= "all high";
	#50 	{g1, g2a_, g2b_, c, b, a} <= 6'b100000; descr <= "0";
	#50 	{g1, g2a_, g2b_, c, b, a} <= 6'b0xxxxx; descr <= "all high";
	#50 	{g1, g2a_, g2b_, c, b, a} <= 6'b100000; descr <= "0";
	#50 	{g1, g2a_, g2b_, c, b, a} <= 6'b100001; descr <= "1";
	#50 	{g1, g2a_, g2b_, c, b, a} <= 6'b100010; descr <= "2";
	#50 	{g1, g2a_, g2b_, c, b, a} <= 6'b100011; descr <= "3";
	#50 	{g1, g2a_, g2b_, c, b, a} <= 6'b100100; descr <= "4";
	#50 	{g1, g2a_, g2b_, c, b, a} <= 6'b100101; descr <= "5";
	#50 	{g1, g2a_, g2b_, c, b, a} <= 6'b100110; descr <= "6";
	#50 	{g1, g2a_, g2b_, c, b, a} <= 6'b100111; descr <= "7";
	
end

endmodule


