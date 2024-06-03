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
// 4 bit register with clear
`timescale 1ns / 100ps
`include "sn74ls171.v"

module sn74ls171_testbench;
reg [80*8-1:0] descr;
reg [3:0] d;
reg clk, clr;
wire [3:0] q, q_;

sn74ls171 dut(.q(q), .q_(q_), .d(d), .clk(clk), .clr(clr));

initial
begin
	#1		{clr, clk, d} <= 6'bx_x_xxxx; descr <= "";

	$dumpfile("sn74ls171.vcd");
	$dumpvars;
	$monitor("T=%5g: clr=%1b clk=%1b d=%4b | q=%4b q_=%4b | %0s", $time, clr, clk, d, q, q_, descr);
	
	#50		{clr, clk, d} <= 6'b0_x_xxxx; descr <= "clear";
	#50		{clr, clk, d} <= 6'b1_0_xxxx; descr <= "";
	#50		{clr, clk, d} <= 6'b1_1_1010; descr <= "load 1010";
	#50		{clr, clk, d} <= 6'b1_0_xxxx; descr <= "";
	#50		{clr, clk, d} <= 6'b1_1_0101; descr <= "load 0101";
	#50		{clr, clk, d} <= 6'b1_0_xxxx; descr <= "";
	#50		{clr, clk, d} <= 6'b1_1_0000; descr <= "load 0000";
	#50		{clr, clk, d} <= 6'b1_0_xxxx; descr <= "";
	#50		{clr, clk, d} <= 6'b1_1_1111; descr <= "load 1111";
	#50		{clr, clk, d} <= 6'b1_0_xxxx; descr <= "";
	#50		{clr, clk, d} <= 6'b0_x_xxxx; descr <= "clear";
end

endmodule


