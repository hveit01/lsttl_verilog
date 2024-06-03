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
// synchronous up/down decade counter
`timescale 1ns / 100ps
`include "sn74ls168.v"

module sn74ls168_testbench;
reg [80*8-1:0] descr;
reg [3:0] d;
reg updn, clk, ep, et, load;
wire [3:0] q;
wire rco;

sn74ls168 dut(.q(q), .rco(rco), .d(d), .updn(updn), .clk(clk), .ep(ep), .et(et), .load(load));

initial
begin
	#1		{updn, load, clk, ep, et, d} <= 9'b1_0_0_0_0_0101; descr <= "";
	#50		{updn, load, clk, ep, et, d} <= 9'b1_0_1_0_0_0101; descr <= "init 0101";

	$dumpfile("sn74ls168.vcd");
	$dumpvars;
	$monitor("T=%5g: updn=%1b load=%1b d=%4b clk=%1b ep=%1b et=%1b | q=%4b rco=%1b | %0s", $time, updn, load, d, clk, ep, et, q, rco, descr);
	
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_0_0_0_0_0111; descr <= "load 7";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_0_1_0_0_0111; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_0_0_0_0000; descr <= "count up";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_1_0_0_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_0_0_0_0000; descr <= "count up";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_1_0_0_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_0_0_0_0000; descr <= "count up";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_1_0_0_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_0_0_0_0000; descr <= "count up";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_1_0_0_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_0_0_0_0000; descr <= "count up";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_1_0_0_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_0_1_0_0000; descr <= "inhibit p";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_1_1_0_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_0_1_0_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_1_1_0_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_0_1_1_0000; descr <= "inhibit P, T";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_1_1_1_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_0_1_1_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_1_1_1_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_0_0_1_0000; descr <= "inhibit T";
	#50 	{updn, load, clk, ep, et, d} <= 9'b1_1_1_0_1_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b0_1_0_0_0_0000; descr <= "count dn";
	#50 	{updn, load, clk, ep, et, d} <= 9'b0_1_1_0_0_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b0_1_0_0_0_0000; descr <= "count dn";
	#50 	{updn, load, clk, ep, et, d} <= 9'b0_1_1_0_0_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b0_1_0_0_0_0000; descr <= "count dn";
	#50 	{updn, load, clk, ep, et, d} <= 9'b0_1_1_0_0_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b0_1_0_0_0_0000; descr <= "count dn";
	#50 	{updn, load, clk, ep, et, d} <= 9'b0_1_1_0_0_0000; descr <= "";
	#50 	{updn, load, clk, ep, et, d} <= 9'b0_1_0_0_0_0000; descr <= "count dn";
	#50 	{updn, load, clk, ep, et, d} <= 9'b0_1_1_0_0_0000; descr <= "";
end

endmodule


