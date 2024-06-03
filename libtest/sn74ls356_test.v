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
// 8 bit dff with addressable output, tristate
`timescale 1ns / 100ps
`include "sn74ls356.v"

module sn74ls356_testbench;
reg [80*8-1:0] descr;
reg [7:0] d;
reg s2, s1, s0, g1_, g2_, g3, clk, sc;
wire y, w;

sn74ls356 dut(.d(d), .s2(s2), .s1(s1), .s0(s0), .g1_(g1_), .g2_(g2_), .g3(g3), .clk(clk), .sc(sc), .y(y), .w(w));

initial
begin

	$dumpfile("sn74ls356.vcd");
	$dumpvars;
	$monitor("T=%5g: s=%1b%1b%1b sc=%1b clk=%1b g1_=%1b g2_=%1b g3=%1b d=%8b | y=%1b w=%1b | %0s", 
		$time, s2, s1, s0, sc, clk, g1_, g2_, g3, d, y, w, descr);
	
	#1			{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'bxxx_xx_xxx_xxxxxxxx; descr <= "INIT";

	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'bxxx_xx_1xx_xxxxxxxx; descr <= "tristate";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'bxxx_xx_x1x_xxxxxxxx; descr <= "tristate";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'bxxx_xx_xx0_xxxxxxxx; descr <= "tristate";

	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b000_00_001_xxxxxxx0; descr <= "load D0";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b000_01_001_xxxxxxx1; descr <= "";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b001_00_001_xxxxxx0x; descr <= "load D1";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b001_01_001_xxxxxx1x; descr <= "";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b010_00_001_xxxxx0xx; descr <= "load D2";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b010_01_001_xxxxx1xx; descr <= "";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b011_00_001_xxxx0xxx; descr <= "load D3";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b011_01_001_xxxx1xxx; descr <= "";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b100_00_001_xxx0xxxx; descr <= "load D4";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b100_01_001_xxx1xxxx; descr <= "";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b101_00_001_xx0xxxxx; descr <= "load D5";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b101_01_001_xx1xxxxx; descr <= "";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b110_00_001_x0xxxxxx; descr <= "load D6";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b110_01_001_x1xxxxxx; descr <= "";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b111_00_001_0xxxxxxx; descr <= "load D7";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b111_01_001_xxxxxxxx; descr <= "";

	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'bxxx_00_001_11000011; descr <= "load pattern 11000011";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'bxxx_01_001_11000011; descr <= "";

	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b000_01_001_xxxxxxxx; descr <= "select D0";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b001_01_001_xxxxxxxx; descr <= "select D1";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b010_01_001_xxxxxxxx; descr <= "select D2";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b011_01_001_xxxxxxxx; descr <= "select D3";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b100_01_001_xxxxxxxx; descr <= "select D4";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b101_01_001_xxxxxxxx; descr <= "select D5";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b110_01_001_xxxxxxxx; descr <= "select D6";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b111_01_001_xxxxxxxx; descr <= "select D7";

	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b100_11_001_xxxxxxxx; descr <= "latch select D4";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'bxxx_11_001_xxxxxxxx; descr <= "hold selected";
	#100		{s2, s1, s0, sc, clk, g1_, g2_, g3, d} <= 16'b001_01_001_xxxxxxxx; descr <= "select D1";

end

endmodule


