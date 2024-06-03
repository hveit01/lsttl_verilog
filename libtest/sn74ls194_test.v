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
// 4 bit bidirectional shift register
`timescale 1ns / 100ps
`include "sn74ls194.v"

module sn74ls194_testbench;
reg [80*8-1:0] descr;
reg [3:0] d;
reg r, l, clk, clr, s1, s0;
wire [3:0] q;

sn74ls194 dut(.q(q), .clr(clr), .r(r), .l(l), .d(d), .clk(clk), .s1(s1), .s0(s0));

initial
begin
	#1		{clr, s1, s0, clk, l, r, d} <= 10'bx_x_x_x_x_x_xxxx; descr <= "";

	$dumpfile("sn74ls194.vcd");
	$dumpvars;
	$monitor("T=%5g: clr=%1b s1,s0=%1b%1b clk=%1b l=%1b r=%1b d=%4b | q=%4b | %0s", $time, clr, s1, s0, clk, l, r, d, q, descr);
	
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b0_x_x_x_x_x_xxxx; descr <= "clear";

	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_1_1_0_x_x_0101; descr <= "load 0101";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_1_1_1_x_x_0101; descr <= "";

	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_1_0_x_0_xxxx; descr <= "shift right 0";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_1_1_x_0_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_1_0_x_1_xxxx; descr <= "shift right 1";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_1_1_x_1_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_1_0_x_0_xxxx; descr <= "shift right 0";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_1_1_x_0_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_1_0_x_0_xxxx; descr <= "shift right 0";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_1_1_x_0_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_1_0_x_0_xxxx; descr <= "shift right 0";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_1_1_x_0_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_1_0_x_0_xxxx; descr <= "shift right 0";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_1_1_x_0_xxxx; descr <= "";

	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_1_0_0_1_x_xxxx; descr <= "shift left 1";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_1_0_1_1_x_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_1_0_0_0_x_xxxx; descr <= "shift left 0";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_1_0_1_0_x_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_1_0_0_1_x_xxxx; descr <= "shift left 1";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_1_0_1_1_x_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_1_0_0_1_x_xxxx; descr <= "shift left 1";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_1_0_1_1_x_xxxx; descr <= "";

	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_0_0_0_1_xxxx; descr <= "inhibit";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_0_1_0_1_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_0_0_1_0_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_0_1_1_0_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_0_0_0_1_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_0_1_0_1_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_0_0_1_1_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b1_0_0_1_1_1_xxxx; descr <= "";
	#80 	{clr, s1, s0, clk, l, r, d} <= 10'b0_x_x_x_x_x_xxxx; descr <= "clear";
end

endmodule


