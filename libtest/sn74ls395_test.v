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
`include "sn74ls395.v"

module sn74ls395_testbench;
reg [80*8-1:0] descr;
reg [3:0] in;
reg clr, ldsh, clk, ser, oe;
wire [3:0] q;
wire qd;

sn74ls395 dut(.q(q), .qd(qd), .clr(clr), .in(in), .ldsh(ldsh), .clk(clk), .ser(ser), .oe(oe));

initial
begin
	#1	{oe, clr, ldsh, clk, ser, in} <= 9'bx_x_x_x_x_xxxx; descr <= "INIT";

	$dumpfile("sn74ls395.vcd");
	$dumpvars;
	$monitor("T=%5g: clr=%1b ldsh=%1b clk=%1b ser=%1b in=%4b | q=%4b qd=%1b | %0s", 
		$time, clr, ldsh, clk, ser, in, q, qd, descr);
	
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_0_x_x_x_xxxx; descr <= "clear";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_1_1_x_xxxx; descr <= "load 0011";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_1_0_x_0011; descr <= "";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_1_0_xxxx; descr <= "shift 0";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_0_0_xxxx; descr <= "";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_1_0_xxxx; descr <= "shift 0";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_0_0_xxxx; descr <= "";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_1_0_xxxx; descr <= "shift 0";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_0_0_xxxx; descr <= "";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_1_0_xxxx; descr <= "shift 0";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_0_0_xxxx; descr <= "";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_1_1_xxxx; descr <= "shift 1";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_0_1_xxxx; descr <= "";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_1_1_xxxx; descr <= "shift 1";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_0_1_xxxx; descr <= "";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_1_1_xxxx; descr <= "shift 1";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_0_1_xxxx; descr <= "";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_1_1_xxxx; descr <= "shift 1";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b0_1_0_0_1_xxxx; descr <= "";
	#50	{oe, clr, ldsh, clk, ser, in} <= 9'b1_1_0_1_1_xxxx; descr <= "tristate";
end

endmodule


