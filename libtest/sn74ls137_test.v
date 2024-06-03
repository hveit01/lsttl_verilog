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
// BCD DECIMAL decoder test bench
`timescale 1ns / 100ps
`include "sn74ls137.v"

module sn74ls137_testbench;
reg [80*8-1:0] descr;
reg a, b, c, gl, g1, g2;
wire [7:0] y;

sn74ls137 dut(.y(y), .a(a), .b(b), .c(c), .gl(gl), .g1(g1), .g2(g2));

initial
begin
	$dumpfile("sn74ls137.vcd");
	$dumpvars;
	$monitor("T=%5g: gl=%1b g1=%1b g2=%1b cba=%1b%1b%1b | y=%8b | %0s", $time, gl, g1, g2, c, b, a, y, descr);
	
	#40 	{gl, g1, g2, c, b, a} <= 6'bxx1000; descr <= "all high";
	#40 	{gl, g1, g2, c, b, a} <= 6'bx0x000; descr <= "all high";
	#40 	{gl, g1, g2, c, b, a} <= 6'b010000; descr <= "0";
	#40 	{gl, g1, g2, c, b, a} <= 6'b010001; descr <= "1";
	#40 	{gl, g1, g2, c, b, a} <= 6'b010010; descr <= "2";
	#40 	{gl, g1, g2, c, b, a} <= 6'b010011; descr <= "3";
	#40 	{gl, g1, g2, c, b, a} <= 6'b010100; descr <= "4";
	#40 	{gl, g1, g2, c, b, a} <= 6'b010101; descr <= "5";
	#40 	{gl, g1, g2, c, b, a} <= 6'b010110; descr <= "6";
	#40 	{gl, g1, g2, c, b, a} <= 6'b010111; descr <= "7";
	#40 	{gl, g1, g2, c, b, a} <= 6'b110xxx; descr <= "hold 7 latched";
	#40 	{gl, g1, g2, c, b, a} <= 6'b10xxxx; descr <= "all high, but latched";
	#40 	{gl, g1, g2, c, b, a} <= 6'b110xxx; descr <= "hold last=7 latched";
	#40 	{gl, g1, g2, c, b, a} <= 6'b010101; descr <= "5";
	#40 	{gl, g1, g2, c, b, a} <= 6'b110xxx; descr <= "hold 5 latched";
	#40 	{gl, g1, g2, c, b, a} <= 6'b110011; descr <= "3, but last=5 latched";
	#40 	{gl, g1, g2, c, b, a} <= 6'b010011; descr <= "release latch, 3";
	
end

endmodule


