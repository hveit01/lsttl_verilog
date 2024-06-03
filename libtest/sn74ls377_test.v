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
// 8 bit register test bench
`timescale 1ns / 100ps
`include "sn74ls377.v"

module sn74ls377_testbench;
reg [80*8-1:0] descr;
reg [7:0] d;
reg clk, g;
wire [7:0] q;

sn74ls377 dut(.q(q), .d(d), .clk(clk), .g(g));

initial
begin
	$dumpfile("sn74ls377.vcd");
	$dumpvars;
	$monitor("T=%5T: g=%1b clk=%1b d=%8b | q=%8b | %0s", $time, g, clk, d, q, descr);
	
	 		{g, clk, d} <= 10'bx_x_xxxxxxxx; descr <= "INIT";

	#50		{g, clk, d} <= 10'b0_0_xxxxxxxx; descr <= "load 11111111";
	#50		{g, clk, d} <= 10'b0_1_11111111; descr <= "";
	#50		{g, clk, d} <= 10'b1_0_xxxxxxxx; descr <= "disabled";
	#50		{g, clk, d} <= 10'b1_1_11110000; descr <= "";
	#50		{g, clk, d} <= 10'b0_0_xxxxxxxx; descr <= "load 10101010";
	#50		{g, clk, d} <= 10'b0_1_10101010; descr <= "";
	#50		{g, clk, d} <= 10'b0_0_xxxxxxxx; descr <= "load 11001100";
	#50		{g, clk, d} <= 10'b0_1_11001100; descr <= "";
end

endmodule


