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
// addressable latch
`timescale 1ns / 100ps
`include "sn74ls259.v"

module sn74ls259_testbench;
reg [80*8-1:0] descr;
reg a, b, c, clr, data, en;
wire [7:0] q;

sn74ls259 dut(.q(q), .a(a), .b(b), .c(c), .data(data), .clr(clr), .en(en));

initial
begin
	#1		{c, b, a, clr, data, en} <= 6'bxxx_x_x_x; descr <= "init";

	$dumpfile("sn74ls259.vcd");
	$dumpvars;
	$monitor("T=%5g: cba=%1b%1b%1b clr=%1b data=%1b en=%1b | q=%8b | %0s", $time, c, b, a, clr, data, en, q, descr);
	
	#40 	{c, b, a, clr, data, en} <= 6'b000_1_0_0; descr <= "store 0 to 0";
	#40 	{c, b, a, clr, data, en} <= 6'b000_1_0_1; descr <= "";
	#40 	{c, b, a, clr, data, en} <= 6'b001_1_1_0; descr <= "store 1 to 1";
	#40 	{c, b, a, clr, data, en} <= 6'bxxx_1_1_1; descr <= "";
	#40 	{c, b, a, clr, data, en} <= 6'b010_1_1_0; descr <= "store 1 to 2";
	#40 	{c, b, a, clr, data, en} <= 6'bxxx_1_1_1; descr <= "";
	#40 	{c, b, a, clr, data, en} <= 6'b011_1_0_0; descr <= "store 0 to 3";
	#40 	{c, b, a, clr, data, en} <= 6'bxxx_1_1_1; descr <= "";
	#40 	{c, b, a, clr, data, en} <= 6'b100_1_1_0; descr <= "store 1 to 4";
	#40 	{c, b, a, clr, data, en} <= 6'bxxx_1_1_1; descr <= "";
	#40 	{c, b, a, clr, data, en} <= 6'b101_1_0_0; descr <= "store 0 to 5";
	#40 	{c, b, a, clr, data, en} <= 6'bxxx_1_1_1; descr <= "";
	#40 	{c, b, a, clr, data, en} <= 6'b110_1_0_0; descr <= "store 0 to 6";
	#40 	{c, b, a, clr, data, en} <= 6'bxxx_1_1_1; descr <= "";
	#40 	{c, b, a, clr, data, en} <= 6'b111_1_1_0; descr <= "store 1 to 7";
	#40 	{c, b, a, clr, data, en} <= 6'bxxx_1_1_1; descr <= "";
	#40     {c, b, a, clr, data, en} <= 6'bxxx_0_x_1; descr <= "clear";
	#40     {c, b, a, clr, data, en} <= 6'bxxx_1_1_1; descr <= "";
	#40     {c, b, a, clr, data, en} <= 6'b000_0_1_0; descr <= "select 0";
	#40     {c, b, a, clr, data, en} <= 6'b001_0_1_0; descr <= "select 1";
	#40     {c, b, a, clr, data, en} <= 6'b010_0_1_0; descr <= "select 2";
	#40     {c, b, a, clr, data, en} <= 6'b011_0_1_0; descr <= "select 3";
	#40     {c, b, a, clr, data, en} <= 6'b100_0_1_0; descr <= "select 4";
	#40     {c, b, a, clr, data, en} <= 6'b101_0_1_0; descr <= "select 5";
	#40     {c, b, a, clr, data, en} <= 6'b110_0_1_0; descr <= "select 6";
	#40     {c, b, a, clr, data, en} <= 6'b111_0_1_0; descr <= "select 7";
	
end

endmodule


