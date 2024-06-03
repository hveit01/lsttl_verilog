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
// binary counter with output register
`timescale 1ns / 100ps
`include "sn74ls590.v"

module sn74ls590_testbench;
reg [80*8-1:0] descr;
reg cck, rck, cclr, g, ccken;
wire [7:0] q;
wire rco;

integer i;
sn74ls590 dut(.q(q), .rco(rco), .cck(cck), .rck(rck), .cclr(cclr), .g(g), .ccken(ccken));

initial
begin
	{cck, rck, cclr, ccken, g} <= 5'bx_x_x_x_x; descr <= "INIT";
	i = 0;

	$dumpfile("sn74ls590.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: cck=%1b rck=%1b cclr=%1b g=%1b ccken=%1b | q=%8b rco=%1b cnt=%8b | %0s",
		$time, cck, rck, cclr, g, ccken, q, rco, dut.cnt, descr);
	#1	{cck, rck, cclr, ccken, g} <= 5'bx_0_0_1_1; descr <= "cclr";
	#1	$display(">>>> count to 5, then sample cnt");
	for(i=0; i<5; i=i+1) begin
		#50	{cck, rck, cclr, ccken, g} <= 5'b0_0_1_0_1; descr <= "count, output disabled";
		#50 {cck, rck, cclr, ccken, g} <= 5'b1_0_1_0_1; descr <= "";
	end
	#50	{cck, rck, cclr, ccken, g} <= 5'bx_0_1_1_1; descr <= "sample counter";
	#50	{cck, rck, cclr, ccken, g} <= 5'bx_1_1_1_1; descr <= "";
	#50	{cck, rck, cclr, ccken, g} <= 5'bx_1_1_1_0; descr <= "enable output";
		$display(">>>> count up to 254, to check RCO");

	for(i=6; i<255; i=i+1) begin
		#50	{cck, rck, cclr, ccken, g} <= 5'b0_0_1_0_0; descr <= "count, no sample";
		#50 {cck, rck, cclr, ccken, g} <= 5'b1_0_1_0_0; descr <= "";
	end
	#50 $display(">>>> RCO coming soon");
		{cck, rck, cclr, ccken, g} <= 5'bx_0_1_1_0; descr <= "sample counter";
	#50	{cck, rck, cclr, ccken, g} <= 5'bx_1_1_1_0;
	#50	{cck, rck, cclr, ccken, g} <= 5'b0_0_1_0_0; descr <= "count=254";
	#50 {cck, rck, cclr, ccken, g} <= 5'b1_0_1_0_0; descr <= "";
	#50	{cck, rck, cclr, ccken, g} <= 5'bx_0_1_1_0;
	#50	{cck, rck, cclr, ccken, g} <= 5'bx_1_1_1_0;
	#50	{cck, rck, cclr, ccken, g} <= 5'b0_0_1_0_0; descr <= "count=255";
	#50 {cck, rck, cclr, ccken, g} <= 5'b1_0_1_0_0; descr <= "";
	#50	{cck, rck, cclr, ccken, g} <= 5'bx_0_1_1_0;
	#50	{cck, rck, cclr, ccken, g} <= 5'bx_1_1_1_0;
	#50	{cck, rck, cclr, ccken, g} <= 5'b0_0_1_0_0; descr <= "count=0";
	#50 {cck, rck, cclr, ccken, g} <= 5'b1_0_1_0_0; descr <= "";
	#50	{cck, rck, cclr, ccken, g} <= 5'bx_0_1_1_0;
	#50	{cck, rck, cclr, ccken, g} <= 5'bx_1_1_1_0;
	
end

endmodule


