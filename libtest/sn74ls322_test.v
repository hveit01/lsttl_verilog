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
`include "sn74ls322.v"

module sn74ls322_testbench;
reg [80*8-1:0] descr;
reg [7:0] in;
reg clr, g, sp, se, ds, oe, clk, d1, d0;
wire [7:0] bus;
wire qh;

sn74ls322 dut(.qh(qh), .qio(bus), .clr(clr), .g(g), .sp(sp), .se(se), .ds(ds), .oe(oe), .clk(clk), .d1(d1), .d0(d0));
assign bus = in;

initial
begin
	#1	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'bx_x_x_x_x_x_x_xx_xxxxxxxx; descr <= "INIT";

	$dumpfile("sn74ls322.vcd");
	$dumpvars;
	$monitor("T=%5g: clr=%1b g=%1b sp=%1b se=%1b ds=%1b oe=%1b clk=%1b d0=%1b d1=%1b in=%8b | q=%8b qh=%1b | %0s", 
		$time, clr, g, sp, se, ds, oe, clk, d0, d1, in, bus, qh, descr);
	
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b0_1_x_x_x_0_x_xx_zzzzzzzz; descr <= "clear";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b0_x_1_x_x_0_x_xx_zzzzzzzz; descr <= "";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_1_x_x_x_0_x_xx_zzzzzzzz; descr <= "hold";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_1_1_0_0_0_x0_zzzzzzzz; descr <= "shift right d0=0";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_1_1_0_0_1_x0_zzzzzzzz; descr <= "";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_1_1_1_0_0_1x_zzzzzzzz; descr <= "shift right d1=1";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_1_1_1_0_1_1x_zzzzzzzz; descr <= "";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_1_1_0_0_0_x0_zzzzzzzz; descr <= "shift right d0=0";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_1_1_0_0_1_x0_zzzzzzzz; descr <= "";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_1_1_1_0_0_1x_zzzzzzzz; descr <= "shift right d1=1";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_1_1_1_0_1_1x_zzzzzzzz; descr <= "";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_1_0_x_0_0_xx_zzzzzzzz; descr <= "sign extend";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_1_0_x_0_1_xx_zzzzzzzz; descr <= "";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_1_0_x_0_0_xx_zzzzzzzz; descr <= "sign extend";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_1_0_x_0_1_xx_zzzzzzzz; descr <= "";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_0_x_x_0_0_xx_10110101; descr <= "load 10110101";
	#50	{clr, g, sp, se, ds, oe, clk, d1, d0, in} <= 17'b1_0_0_x_x_0_1_xx_10110101; descr <= "";

end

endmodule


