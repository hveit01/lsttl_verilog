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
// 2 input NAND with OC  test bench
`timescale 1ns / 100ps
`include "sn74ls38.v"

module sn74ls38_testbench;
reg [80*8-1:0] descr;
reg a, b;
wire oc; // test with OC output
wire pu; // test with Pullup output

sn74ls38 dutoc(.y(oc), .a(a), .b(b));
sn74ls38 dutpu(.y(pu), .a(a), .b(b));
pullup(pu);

initial
begin
	{a, b} <= 2'b11; descr <= "IN=11";

	$dumpfile("sn74ls38.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%1b b=%1b | oc=%1b pu=%1b | %0s", $time, a, b, oc, pu, descr);
	
	#40 	{a, b} <= 2'b00; descr <= "IN=00";
	#40 	{a, b} <= 2'b11; descr <= "IN=11";
	#40 	{a, b} <= 2'b10; descr <= "IN=10";
	#40 	{a, b} <= 2'b11; descr <= "IN=11";
	#40 	{a, b} <= 2'b01; descr <= "IN=01";
	#40 	{a, b} <= 2'b11; descr <= "IN=11";
	#40 	{a, b} <= 2'b00; descr <= "IN=00";
end

endmodule


