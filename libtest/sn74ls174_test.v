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
// 6bit register with clear
`timescale 1ns / 100ps
`include "sn74ls174.v"

module sn74ls174_testbench;
reg [80*8-1:0] descr;
reg [5:0] d;
reg clk, clr;
wire [5:0] q;

sn74ls174 dut(.q(q), .d(d), .clk(clk), .clr(clr));

initial
begin
	#1		{clr, clk, d} <= 8'bx_x_xxxxxx; descr <= "";

	$dumpfile("sn74ls174.vcd");
	$dumpvars;
	$monitor("T=%5g: clr=%1b clk=%1b d=%6b | q=%6b | %0s", $time, clr, clk, d, q, descr);
	
	#50		{clr, clk, d} <= 8'b0_x_xxxxxx; descr <= "clear";
	#50		{clr, clk, d} <= 8'b1_0_xxxxxx; descr <= "";
	#50		{clr, clk, d} <= 8'b1_1_101010; descr <= "load 101010";
	#50		{clr, clk, d} <= 8'b1_0_xxxxxx; descr <= "";
	#50		{clr, clk, d} <= 8'b1_1_010101; descr <= "load 010101";
	#50		{clr, clk, d} <= 8'b1_0_xxxxxx; descr <= "";
	#50		{clr, clk, d} <= 8'b1_1_000000; descr <= "load 000000";
	#50		{clr, clk, d} <= 8'b1_0_xxxxxx; descr <= "";
	#50		{clr, clk, d} <= 8'b1_1_111111; descr <= "load 111111";
	#50		{clr, clk, d} <= 8'b1_0_xxxxxx; descr <= "";
	#50		{clr, clk, d} <= 8'b0_x_xxxxxx; descr <= "clear";
end

endmodule


