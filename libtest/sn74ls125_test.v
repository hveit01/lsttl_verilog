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
`include "sn74ls125.v"

module sn74ls125_testbench;
reg [80*8-1:0] descr;
reg a, c;
wire y;

sn74ls125 dut(.y(y), .a(a), .c(c));

initial
begin
	{a, c} <= 2'b11; descr <= "INIT";

	$dumpfile("sn74ls125.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%1b c=%1b | y=%1b | %0s", $time, a, c, y, descr);
	
	#50 	{a, c} <= 2'b00; descr <= "Pass 0";
	#50 	{a, c} <= 2'b01; descr <= "Tristate";
	#50 	{a, c} <= 2'b10; descr <= "Pass 1";
	#50 	{a, c} <= 2'b11; descr <= "Tristate";
end

endmodule


