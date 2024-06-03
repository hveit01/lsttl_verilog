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
// 4 bit register test bench
`timescale 1ns / 100ps
`include "sn74ls379.v"

module sn74ls379_testbench;
reg [80*8-1:0] descr;
reg [3:0] d;
reg clk, g;
wire [3:0] q, q_;

sn74ls379 dut(.q(q), .q_(q_), .d(d), .clk(clk), .g(g));

initial
begin
	$dumpfile("sn74ls379.vcd");
	$dumpvars;
	$monitor("T=%5T: g=%1b clk=%1b d=%4b | q=%4b q_=%4b | %0s", $time, g, clk, d, q, q_, descr);
	
	 		{g, clk, d} <= 6'bx_x_xxxx; descr <= "INIT";

	#50		{g, clk, d} <= 6'b0_0_xxxx; descr <= "load 1111";
	#50		{g, clk, d} <= 6'b0_1_1111; descr <= "";
	#50		{g, clk, d} <= 6'b1_0_xxxx; descr <= "disabled";
	#50		{g, clk, d} <= 6'b1_1_1110; descr <= "";
	#50		{g, clk, d} <= 6'b0_0_xxxx; descr <= "load 1010";
	#50		{g, clk, d} <= 6'b0_1_1010; descr <= "";
	#50		{g, clk, d} <= 6'b0_0_xxxx; descr <= "load 0001";
	#50		{g, clk, d} <= 6'b0_1_0001; descr <= "";
end

endmodule


