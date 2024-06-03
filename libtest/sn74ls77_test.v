// This code is part of the model collection of simulatable TTL devices.
// Note this does not necessarily mean they are synthesizable!!!
//
// Copyright (C) 2022  Holger Veit (hveit01@web.de)
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
// Quad D latches
`timescale 1ns / 100ps
`include "sn74ls77.v"

module sn74ls77_testbench;
reg [80*8-1:0] descr;
reg [3:0] d;
reg g;
wire [3:0] q, q_;

sn74ls77 dut(.q(q), .d(d), .g(g));

initial
begin
	{d, g} <= 5'b0000_1; descr <= "INIT";

	$dumpfile("sn74ls77.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: d=%4b g=%1b | q=%4b | %0s", $time, d, g, q, descr);
	
	#40 	{d, g} <= 5'b1111_1; descr <= "PASS all one";
	#40 	{d, g} <= 5'b0000_1; descr <= "PASS all zero";
	#40 	{d, g} <= 5'b1010_1; descr <= "LOAD 1010";
	#40 	{d, g} <= 5'b1010_0; descr <= "";
	#40 	{d, g} <= 5'bxxxx_0; descr <= "HOLD";
	#40 	{d, g} <= 5'b0101_1; descr <= "LOAD 0101";
	#40 	{d, g} <= 5'b0101_0; descr <= "";
	#40 	{d, g} <= 5'bxxxx_0; descr <= "HOLD";
	#40 	{d, g} <= 5'b1100_1; descr <= "PASS 1100";
	#40 	{d, g} <= 5'b0011_1; descr <= "PASS 0011";
end

endmodule


