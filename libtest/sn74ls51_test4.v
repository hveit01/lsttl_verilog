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
`include "sn74ls51.v"

module sn74ls51_4_testbench;
reg [80*8-1:0] descr;
reg a, b, c, d;
wire y;

sn74ls51_4 dut(.y(y), .a(a), .b(b), .c(c), .d(d));

initial
begin
	{a, b, c, d} <= 4'b11_11; descr <= "INIT";

	$dumpfile("sn74ls51_4.vcd");
	$dumpvars;
	$monitor("T=%5g: in=%1b%1b %1b%1b | y=%1b | %0s", $time, a, b, c, d, y, descr);
	
	#30 	{a, b, c, d} <= 4'b0x_00; descr <= "";
	#30		{a, b, c, d} <= 4'b11_11; 
	#30 	{a, b, c, d} <= 4'bx0_00;
	#30 	{a, b, c, d} <= 4'b11_xx;
	#30 	{a, b, c, d} <= 4'b00_0x;
	#30		{a, b, c, d} <= 4'b11_xx; 
	#30 	{a, b, c, d} <= 4'b00_x0;
	#30		{a, b, c, d} <= 4'bxx_11;
	#30 	{a, b, c, d} <= 4'b00_00;
	#30		{a, b, c, d} <= 4'b11_11;
end

endmodule


