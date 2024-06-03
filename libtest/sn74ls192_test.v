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
`include "sn74ls192.v"

module sn74ls192_testbench;
reg [80*8-1:0] descr;
reg [3:0] d;
reg up, dn, clr, load;
wire [3:0] q;
wire carry, borrow;

sn74ls192 dut(.q(q), .carry(carry), .borrow(borrow), .d(d), .up(up), .dn(dn), .clr(clr), .load(load));

initial
begin
	#1		{clr, load, up, dn, d} <= 8'bx_x_x_x_xxxx; descr <= "";

	$dumpfile("sn74ls192.vcd");
	$dumpvars;
	$monitor("T=%5g: clr=%1b load=%1b up=%1b dn=%1b d=%4b | q=%4b cy=%1b bo=%1b %4b | %0s", $time, clr, load, up, dn, d, q, carry, borrow, dut.cnt, descr);
	
	#80 	{clr, load, up, dn, d} <= 8'b1_x_x_x_xxxx; descr <= "clr";
	#80 	{clr, load, up, dn, d} <= 8'b0_0_x_x_0111; descr <= "load 7";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "count up";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_0_1_xxxx; descr <= "";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "count up";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_0_1_xxxx; descr <= "";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "count up";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_0_1_xxxx; descr <= "";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "count up";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_0_1_xxxx; descr <= "";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "count up";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_0_1_xxxx; descr <= "";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "no change";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "count dn";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_0_xxxx; descr <= "";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "count dn";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_0_xxxx; descr <= "";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "count dn";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_0_xxxx; descr <= "";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "count dn";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_0_xxxx; descr <= "";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_1_xxxx; descr <= "count dn";
	#80 	{clr, load, up, dn, d} <= 8'b0_1_1_0_xxxx; descr <= "";
end

endmodule


