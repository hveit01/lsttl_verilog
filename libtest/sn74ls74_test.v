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
// D FF with Preset/Clear
`timescale 1ns / 100ps
`include "sn74ls74.v"

module sn74ls74_testbench;
reg [80*8-1:0] descr;
reg d, clk, clr, pre;
wire q, q_;

sn74ls74 dut(.q(q), .q_(q_), .d(d), .clk(clk), .clr(clr), .pre(pre));

initial
begin
	{d, clk, clr, pre} <= 4'b0_0_01; descr <= "INIT";

	$dumpfile("sn74ls74.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: d=%1b clk=%1b clr=%1b pre=%1b| q=%1b q_=%1b | %0s", $time, d, clk, clr, pre, q, q_, descr);
	
	#50 	{d, clk, clr, pre} <= 4'bx_x_0_0; descr <= "PRE=CLR=0";
	#50 	{d, clk, clr, pre} <= 4'bx_x_0_1; descr <= "PRE=1 CLR=0";
	#50 	{d, clk, clr, pre} <= 4'bx_x_1_0; descr <= "PRE=0 CLR=1";
	#50 	{d, clk, clr, pre} <= 4'bx_0_0_1; descr <= "HOLD WHILE CLR=0";
	#50 	{d, clk, clr, pre} <= 4'bx_1_0_1; descr <= "^";
	#50 	{d, clk, clr, pre} <= 4'bx_0_0_1; descr <= "v";
	#50 	{d, clk, clr, pre} <= 4'bx_0_1_0; descr <= "HOLD WHILE PRE=0";
	#50 	{d, clk, clr, pre} <= 4'bx_1_1_0; descr <= "^";
	#50 	{d, clk, clr, pre} <= 4'bx_0_1_0; descr <= "v";
	#50 	{d, clk, clr, pre} <= 4'bx_0_1_1; descr <= "PRE=CLR=1";
	#50 	{d, clk, clr, pre} <= 4'b0_0_1_1; descr <= "D=0";
	#50 	{d, clk, clr, pre} <= 4'b0_1_1_1; descr <= "^";
	#50 	{d, clk, clr, pre} <= 4'bx_0_1_1; descr <= "v";
	#50 	{d, clk, clr, pre} <= 4'b1_0_1_1; descr <= "D=1";
	#50 	{d, clk, clr, pre} <= 4'b1_1_1_1; descr <= "^";
	#50 	{d, clk, clr, pre} <= 4'bx_0_1_1; descr <= "v";
	#50 	{d, clk, clr, pre} <= 4'b0_0_1_1; descr <= "D=0";
	#50 	{d, clk, clr, pre} <= 4'b0_1_1_1; descr <= "^";
	#50 	{d, clk, clr, pre} <= 4'bx_0_1_1; descr <= "v";
end

endmodule


