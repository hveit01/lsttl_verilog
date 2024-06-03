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
// BCD EXCESS3GRAY decoder test bench
`timescale 1ns / 100ps
`include "sn74ls44.v"

module sn74ls44_testbench;
reg [80*8-1:0] descr;
reg a, b, c, d;
wire [9:0] y;

sn74ls44 dut(.y(y), .a(a), .b(b), .c(c), .d(d));

initial
begin
	{d, c, b, a} <= 4'b0000; descr <= "INIT";

	$dumpfile("sn74ls44.vcd");
	$dumpvars;
	$monitor("T=%5g: dcba=%1b%1b%1b%1b | y=%10b | %0s", $time, d, c, b, a, y, descr);
	
	#40 	{d, c, b, a} <= 4'b0010; descr <= "0";
	#40 	{d, c, b, a} <= 4'b0110; descr <= "1";
	#40 	{d, c, b, a} <= 4'b0111; descr <= "2";
	#40 	{d, c, b, a} <= 4'b0101; descr <= "3";
	#40 	{d, c, b, a} <= 4'b0100; descr <= "4";
	#40 	{d, c, b, a} <= 4'b1100; descr <= "5";
	#40 	{d, c, b, a} <= 4'b1101; descr <= "6";
	#40 	{d, c, b, a} <= 4'b1111; descr <= "7";
	#40 	{d, c, b, a} <= 4'b1110; descr <= "8";
	#40 	{d, c, b, a} <= 4'b1010; descr <= "9";
	#40 	{d, c, b, a} <= 4'b0000; descr <= "INVALID";
	#40 	{d, c, b, a} <= 4'b0001; descr <= "INVALID";
	#40 	{d, c, b, a} <= 4'b0011; descr <= "INVALID";
	#40 	{d, c, b, a} <= 4'b1000; descr <= "INVALID";
	#40 	{d, c, b, a} <= 4'b1001; descr <= "INVALID";
	#40 	{d, c, b, a} <= 4'b1011; descr <= "INVALID";
end

endmodule


