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
// 8bit l/r shiftregister tristate
`timescale 1ns / 100ps
`include "sn74ls323.v"

module sn74ls323_testbench;
reg [80*8-1:0] descr;
reg [7:0] in;
reg s1, s0, clk, clr, g1, g2, sl, sr;
wire [7:0] bus;

sn74ls323 dut(.qa(qa), .qh(qh), .qio(bus), .clr(clr), .s1(s1), .s0(s0), .g1(g1), .g2(g2), .clk(clk), .sl(sl), .sr(sr));
assign bus = in;

initial
begin
	#1	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'bx_xx_xx_x_xx_xxxxxxxx; descr <= "INIT";

	$dumpfile("sn74ls323.vcd");
	$dumpvars;
	$monitor("T=%5g: clr=%1b s=%1b%1b g=%1b%1b clk=%1b sl=%1b sr=%1b in=%8b | q=%8b qa=%1b qh=%1b | %0s", 
		$time, clr, s1, s0, g1, g2, clk, sl, sr, in, bus, qa, qh, descr);
	
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b0_x0_00_0_xx_zzzzzzzz; descr <= "clear";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b0_x0_00_1_xx_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_0_x1_zzzzzzzz; descr <= "shift right 1";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_1_x1_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b0_0x_00_0_xx_zzzzzzzz; descr <= "clear";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b0_0x_00_1_xx_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_0_x1_zzzzzzzz; descr <= "shift right 1";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_1_x1_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b0_11_00_0_xx_zzzzzzzz; descr <= "clear";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b0_11_00_1_xx_zzzzzzzz; descr <= "";
	
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_00_00_x_xx_zzzzzzzz; descr <= "hold";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_xx_00_0_xx_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_0_x1_zzzzzzzz; descr <= "shift right 1";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_1_x1_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_0_x1_zzzzzzzz; descr <= "shift right 1";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_1_x1_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_0_x0_zzzzzzzz; descr <= "shift right 0";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_1_x0_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_0_x1_zzzzzzzz; descr <= "shift right 1";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_1_x1_zzzzzzzz; descr <= "";

	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_10_00_0_0x_zzzzzzzz; descr <= "shift left 0";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_10_00_1_0x_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_10_00_0_1x_zzzzzzzz; descr <= "shift left 1";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_10_00_1_1x_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_10_00_0_0x_zzzzzzzz; descr <= "shift left 0";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_10_00_1_0x_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_10_00_0_1x_zzzzzzzz; descr <= "shift left 1";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_10_00_1_1x_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_11_00_0_xx_11001010; descr <= "load 11001010";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_11_00_1_xx_11001010; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_0_x1_zzzzzzzz; descr <= "shift right 1";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_01_00_1_x1_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_10_00_0_0x_zzzzzzzz; descr <= "shift left 0";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_10_00_1_0x_zzzzzzzz; descr <= "";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_00_1x_x_xx_zzzzzzzz; descr <= "output disable g1";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_00_00_x_xx_zzzzzzzz; descr <= "hold";
	#50	{clr, s1, s0, g1, g2, clk, sl, sr, in} <= 16'b1_00_x1_x_xx_zzzzzzzz; descr <= "output disable g2";
end

endmodule


