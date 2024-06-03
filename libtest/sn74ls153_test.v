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
// 1 to 4 multiplexer
`timescale 1ns / 100ps
`include "sn74ls153.v"

module sn74ls153_testbench;
reg [80*8-1:0] descr;
reg [3:0] c;
reg a1, a0, g;
wire q;

sn74ls153 dut(.c(c), .a1(a1), .a0(a0), .g(g), .q(q));

initial
begin

	$dumpfile("sn74ls153.vcd");
	$dumpvars;
	$monitor("T=%5g: i=%4b a=%1b%1b g=%1b | q=%1b | %0s", $time, c, a1, a0, g, q, descr);
	
			{a1, a0, c, g} <= 7'bxx_xxxx_1; descr <= "INIT";
	#40 	{a1, a0, c, g} <= 7'b00_xxx0_0; descr <= "pass c0=0";
	#40 	{a1, a0, c, g} <= 7'b00_xxx1_0; descr <= "pass c0=1";
	#40 	{a1, a0, c, g} <= 7'b01_xx0x_0; descr <= "pass c1=0";
	#40 	{a1, a0, c, g} <= 7'b01_xx1x_0; descr <= "pass c1=1";
	#40 	{a1, a0, c, g} <= 7'b10_x0xx_0; descr <= "pass c2=0";
	#40 	{a1, a0, c, g} <= 7'b10_x1xx_0; descr <= "pass c2=1";
	#40 	{a1, a0, c, g} <= 7'b11_0xxx_0; descr <= "pass c3=0";
	#40 	{a1, a0, c, g} <= 7'b11_1xxx_0; descr <= "pass c3=1";

end

endmodule


