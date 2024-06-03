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
// JK FF with Preset
`timescale 1ns / 100ps
`include "sn74ls113.v"

module sn74ls113_testbench;
reg [80*8-1:0] descr;
reg j, k, clk, pre;
wire q,q_;

sn74ls113 dut(.q(q), .q_(q_), .j(j), .k(k), .clk(clk), .pre(pre));

initial
begin
	{j, k, clk, pre} <= 4'b00_0_1; descr <= "INIT";

	$dumpfile("sn74ls113.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: j=%1b k=%1b clk=%1b pre=%1b | q=%1b q_=%1b | %0s", $time, j, k, clk, pre, q, q_, descr);
	
	#30 	{j, k, clk, pre} <= 4'bxx_0_1; descr <= "PRE=1";
	#30 	{j, k, clk, pre} <= 4'bxx_x_0; descr <= "PRE=0";

	#30 	{j, k, clk, pre} <= 4'bxx_0_0; descr <= "HOLD WHILE PRE=0";
	#30 	{j, k, clk, pre} <= 4'bxx_1_0; descr <= "^";
	#30 	{j, k, clk, pre} <= 4'bxx_0_0; descr <= "v";

	#30 	{j, k, clk, pre} <= 4'bxx_0_1; descr <= "PRE=1";

	#30 	{j, k, clk, pre} <= 4'b00_0_1; descr <= "J=0 K=0 NO CHANGE";
	#30 	{j, k, clk, pre} <= 4'b00_1_1; descr <= "^";
	#30 	{j, k, clk, pre} <= 4'b00_0_1; descr <= "v";
	#30 	{j, k, clk, pre} <= 4'b01_0_1; descr <= "J=0, K=1 CLEAR";
	#30 	{j, k, clk, pre} <= 4'b01_1_1; descr <= "^";
	#30 	{j, k, clk, pre} <= 4'b01_0_1; descr <= "v";
	#30 	{j, k, clk, pre} <= 4'b10_0_1; descr <= "J=1, K=0 SET";
	#30 	{j, k, clk, pre} <= 4'b10_1_1; descr <= "^";
	#30 	{j, k, clk, pre} <= 4'b10_0_1; descr <= "v";
	#30 	{j, k, clk, pre} <= 4'b11_0_1; descr <= "J=1, K=1 TOGGLE";
	#30 	{j, k, clk, pre} <= 4'b11_1_1; descr <= "^";
	#30 	{j, k, clk, pre} <= 4'b11_0_1; descr <= "v";
	#30 	{j, k, clk, pre} <= 4'b11_0_1; descr <= "J=1, K=1 TOGGLE";
	#30 	{j, k, clk, pre} <= 4'b11_1_1; descr <= "^";
	#30 	{j, k, clk, pre} <= 4'b11_0_1; descr <= "v";
	#30 	{j, k, clk, pre} <= 4'b11_0_1; descr <= "J=1, K=1 TOGGLE";
	#30 	{j, k, clk, pre} <= 4'b11_1_1; descr <= "^";
	#30 	{j, k, clk, pre} <= 4'b11_0_1; descr <= "v";
	#30 	{j, k, clk, pre} <= 4'bxx_x_0; descr <= "PRESET";
end

endmodule


