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

module sn74ls51_6_testbench;
reg [80*8-1:0] descr;
reg a, b, c, d, e, f;
wire y;

sn74ls51_6 dut(.y(y), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f));

initial
begin
	{a, b, c, d, e, f} <= 6'b111_111; descr <= "INIT";

	$dumpfile("sn74ls51_6.vcd");
	$dumpvars;
	$monitor("T=%5g: in=%1b%1b%1b %1b%1b%1b | y=%1b | %0s", $time, a, b, c, d, e, f, y, descr);
	
	#30 	{a, b, c, d, e, f} <= 6'b0xx_000; descr <= "";
	#30 	{a, b, c, d, e, f} <= 6'b111_111; 
	#30 	{a, b, c, d, e, f} <= 6'bx0x_000; 
	#30 	{a, b, c, d, e, f} <= 6'b111_111; 
	#30 	{a, b, c, d, e, f} <= 6'bxx0_000; 
	#30 	{a, b, c, d, e, f} <= 6'b111_xxx; 
	#30 	{a, b, c, d, e, f} <= 6'b000_0xx;
	#30 	{a, b, c, d, e, f} <= 6'b111_111; 
	#30 	{a, b, c, d, e, f} <= 6'b000_x0x; 
	#30 	{a, b, c, d, e, f} <= 6'b111_111; 
	#30 	{a, b, c, d, e, f} <= 6'b000_xx0; 
	#30 	{a, b, c, d, e, f} <= 6'b000_111; 
	#30 	{a, b, c, d, e, f} <= 6'b000_000;
	#30 	{a, b, c, d, e, f} <= 6'b111_111; 
end

endmodule


