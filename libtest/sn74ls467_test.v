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
// Tristate buffer test bench
`timescale 1ns / 100ps
`include "sn74ls467.v"

module sn74ls467_testbench;
reg [80*8-1:0] descr;
reg [7:0] a;
reg g1_, g2_;
wire [7:0] q;

sn74ls467 dut(.q(q), .a(a), .g1_(g1_), .g2_(g2_));

initial
begin
	{a, g1_, g2_} <= 10'bxxxxxxxx_x_x; descr <= "INIT";

	$dumpfile("sn74ls467.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%8b g1=%1b g2=%1b | q=%8b | %0s", $time, a, g1_, g2_, q, descr);
	
	#50 	{a, g1_, g2_} <= 10'b0000_0000_0_0; descr <= "Pass ~0";
	#50 	{a, g1_, g2_} <= 10'b0000_xxxx_1_0; descr <= "Tristate lower";
	#50 	{a, g1_, g2_} <= 10'bxxxx_0000_0_1; descr <= "Tristate higher";
	#50 	{a, g1_, g2_} <= 10'b1111_1111_0_0; descr <= "Pass ~1";
	#50 	{a, g1_, g2_} <= 10'bxxxx_1111_0_1; descr <= "Tristate higher";
	#50 	{a, g1_, g2_} <= 10'b1010_0101_0_0; descr <= "Checkerboard";
	#50 	{a, g1_, g2_} <= 10'bxxxx_xxxx_1_1; descr <= "Tristate all";
	#50 	{a, g1_, g2_} <= 10'b1100_0011_0_0; descr <= "Checkerboard";
	#50 	{a, g1_, g2_} <= 10'bxxxx_xxxx_1_1; descr <= "Tristate all";
end

endmodule


