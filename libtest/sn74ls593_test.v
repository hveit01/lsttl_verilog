// This code is part of the model collection of simulatable TTL devices.
// Note this does not necessarily mean they are synthesizable!!!
//
// Copyright (C) 2024 Holger Veit (hveit01@web.de)
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
// binary counter with input register
`timescale 1ns / 100ps
`include "sn74ls593.v"

module sn74ls593_testbench;
reg [80*8-1:0] descr;
reg [7:0] in;
reg cck, rck, cclr, ccken, cload, g, g_;
wire [7:0] bus;
wire rco;

integer i;
sn74ls593 dut(.rco(rco), .cck(cck), .rck(rck), .cclr(cclr), .ccken(ccken), .cload(cload), .io(bus), .g(g), .g_(g_));
assign bus = in;

initial
begin
	{cck, rck, cclr, ccken, cload, g, g_, g, g_, in} <= 15'bx_x_x_x_x_xx_xxxxxxxx; descr <= "INIT";
	i = 0;

	$dumpfile("sn74ls593.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: cck=%1b rck=%1b cclr=%1b ccken=%1b cload=%1b in=%8b g=%1b g_=%1b | io=%8b rco=%1b cnt=%8b | %0s",
		$time, cck, rck, cclr, ccken, cload, in, g, g_, bus, rco, dut.cnt, descr);

	#1	$display(">>>> load 11110000");
	#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'bx_0_1_1_1_01_11110000; descr <= "set input reg";
	#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'bx_1_1_1_1_01_11110000; descr <= "";
	#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'bx_1_1_1_0_01_zzzzzzzz; descr <= "load into cnt";
	#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'bx_1_1_1_0_10_zzzzzzzz; descr <= "show cnt";
	
	#1	$monitor(""); $display("count 14 times to 11111110");
	for(i=0; i<14; i=i+1) begin
		#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'b0_x_1_0_1_01_zzzzzzzz; descr <= "count";
		#50 {cck, rck, cclr, ccken, cload, g, g_, in} <= 15'b1_x_1_0_1_01_zzzzzzzz; descr <= "";
	end
	#50	$monitor("T=%5t: cck=%1b rck=%1b cclr=%1b ccken=%1b cload=%1b g=%1b g_=%1b in=%8b | io=%8b rco=%1b cnt=%8b | %0s",
			$time, cck, rck, cclr, ccken, cload, g, g_, in, bus, rco, dut.cnt, descr);
		{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'b0_x_1_0_1_10_zzzzzzzz; descr <= "count";
	#50 {cck, rck, cclr, ccken, cload, g, g_, in} <= 15'b1_x_1_0_1_10_zzzzzzzz; descr <= "";
	#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'b0_x_1_0_1_10_zzzzzzzz; descr <= "count";
	#50 {cck, rck, cclr, ccken, cload, g, g_, in} <= 15'b1_x_1_0_1_10_zzzzzzzz; descr <= "";
	#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'b0_x_1_0_1_10_zzzzzzzz; descr <= "count";
	#50 {cck, rck, cclr, ccken, cload, g, g_, in} <= 15'b1_x_1_0_1_10_zzzzzzzz; descr <= "";
	#50	$display("clear and count");
		{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'bx_x_0_1_1_10_zzzzzzzz; descr <= "clear";
	#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'bx_0_1_1_1_10_zzzzzzzz; descr <= "load input reg from cnt (=0)";
	#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'bx_1_1_1_1_01_zzzzzzzz; descr <= "";
	#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'b0_1_1_0_1_10_zzzzzzzz; descr <= "count";
	#50 {cck, rck, cclr, ccken, cload, g, g_, in} <= 15'b1_1_1_0_1_10_zzzzzzzz; descr <= "";
	#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'b0_1_1_0_1_10_zzzzzzzz; descr <= "count";
	#50 {cck, rck, cclr, ccken, cload, g, g_, in} <= 15'b1_1_1_0_1_10_zzzzzzzz; descr <= "";
	#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'bx_1_1_1_0_10_zzzzzzzz; descr <= "reload into cnt (=0)";
	#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'bx_1_1_1_0_0x_zzzzzzzz; descr <= "bus disable";
	#50	{cck, rck, cclr, ccken, cload, g, g_, in} <= 15'bx_1_1_1_0_x1_zzzzzzzz; descr <= "bus disable";
	
end

endmodule


