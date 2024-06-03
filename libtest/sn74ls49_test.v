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
// BCD 7segment decoder test bench
`timescale 1ns / 100ps
`include "sn74ls49.v"

module sn74ls49_testbench;
reg [80*8-1:0] descr;
reg a, b, c, d, bi;
wire [6:0] y;

sn74ls49 dut(.y(y), .a(a), .b(b), .c(c), .d(d), .bi(bi));

initial
begin
	{d, c, b, a, bi} <= 5'b0000_1; descr <= "INIT";

	$dumpfile("sn74ls49.vcd");
	$dumpvars;
	$monitor("T=%4g: DCBA=%1b%1b%1b%1b bi=%1b | abcdefg=%6b | %0s", $time, d, c, b, a, bi, y, descr);
	
	#250 	{d, c, b, a, bi} <= 5'bxxxx_0; descr <= "BI Test";
	#250 	{d, c, b, a, bi} <= 5'b0000_1; descr <= "0";
	#250 	{d, c, b, a, bi} <= 5'b0001_1; descr <= "1";
	#250 	{d, c, b, a, bi} <= 5'b0010_1; descr <= "2";
	#250 	{d, c, b, a, bi} <= 5'b0011_1; descr <= "3";
	#250 	{d, c, b, a, bi} <= 5'b0100_1; descr <= "4";
	#250 	{d, c, b, a, bi} <= 5'b0101_1; descr <= "5";
	#250 	{d, c, b, a, bi} <= 5'b0110_1; descr <= "6";
	#250	{d, c, b, a, bi} <= 5'b0111_1; descr <= "7";
	#250 	{d, c, b, a, bi} <= 5'b1000_1; descr <= "8";
	#250 	{d, c, b, a, bi} <= 5'b1001_1; descr <= "9";
	#250 	{d, c, b, a, bi} <= 5'b1010_1; descr <= "INVALID 10";
	#250 	{d, c, b, a, bi} <= 5'b1011_1; descr <= "INVALID 11";
	#250 	{d, c, b, a, bi} <= 5'b1100_1; descr <= "INVALID 12";
	#250 	{d, c, b, a, bi} <= 5'b1101_1; descr <= "INVALID 13";
	#250 	{d, c, b, a, bi} <= 5'b1110_1; descr <= "INVALID 14";
	#250 	{d, c, b, a, bi} <= 5'b1111_1; descr <= "INVALID 15";
end

endmodule


