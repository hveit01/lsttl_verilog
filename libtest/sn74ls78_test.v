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
// Dual JK MS FF with Preset and common Clk/Clear
`timescale 1ns / 100ps
`include "sn74ls78.v"

module sn74ls78_testbench;
reg [80*8-1:0] descr;
reg [1:0] j, k, pre;
reg clk, clr;
wire [1:0] q, q_;

sn74ls78 dut(.q(q), .q_(q_), .j(j), .k(k), .clk(clk), .clr(clr), .pre(pre));

initial
begin
	{j, k, clk, clr, pre} <= 8'bxx_xx_0_0_11; descr <= "INIT";

	$dumpfile("sn74ls78.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: j=%2b k=%2b clk=%1b clr=%1b pre=%2b| q=%2b q_=%2b | %0s", $time, j, k, clk, clr, pre, q, q_, descr);
	
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_x_0_11; descr <= "CLR=0";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_0_11; descr <= "HOLD WHILE CLR=0";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_1_0_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_0_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_1_11; descr <= "CLR=1";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_x_1_01; descr <= "PRE1=0";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_00_0_1_01; descr <= "HOLD WHILE PRE1=0";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_00_1_1_01; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_1_01; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_x_1_10; descr <= "PRE2=0";
	#30 	{j, k, clk, clr, pre} <= 8'b00_xx_0_1_10; descr <= "HOLD WHILE PRE2=0";
	#30 	{j, k, clk, clr, pre} <= 8'b00_xx_1_1_10; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_1_10; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_1_11; descr <= "PRE=CLR=1";
	#30 	{j, k, clk, clr, pre} <= 8'b00_00_0_1_11; descr <= "J=0 K=0 NO CHANGE";
	#30 	{j, k, clk, clr, pre} <= 8'b00_00_1_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_00_0_1_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 8'b10_00_0_1_11; descr <= "J=1 K=0 FF1";
	#30 	{j, k, clk, clr, pre} <= 8'b10_00_1_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_1_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 8'b00_10_0_1_11; descr <= "J=1 K=0 FF2";
	#30 	{j, k, clk, clr, pre} <= 8'b00_10_1_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_1_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 8'b01_00_0_1_11; descr <= "J=0 K=1 FF1";
	#30 	{j, k, clk, clr, pre} <= 8'b01_00_1_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_1_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 8'b00_01_0_1_11; descr <= "J=0 K=1 FF2";
	#30 	{j, k, clk, clr, pre} <= 8'b00_01_1_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_1_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 8'b10_10_0_1_11; descr <= "J=1 K=1 TOGGLE FF1";
	#30 	{j, k, clk, clr, pre} <= 8'b10_10_1_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_1_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 8'b01_01_0_1_11; descr <= "J=1 K=1 TOGGLE FF2";
	#30 	{j, k, clk, clr, pre} <= 8'b01_01_1_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_1_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 8'b10_10_0_1_11; descr <= "J=1 K=1 TOGGLE FF1";
	#30 	{j, k, clk, clr, pre} <= 8'b10_10_1_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_1_11; descr <= "v";
	#30 	{j, k, clk, clr, pre} <= 8'b01_01_0_1_11; descr <= "J=1 K=1 TOGGLE FF2";
	#30 	{j, k, clk, clr, pre} <= 8'b01_01_1_1_11; descr <= "^";
	#30 	{j, k, clk, clr, pre} <= 8'bxx_xx_0_1_11; descr <= "v";
end

endmodule


