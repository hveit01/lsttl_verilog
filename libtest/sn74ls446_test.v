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
`include "sn74ls446.v"

module sn74ls446_testbench;
reg [80*8-1:0] descr;
reg [3:0] a, b, dir;
reg gba, gab;
wire [3:0] abus, bbus;

sn74ls446 dut(.a(abus), .b(bbus), .gba(gba), .gab(gab), .dir(dir));
assign abus = a;
assign bbus = b;

initial
begin
	{a, b, gba, gab, dir} <= 14'bxxxx_xxxx_x_x_xxxx; descr <= "INIT";

	$dumpfile("sn74ls446.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%4b b=%4b gba=%1b gab=%1b dir=%4b | abus=%4b bbus=%4b | %0s", 
		$time, a, b, gba, gab, dir, abus, bbus, descr);
	
	#50 	{a, b, gba, gab, dir} <= 14'b0101_1010_1_1_xxxx; descr <= "isolation"; // don't set a, b to xxxx
	#50 	{a, b, gba, gab, dir} <= 14'b1111_zzzz_x_0_xxx1; descr <= "~A -> B bit0";
	#50 	{a, b, gba, gab, dir} <= 14'b0000_zzzz_x_0_xx1x; descr <= "~A -> B bit1";
	#50 	{a, b, gba, gab, dir} <= 14'b1010_zzzz_x_0_x1xx; descr <= "~A -> B bit2";
	#50 	{a, b, gba, gab, dir} <= 14'b0011_zzzz_x_0_1xxx; descr <= "~A -> B bit3";
	#50 	{a, b, gba, gab, dir} <= 14'bzzzz_1111_0_x_xxx0; descr <= "~B -> A bit0";
	#50 	{a, b, gba, gab, dir} <= 14'bzzzz_0000_0_x_xx0x; descr <= "~B -> A bit1";
	#50 	{a, b, gba, gab, dir} <= 14'bzzzz_1010_0_x_x0xx; descr <= "~B -> A bit2";
	#50 	{a, b, gba, gab, dir} <= 14'bzzzz_1100_0_x_0xxx; descr <= "~B -> A bit3";
	#50 	{a, b, gba, gab, dir} <= 14'b0101_1010_x_1_1111; descr <= "isolation";
	#50 	{a, b, gba, gab, dir} <= 14'b1100_0011_1_x_0000; descr <= "isolation";
end
endmodule


