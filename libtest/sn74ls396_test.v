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
// 2x4 bit register test bench
`timescale 1ns / 100ps
`include "sn74ls396.v"

module sn74ls396_testbench;
reg [80*8-1:0] descr;
reg [3:0] d;
reg clk, g;
wire [3:0] q1, q2;

sn74ls396 dut(.q1(q1), .q2(q2), .d(d), .clk(clk), .g(g));

initial
begin
	$dumpfile("sn74ls396.vcd");
	$dumpvars;
	$monitor("T=%5T: g=%1b clk=%1b d=%4b | q1=%4b q2=%4b | %0s", $time, g, clk, d, q1, q2, descr);
	
	 		{g, clk, d} <= 6'bx_x_xxxx; descr <= "INIT";

	#50		{g, clk, d} <= 6'b1_x_xxxx; descr <= "outputs low";
	#50		{g, clk, d} <= 6'b0_0_xxxx; descr <= "load 0000";
	#50		{g, clk, d} <= 6'b0_1_0000; descr <= "";
	#50		{g, clk, d} <= 6'b0_0_xxxx; descr <= "load 1111";
	#50		{g, clk, d} <= 6'b0_1_1111; descr <= "";
	#50		{g, clk, d} <= 6'b0_0_xxxx; descr <= "load 1010";
	#50		{g, clk, d} <= 6'b0_1_1010; descr <= "";
	#50		{g, clk, d} <= 6'b1_x_xxxx; descr <= "outputs low";
end

endmodule


