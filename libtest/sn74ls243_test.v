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
`include "sn74ls243.v"

module sn74ls243_testbench;
reg [80*8-1:0] descr;
reg [3:0] a, b;
reg ga_, gb;
wire [3:0] abus, bbus;

sn74ls243 dut(.a(abus), .b(bbus), .ga_(ga_), .gb(gb));
assign abus = a;
assign bbus = b;

initial
begin
	{a, b, ga_, gb} <= 10'bxxxx_xxxx_x_x; descr <= "INIT";

	$dumpfile("sn74ls243.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%4b b=%4b ga_=%1b gb=%1b | abus=%4b bbus=%4b | %0s", $time, a, b, ga_, gb, abus, bbus, descr);
	
	#50 	{a, b, ga_, gb} <= 10'b1010_zzzz_0_0; descr <= "A to B";
	#50 	{a, b, ga_, gb} <= 10'bzzzz_1100_1_1; descr <= "B to A";
	#50 	{a, b, ga_, gb} <= 10'b0011_zzzz_1_0; descr <= "bus disable";
	#50 	{a, b, ga_, gb} <= 10'bzzzz_1100_1_0; descr <= "bus disable";
	#50 	{a, b, ga_, gb} <= 10'bzzzz_1100_0_1; descr <= "bus disable";
	#50 	{a, b, ga_, gb} <= 10'b0011_zzzz_0_1; descr <= "bus disable";
end
endmodule


