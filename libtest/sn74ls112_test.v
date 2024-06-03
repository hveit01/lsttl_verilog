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
// JK FF with Preset/Clear
`timescale 1ns / 100ps
`include "sn74ls112.v"

module sn74ls112_testbench;
reg [80*8-1:0] descr;
reg j, k, clk, clr, pre;
wire q,q_;

sn74ls112 dut(.q(q), .q_(q_), .j(j), .k(k), .clk(clk), .clr(clr), .pre(pre));

initial
begin
	{j, k, clk, clr, pre} <= 5'b00_0_01; descr <= "INIT";

	$dumpfile("sn74ls112.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: j=%1b k=%1b clk=%1b clr=%1b pre=%1b| q=%1b q_=%1b | %0s", $time, j, k, clk, clr, pre, q, q_, descr);
	
	#30 	{j, k, clk, clr, pre} <= 5'bxx_0_11; descr <= "PRE=CLR=1";
	#30 	{j, k, clk, clr, pre} <= 5'bxx_x_00; descr <= "PRE=CLR=0";

	#30 	{j, k, clk, clr, pre} <= 5'bxx_0_10; descr <= "HOLD WHILE PRE=0";
	#30 	{j, k, clk, clr, pre} <= 5'bxx_1_10; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 5'bxx_0_10; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 5'bxx_0_01; descr <= "HOLD WHILE CLR=0";
	#30 	{j, k, clk, clr, pre} <= 5'bxx_1_01; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 5'bxx_0_01; descr <= "v";

	#30 	{j, k, clk, clr, pre} <= 5'bxx_0_11; descr <= "PRE=CLR=1";

	#30 	{j, k, clk, clr, pre} <= 5'b00_0_11; descr <= "J=0 K=0 NO CHANGE";
	#30 	{j, k, clk, clr, pre} <= 5'b00_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 5'b00_0_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 5'b10_0_11; descr <= "J=1, K=0 SET";
	#30 	{j, k, clk, clr, pre} <= 5'b10_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 5'b10_0_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 5'b01_0_11; descr <= "J=0, K=1 CLEAR";
	#30 	{j, k, clk, clr, pre} <= 5'b01_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 5'b01_0_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 5'b11_0_11; descr <= "J=1, K=1 TOGGLE";
	#30 	{j, k, clk, clr, pre} <= 5'b11_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 5'b11_0_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 5'b11_0_11; descr <= "J=1, K=1 TOGGLE";
	#30 	{j, k, clk, clr, pre} <= 5'b11_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 5'b11_0_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 5'b11_0_11; descr <= "J=1, K=1 TOGGLE";
	#30 	{j, k, clk, clr, pre} <= 5'b11_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 5'b11_0_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 5'bxx_x_01; descr <= "RESET";
end

endmodule


