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
// 8 bit latch with addressable output, open collector
`timescale 1ns / 100ps
`include "sn74ls355.v"

module sn74ls355_testbench;
reg [80*8-1:0] descr;
reg [7:0] d;
reg s2, s1, s0, g1_, g2_, g3, dc, sc;
wire ypu, yoc, wpu, woc;

sn74ls355 dutpu(.d(d), .s2(s2), .s1(s1), .s0(s0), .g1_(g1_), .g2_(g2_), .g3(g3), .dc(dc), .sc(sc), .y(ypu), .w(wpu));
pullup(ypu);
pullup(wpu);
sn74ls355 dutoc(.d(d), .s2(s2), .s1(s1), .s0(s0), .g1_(g1_), .g2_(g2_), .g3(g3), .dc(dc), .sc(sc), .y(yoc), .w(woc));

initial
begin

	$dumpfile("sn74ls355.vcd");
	$dumpvars;
	$monitor("T=%5g: s=%1b%1b%1b sc=%1b dc=%1b g1_=%1b g2_=%1b g3=%1b d=%8b | ypu=%1b wpu=%1b yoc=%1b woc=%1b | %0s", 
		$time, s2, s1, s0, sc, dc, g1_, g2_, g3, d, ypu, wpu, yoc, woc, descr);
	
	#1			{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'bxxx_xx_xxx_xxxxxxxx; descr <= "INIT";

	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'bxxx_xx_1xx_xxxxxxxx; descr <= "disabled";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'bxxx_xx_x1x_xxxxxxxx; descr <= "disabled";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'bxxx_xx_xx0_xxxxxxxx; descr <= "disabled";

	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b000_00_001_xxxxxxx0; descr <= "transparent D0";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b000_00_001_xxxxxxx1; descr <= "transparent D0";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b000_01_001_xxxxxxx1; descr <= "hold D0";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b001_00_001_xxxxxx0x; descr <= "transparent D1";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b001_00_001_xxxxxx1x; descr <= "transparent D1";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b001_01_001_xxxxxx1x; descr <= "hold D1";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b010_00_001_xxxxx0xx; descr <= "transparent D2";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b010_00_001_xxxxx1xx; descr <= "transparent D2";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b010_01_001_xxxxx1xx; descr <= "hold D2";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b011_00_001_xxxx0xxx; descr <= "transparent D3";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b011_00_001_xxxx1xxx; descr <= "transparent D3";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b011_01_001_xxxx1xxx; descr <= "hold D3";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b100_00_001_xxx0xxxx; descr <= "transparent D4";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b100_00_001_xxx1xxxx; descr <= "transparent D4";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b100_01_001_xxx1xxxx; descr <= "hold D4";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b101_00_001_xx0xxxxx; descr <= "transparent D5";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b101_00_001_xx1xxxxx; descr <= "transparent D5";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b101_01_001_xx1xxxxx; descr <= "hold D5";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b110_00_001_x0xxxxxx; descr <= "transparent D6";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b110_00_001_x1xxxxxx; descr <= "transparent D6";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b110_01_001_x1xxxxxx; descr <= "hold D6";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b111_00_001_0xxxxxxx; descr <= "transparent D7";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b111_00_001_0xxxxxxx; descr <= "transparent D7";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b111_01_001_xxxxxxxx; descr <= "hold D7";

	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'bxxx_00_001_11000011; descr <= "latch pattern 11000011";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'bxxx_01_001_11000011; descr <= "";

	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b000_01_001_xxxxxxxx; descr <= "select D0";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b001_01_001_xxxxxxxx; descr <= "select D1";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b010_01_001_xxxxxxxx; descr <= "select D2";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b011_01_001_xxxxxxxx; descr <= "select D3";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b100_01_001_xxxxxxxx; descr <= "select D4";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b101_01_001_xxxxxxxx; descr <= "select D5";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b110_01_001_xxxxxxxx; descr <= "select D6";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b111_01_001_xxxxxxxx; descr <= "select D7";

	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b100_11_001_xxxxxxxx; descr <= "latch select D4";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'bxxx_11_001_xxxxxxxx; descr <= "hold selected";
	#100		{s2, s1, s0, sc, dc, g1_, g2_, g3, d} <= 16'b001_01_001_xxxxxxxx; descr <= "select D1";

end

endmodule


