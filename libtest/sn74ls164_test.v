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
// 8 bit shift register
`timescale 1ns / 100ps
`include "sn74ls164.v"

module sn74ls164_testbench;
reg [80*8-1:0] descr;
reg clr, clk, s1, s2;
wire [7:0] q;

sn74ls164 dut(.q(q), .s1(s1), .s2(s2), .clr(clr), .clk(clk));

initial
begin
			{clr, clk, s1, s2} <= 4'bx_x_x_x; descr <= "init";

	$dumpfile("sn74ls164.vcd");
	$dumpvars;
	$monitor("T=%5g: clr=%1b clk=%1b s1=%1b s2=%1b | q=%8b | %0s", $time, clr, clk, s1, s2, q, descr);
	
	#40 	{clr, clk, s1, s2} <= 4'b0_x_x_x; descr <= "clear";
	#40 	{clr, clk, s1, s2} <= 4'b1_0_x_x; descr <= "no change";
	#40 	{clr, clk, s1, s2} <= 4'b1_0_1_1; descr <= "shift 1";
	#40 	{clr, clk, s1, s2} <= 4'b1_1_1_1; descr <= "";
	#40 	{clr, clk, s1, s2} <= 4'b1_0_0_x; descr <= "shift 0";
	#40 	{clr, clk, s1, s2} <= 4'b1_1_0_x; descr <= "";
	#40 	{clr, clk, s1, s2} <= 4'b1_0_x_0; descr <= "shift 0";
	#40 	{clr, clk, s1, s2} <= 4'b1_1_x_0; descr <= "";
	#40 	{clr, clk, s1, s2} <= 4'b1_0_1_1; descr <= "shift 1";
	#40 	{clr, clk, s1, s2} <= 4'b1_1_1_1; descr <= "";
	#40 	{clr, clk, s1, s2} <= 4'b1_0_1_1; descr <= "shift 1";
	#40 	{clr, clk, s1, s2} <= 4'b1_1_1_1; descr <= "";
	#40 	{clr, clk, s1, s2} <= 4'b1_0_1_1; descr <= "shift 1";
	#40 	{clr, clk, s1, s2} <= 4'b1_1_1_1; descr <= "";
	#40 	{clr, clk, s1, s2} <= 4'b1_0_1_1; descr <= "shift 1";
	#40 	{clr, clk, s1, s2} <= 4'b1_1_1_1; descr <= "";
	#40 	{clr, clk, s1, s2} <= 4'b1_0_1_1; descr <= "shift 1";
	#40 	{clr, clk, s1, s2} <= 4'b1_1_1_1; descr <= "";
	#40 	{clr, clk, s1, s2} <= 4'b1_0_0_0; descr <= "shift 0";
	#40 	{clr, clk, s1, s2} <= 4'b1_1_0_0; descr <= "";
end

endmodule


