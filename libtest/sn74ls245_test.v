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
`include "sn74ls245.v"

module sn74ls245_testbench;
reg [80*8-1:0] descr;
reg [7:0] a, b;
reg e_, dir;
wire [7:0] abus, bbus;

sn74ls245 dut(.a(abus), .b(bbus), .e_(e_), .dir(dir));
assign abus = a;
assign bbus = b;

initial
begin
	{a, b, e_, dir} <= 18'bxxxxxxxx_xxxxxxxx_x_x; descr <= "INIT";

	$dumpfile("sn74ls245.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%8b b=%8b e_=%1b dir=%1b | abus=%8b bbus=%8b | %0s", $time, a, b, e_, dir, abus, bbus, descr);
	
	#50 	{a, b, e_, dir} <= 18'bzzzzzzzz_zzzzzzzz_1_x; descr <= "bus high";
	#50 	{a, b, e_, dir} <= 18'bzzzzzzzz_10101010_0_0; descr <= "B to A";
	#50 	{a, b, e_, dir} <= 18'b11001100_zzzzzzzz_0_1; descr <= "A to B";
	#50 	{a, b, e_, dir} <= 18'bzzzzzzzz_00001111_0_0; descr <= "B to A";
	#50 	{a, b, e_, dir} <= 18'b11110000_zzzzzzzz_0_1; descr <= "A to B";
	#50 	{a, b, e_, dir} <= 18'bzzzzzzzz_zzzzzzzz_1_x; descr <= "bus high";
end
endmodule


