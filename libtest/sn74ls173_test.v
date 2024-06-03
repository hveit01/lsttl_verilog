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
// 4bit d register with clear, enable and tristate
`timescale 1ns / 100ps
`include "sn74ls173.v"

module sn74ls173_testbench;
reg [80*8-1:0] descr;
reg [3:0] d;
reg clk, clr, ie1, ie2, oe1, oe2;
wire [3:0] q;

sn74ls173 dut(.q(q), .d(d), .clk(clk), .clr(clr), .ie1(ie1), .ie2(ie2), .oe1(oe1), .oe2(oe2));

initial
begin
	#1		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'bx_x_xxxx_xx_xx; descr <= "";

	$dumpfile("sn74ls173.vcd");
	$dumpvars;
	$monitor("T=%5g: clr=%1b clk=%1b d=%4b ie=%1b%1b oe=%1b%1b | q=%4b | %0s", $time, clr, clk, d, ie1, ie2, oe1, oe2, q, descr);
	
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b1_x_xxxx_xx_00; descr <= "clear";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_0_xxxx_xx_00; descr <= "load 1010";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_1_1010_00_00; descr <= "";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_0_xxxx_xx_00; descr <= "load 0101";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_1_0101_00_00; descr <= "";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_0_xxxx_1x_00; descr <= "no change (ie1=1)";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_1_xxxx_1x_00; descr <= "";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_0_xxxx_x1_00; descr <= "no change (ie2=1)";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_1_xxxx_x1_00; descr <= "";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_0_xxxx_11_1x; descr <= "oe1=1";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_1_xxxx_11_1x; descr <= "";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_0_xxxx_11_x1; descr <= "oe2=1";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_1_xxxx_11_x1; descr <= "";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_0_xxxx_xx_11; descr <= "load with oe*=1";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_1_1111_00_11; descr <= "";
	#50		{clr, clk, d, ie1, ie2, oe1, oe2} <= 10'b0_0_xxxx_11_00; descr <= "show loaded";
end

endmodule


