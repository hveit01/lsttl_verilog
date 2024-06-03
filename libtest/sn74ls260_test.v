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
// 2 input NOR test bench
`timescale 1ns / 100ps
`include "sn74ls260.v"

module sn74ls260_testbench;
reg [80*8-1:0] descr;
reg a, b, c, d, e;
wire y;

sn74ls260 dut(.y(y), .a(a), .b(b), .c(c), .d(d), .e(e));

initial
begin
	{a, b, c, d ,e} <= 5'bxxxxx; descr <= "INIT";

	$dumpfile("sn74ls260.vcd");
	$dumpvars;
	$monitor("T=%5g: in=%1b%1b%1b%1b%1b | y=%1b | %0s", $time, a, b, c, d, e, y, descr);
	
	#30 	{a, b, c, d, e} <= 5'b1xxxx; descr <= "";
	#30 	{a, b, c, d, e} <= 5'bx1xxx;
	#30 	{a, b, c, d, e} <= 5'bxx1xx;
	#30 	{a, b, c, d, e} <= 5'bxxx1x;
	#30 	{a, b, c, d, e} <= 5'b00000;
	#30 	{a, b, c, d, e} <= 5'bxxxx1;
	#30 	{a, b, c, d, e} <= 5'b00000;
end

endmodule


