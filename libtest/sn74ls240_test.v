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
`include "sn74ls240.v"

module sn74ls240_testbench;
reg [80*8-1:0] descr;
reg [7:0] a;
reg g1_, g2_;
wire [7:0] q_;

sn74ls240 dut(.q_(q_), .a(a), .g1_(g1_), .g2_(g2_));

initial
begin
	{a, g1_, g2_} <= 10'bxxxxxxxx_x_x; descr <= "INIT";

	$dumpfile("sn74ls240.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%8b g1=%1b g2=%1b | q=%8b | %0s", $time, a, g1_, g2_, q_, descr);
	
	#50 	{a, g1_, g2_} <= 10'b00000000_0_0; descr <= "Pass ~0";
	#50 	{a, g1_, g2_} <= 10'b0000xxxx_1_0; descr <= "Tristate a0-3";
	#50 	{a, g1_, g2_} <= 10'bxxxx0000_0_1; descr <= "Tristate a4-7";
	#50 	{a, g1_, g2_} <= 10'b11111111_0_0; descr <= "Pass ~1";
	#50 	{a, g1_, g2_} <= 10'bxxxxxxxx_1_1; descr <= "Tristate all";
	#50 	{a, g1_, g2_} <= 10'b10100101_0_0; descr <= "Checkerboard";
	#50 	{a, g1_, g2_} <= 10'bxxxxxxxx_1_1; descr <= "Tristate all";
	#50 	{a, g1_, g2_} <= 10'b11000011_0_0; descr <= "Checkerboard";
	#50 	{a, g1_, g2_} <= 10'bxxxxxxxx_1_1; descr <= "Tristate all";
end

endmodule


