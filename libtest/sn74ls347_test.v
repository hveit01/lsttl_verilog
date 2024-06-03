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
// BCD 7segment decoder test bench
`timescale 1ns / 100ps
`include "sn74ls347.v"

module sn74ls347_testbench;
reg [80*8-1:0] descr;
reg a, b, c, d, lt, rbi, bi;
wire [6:0] y;
wire rbobi;

sn74ls347 dut(.y(y), .a(a), .b(b), .c(c), .d(d), .lt(lt), .rbi(rbi), .rbobi(rbobi));
pullup(y[0]);
pullup(y[1]);
pullup(y[2]);
pullup(y[3]);
pullup(y[4]);
pullup(y[5]);
pullup(y[6]);
assign (strong0, highz1) rbobi = bi;
pullup(rbobi);

initial
begin
	#1		{lt, rbi, d, c, b, a, bi} <= 7'b1_x_1111_1; descr <= "INIT";

	$dumpfile("sn74ls347.vcd");
	$dumpvars;
	$monitor("T=%4g: lt=%1b rbi=%1b DCBA=%1b%1b%1b%1b bi=%1b | abcdefg=%6b rbo/bi=%1b | %0s", $time, lt, rbi, d, c, b, a, bi, y, rbobi, descr);
	
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_1_0000_1; descr <= "0";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_0001_1; descr <= "1";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_0010_1; descr <= "2";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_0011_1; descr <= "3";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_0100_1; descr <= "4";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_0101_1; descr <= "5";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_0110_1; descr <= "6";
	#250	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_0111_1; descr <= "7";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_1000_1; descr <= "8";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_1001_1; descr <= "9";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_1010_1; descr <= "INVALID 10";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_1011_1; descr <= "INVALID 11";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_1100_1; descr <= "INVALID 12";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_1101_1; descr <= "INVALID 13";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_1110_1; descr <= "INVALID 14";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_x_1111_1; descr <= "INVALID 15";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'bx_x_xxxx_0; descr <= "BI Test";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b1_0_0000_0; descr <= "RBI";
	#250 	{lt, rbi, d, c, b, a, bi} <= 7'b0_x_xxxx_1; descr <= "LT";
end

endmodule


