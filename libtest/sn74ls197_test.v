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
// binary counter
`timescale 1ns / 100ps
`include "sn74ls197.v"

module sn74ls197_testbench;
reg [80*8-1:0] descr;
reg [3:0] d;
reg clr, clk1, clk2, load;
wire [3:0] q;

sn74ls197 dut(.q(q), .d(d), .clr(clr), .clk1(clk1), .clk2(clk2), .load(load));

initial
begin
	#1		{clr, load, clk1, clk2, d} <= 8'bx_x_x_x_xxxx; descr <= "";

	$dumpfile("sn74ls197.vcd");
	$dumpvars;
	$monitor("T=%5g: clr=%1b load=%1b d=%4b clk1=%1b clk2=%1b | q=%4b | %0s", $time, clr, load, d, clk1, clk2, q, descr);
	$display("CLK1, CLK2 are separate and not connected to QA/QD");
	#100	{clr, load, clk1, clk2, d} <= 8'b0_x_x_x_xxxx; descr <= "clr";
	#100	{clr, load, clk1, clk2, d} <= 8'b1_0_x_x_0101; descr <= "init 0101";

	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_1_xxxx; descr <= "clock 1";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_0_1_xxxx; descr <= "";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_1_xxxx; descr <= "clock 1";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_0_1_xxxx; descr <= "";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_1_xxxx; descr <= "clock 1";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_0_1_xxxx; descr <= "";

	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_1_xxxx; descr <= "clock 2";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_0_xxxx; descr <= "";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_1_xxxx; descr <= "clock 2";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_0_xxxx; descr <= "";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_1_xxxx; descr <= "clock 2";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_0_xxxx; descr <= "";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_1_xxxx; descr <= "clock 2";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_0_xxxx; descr <= "";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_1_xxxx; descr <= "clock 2";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_0_xxxx; descr <= "";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_1_xxxx; descr <= "clock 2";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_0_xxxx; descr <= "";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_1_xxxx; descr <= "clock 2";
	#200	{clr, load, clk1, clk2, d} <= 8'b1_1_1_0_xxxx; descr <= "";



end

endmodule


