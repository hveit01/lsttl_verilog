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
// 6 bit register test bench
`timescale 1ns / 100ps
`include "sn74ls378.v"

module sn74ls378_testbench;
reg [80*8-1:0] descr;
reg [5:0] d;
reg clk, g;
wire [5:0] q;

sn74ls378 dut(.q(q), .d(d), .clk(clk), .g(g));

initial
begin
	$dumpfile("sn74ls378.vcd");
	$dumpvars;
	$monitor("T=%5T: g=%1b clk=%1b d=%6b | q=%6b | %0s", $time, g, clk, d, q, descr);
	
	 		{g, clk, d} <= 8'bx_x_xxxxxx; descr <= "INIT";

	#50		{g, clk, d} <= 8'b0_0_xxxxxx; descr <= "load 111111";
	#50		{g, clk, d} <= 8'b0_1_111111; descr <= "";
	#50		{g, clk, d} <= 8'b1_0_xxxxxx; descr <= "disabled";
	#50		{g, clk, d} <= 8'b1_1_111000; descr <= "";
	#50		{g, clk, d} <= 8'b0_0_xxxxxx; descr <= "load 101010";
	#50		{g, clk, d} <= 8'b0_1_101010; descr <= "";
	#50		{g, clk, d} <= 8'b0_0_xxxxxx; descr <= "load 110100";
	#50		{g, clk, d} <= 8'b0_1_110100; descr <= "";
end

endmodule


