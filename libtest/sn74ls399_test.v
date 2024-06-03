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
// quad 2 to 1 multiplexer with storage test bench
`timescale 1ns / 100ps
`include "sn74ls399.v"

module sn74ls399_testbench;
reg [80*8-1:0] descr;
reg [3:0] in1, in2;
reg ws, clk;
wire [3:0] q;

sn74ls399 dut(.q(q), .in1(in1), .in2(in2), .ws(ws), .clk(clk));

initial
begin
	#1	{ws, clk, in1, in2} <= 10'bx_x_xxxx_xxxx; descr <= "INIT";

	$dumpfile("sn74ls399.vcd");
	$dumpvars;
	$monitor("T=%5g: s=%1b clk=%1b in1=%4b in2=%4b | q=%4b | %0s", $time, ws, clk, in1, in2, q, descr);
	
	#40	{ws, clk, in1, in2} <= 10'b0_0_1010_xxxx; descr <= "load in1";
	#40	{ws, clk, in1, in2} <= 10'b0_1_1010_xxxx; descr <= "";
	#40	{ws, clk, in1, in2} <= 10'b1_0_1010_0011; descr <= "load in2";
	#40	{ws, clk, in1, in2} <= 10'b1_1_1010_0011; descr <= "";
	#40	{ws, clk, in1, in2} <= 10'b0_0_1111_0011; descr <= "load in1";
	#40	{ws, clk, in1, in2} <= 10'b0_1_1111_0011; descr <= "";
	#40	{ws, clk, in1, in2} <= 10'b1_0_1111_1100; descr <= "load in2";
	#40	{ws, clk, in1, in2} <= 10'b1_1_1111_1100; descr <= "";
end

endmodule


