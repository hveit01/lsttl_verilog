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
`include "sn74ls381.v"

module sn74ls381_testbench;
reg [80*8-1:0] descr;
reg [3:0] a, b;
reg [2:0] s;
reg cn;
wire [3:0] f;
wire p, g;

sn74ls381 dut(.f(f), .g(g), .p(p), .a(a), .b(b), .s(s), .cn(cn));

initial
begin
	$dumpfile("sn74ls381.vcd");
	$dumpvars;
	$monitor("T=%5T: s=%3b cn=%1b a=%4b b=%4b | f=%4b g=%1b p=%1b %1b%1b%1b%1b%1b%1b%1b| %0s", 
		$time, s, cn, a, b, f, g, p, dut.n1, dut.n2, dut.n3, dut.n4, dut.n5, dut.n6, dut.o7, descr);
	
	 		{s, cn, a, b} <= 12'bxxx_x_xxxx_xxxx; descr <= "INIT";
			
	#50		{s, cn, a, b} <= 12'b000_x_0101_1010; descr <= "clear"; // don't use x, it will produce xxxx output

	#50		{s, cn, a, b} <= 12'b001_0_0000_0000; descr <= "B minus A";
	#50		{s, cn, a, b} <= 12'b001_0_0000_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b001_0_1111_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b001_0_1111_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b001_1_0000_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b001_1_0000_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b001_1_1111_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b001_1_1111_1111; descr <= "";

	#50		{s, cn, a, b} <= 12'b010_0_0000_0000; descr <= "A minus B";
	#50		{s, cn, a, b} <= 12'b010_0_0000_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b010_0_1111_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b010_0_1111_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b010_1_0000_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b010_1_0000_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b010_1_1111_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b010_1_1111_1111; descr <= "";

	#50		{s, cn, a, b} <= 12'b011_0_0000_0000; descr <= "A plus B";
	#50		{s, cn, a, b} <= 12'b011_0_0000_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b011_0_1111_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b011_0_1111_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b011_1_0000_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b011_1_0000_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b011_1_1111_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b011_1_1111_1111; descr <= "";

	#50		{s, cn, a, b} <= 12'b100_x_0000_0000; descr <= "A xor B";
	#50		{s, cn, a, b} <= 12'b100_0_0000_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b100_1_0000_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b100_0_1111_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b100_1_1111_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b100_x_1111_1111; descr <= "";

	#50		{s, cn, a, b} <= 12'b101_x_0000_0000; descr <= "A or B";
	#50		{s, cn, a, b} <= 12'b101_0_0000_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b101_1_0000_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b101_0_1111_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b101_1_1111_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b101_0_1111_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b101_1_1111_1111; descr <= "";

	#50		{s, cn, a, b} <= 12'b110_x_0000_0000; descr <= "A and B";
	#50		{s, cn, a, b} <= 12'b110_x_0000_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b110_x_1111_0000; descr <= "";
	#50		{s, cn, a, b} <= 12'b110_0_1111_1111; descr <= "";
	#50		{s, cn, a, b} <= 12'b110_1_1111_1111; descr <= "";
	
	#50		{s, cn, a, b} <= 12'b111_0_0101_1010; descr <= "preset"; // don't use X for A,B, will make G=x
	#50		{s, cn, a, b} <= 12'b111_1_1100_0011; descr <= "";
	
end

endmodule


