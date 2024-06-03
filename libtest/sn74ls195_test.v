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
// 4 bit bidirectional shift register
`timescale 1ns / 100ps
`include "sn74ls195.v"

module sn74ls195_testbench;
reg [80*8-1:0] descr;
reg [3:0] d;
reg clr, load, clk, j, k_;
wire [3:0] q;
wire qd_;

sn74ls195 dut(.q(q), .qd_(qd_), .clr(clr), .load(load), .clk(clk), .j(j), .k_(k_), .d(d));

initial
begin
	#1		{clr, load, clk, j, k_, d} <= 9'bx_x_x_x_x_xxxx; descr <= "";

	$dumpfile("sn74ls195.vcd");
	$dumpvars;
	$monitor("T=%5g: clr=%1b load=%1b clk=%1b j=%1b k_=%1b d=%4b | qd_=%1b q=%4b | %0s", $time, clr, load, clk, j, k_, d, qd_, q, descr);
	
	#80		{clr, load, clk, j, k_, d} <= 9'b0_x_x_x_x_xxxx; descr <= "clear";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_0_0_0_xxxx; descr <= "shift jk=00";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_1_0_0_xxxx; descr <= "";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_0_1_1_xxxx; descr <= "shift jk=11";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_1_1_1_xxxx; descr <= "";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_0_0_0_xxxx; descr <= "shift jk=00";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_1_0_0_xxxx; descr <= "";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_0_0_0_xxxx; descr <= "shift jk=00";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_1_0_0_xxxx; descr <= "";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_0_0_0_xxxx; descr <= "shift jk=00";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_1_0_0_xxxx; descr <= "";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_0_0_0_xxxx; descr <= "shift jk=00";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_1_0_0_xxxx; descr <= "";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_0_0_x_x_0101; descr <= "load 0101";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_0_1_x_x_0101; descr <= "";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_0_0_0_xxxx; descr <= "shift jk=00";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_1_0_0_xxxx; descr <= "";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_0_0_0_xxxx; descr <= "shift jk=00";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_1_0_0_xxxx; descr <= "";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_0_0_0_xxxx; descr <= "shift jk=00";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_1_0_0_xxxx; descr <= "";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_0_0_0_xxxx; descr <= "shift jk=00";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_1_0_0_xxxx; descr <= "";

	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_0_1_0_xxxx; descr <= "shift jk=10";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_1_1_0_xxxx; descr <= "";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_0_0_1_xxxx; descr <= "shift jk=10";
	#80		{clr, load, clk, j, k_, d} <= 9'b1_1_1_0_1_xxxx; descr <= "";

end

endmodule


