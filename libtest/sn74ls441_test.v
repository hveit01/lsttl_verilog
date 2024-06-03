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
// Tridirectional buffer test bench, open collector, inverting
`timescale 1ns / 100ps
`include "sn74ls441.v"

module sn74ls441_testbench;
reg [80*8-1:0] descr;
reg [3:0] a, b, c;
reg s1, s0, cs, ga, gb, gc;
wire [3:0] abus, bbus, cbus;

sn74ls441 dut(.a(abus), .b(bbus), .c(cbus), .s1(s1), .s0(s0), .cs(cs), .ga(ga), .gb(gb), .gc(gc));
assign abus = a;
assign bbus = b;
assign cbus = c;
pullup(abus[0]);
pullup(abus[1]);
pullup(abus[2]);
pullup(abus[3]);
pullup(bbus[0]);
pullup(bbus[1]);
pullup(bbus[2]);
pullup(bbus[3]);
pullup(cbus[0]);
pullup(cbus[1]);
pullup(cbus[2]);
pullup(cbus[3]);

initial
begin
	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'bx_xx_xxx_xxxx_xxxx_xxxx; descr <= "INIT";

	$dumpfile("sn74ls441.vcd");
	$dumpvars;
	$monitor("T=%5g: cs=%1b s=%1b%1b gabc=%1b%1b%1b a=%4b b=%4b c=%4b | abus=%4b bbus=%4b cbus=%4b | %0s", 
		$time, cs, s1,s0, ga,gb,gc, a, b, c, abus, bbus, cbus, descr);
	
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'b1_xx_xxx_zzzz_zzzz_zzzz; descr <= "disabled by cs";
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'bx_11_xxx_zzzz_zzzz_zzzz; descr <= "disabled by s=11";
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'bx_xx_111_zzzz_zzzz_zzzz; descr <= "disabled by g=111";
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'bx_00_x11_zzzz_zzzz_zzzz; descr <= "disabled A by no B,C";
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'bx_01_1x1_zzzz_zzzz_zzzz; descr <= "disabled B by no A,C";
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'bx_10_11x_zzzz_zzzz_zzzz; descr <= "disabled C by no A,B";
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'b0_00_100_0001_zzzz_zzzz; descr <= "pass ~A->B,C";  // don't use X for any G* - will set bus to X
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'b0_01_010_zzzz_0010_zzzz; descr <= "pass ~B->C,A";
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'b0_10_001_zzzz_zzzz_0100; descr <= "pass ~C->A,B";
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'b0_00_101_0001_zzzz_zzzz; descr <= "pass ~A->B";
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'b0_01_110_zzzz_0010_zzzz; descr <= "pass ~B->C";
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'b0_10_011_zzzz_zzzz_0100; descr <= "pass ~C->A";
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'b0_00_110_1001_zzzz_zzzz; descr <= "pass ~A->C";
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'b0_01_011_zzzz_1010_zzzz; descr <= "pass ~B->A";
	#50 	{cs, s1, s0, ga, gb, gc, a, b, c} <= 18'b0_10_101_zzzz_zzzz_1100; descr <= "pass ~C->B";
end
endmodule


