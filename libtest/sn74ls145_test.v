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
// BCD DECIMAL decoder test bench
`timescale 1ns / 100ps
`include "sn74ls145.v"

module sn74ls145_testbench;
reg [80*8-1:0] descr;
reg a, b, c, d;
wire [9:0] y;

sn74ls145 dut(.y(y), .a(a), .b(b), .c(c), .d(d));

initial
begin
	{d, c, b, a} <= 4'b1111; descr <= "INIT";

	$dumpfile("sn74ls145.vcd");
	$dumpvars;
	$monitor("T=%5g: dcba=%1b%1b%1b%1b | y=%10b | %0s", $time, d, c, b, a, y, descr);
	
	#80 	{d, c, b, a} <= 4'b0000; descr <= "0";
	#80 	{d, c, b, a} <= 4'b0001; descr <= "1";
	#80 	{d, c, b, a} <= 4'b0010; descr <= "2";
	#80 	{d, c, b, a} <= 4'b0011; descr <= "3";
	#80 	{d, c, b, a} <= 4'b0100; descr <= "4";
	#80 	{d, c, b, a} <= 4'b0101; descr <= "5";
	#80 	{d, c, b, a} <= 4'b0110; descr <= "6";
	#80 	{d, c, b, a} <= 4'b0111; descr <= "7";
	#80 	{d, c, b, a} <= 4'b1000; descr <= "8";
	#80 	{d, c, b, a} <= 4'b1001; descr <= "9";
	#80 	{d, c, b, a} <= 4'b1010; descr <= "INVALID 10";
	#80 	{d, c, b, a} <= 4'b1011; descr <= "INVALID 11";
	#80 	{d, c, b, a} <= 4'b1100; descr <= "INVALID 12";
	#80 	{d, c, b, a} <= 4'b1101; descr <= "INVALID 13";
	#80 	{d, c, b, a} <= 4'b1110; descr <= "INVALID 14";
	#80 	{d, c, b, a} <= 4'b1111; descr <= "INVALID 15";
end

endmodule


