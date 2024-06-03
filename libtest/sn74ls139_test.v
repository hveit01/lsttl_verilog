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
// 2-to-4 decoder test bench
`timescale 1ns / 100ps
`include "sn74ls139.v"

module sn74ls139_testbench;
reg [80*8-1:0] descr;
reg a, b, g;
wire [3:0] y;

sn74ls139 dut(.y(y), .a(a), .b(b), .g(g));

initial
begin
	$dumpfile("sn74ls139.vcd");
	$dumpvars;
	$monitor("T=%5g: g=%1b ba=%1b%1b | y=%4b | %0s", $time, g, b, a, y, descr);
	
	    	{g, b, a} <= 3'b1xx; descr <= "all high";
	#50 	{g, b, a} <= 3'b000; descr <= "0";
	#50 	{g, b, a} <= 3'b1xx; descr <= "all high";
	#50 	{g, b, a} <= 3'b000; descr <= "0";
	#50 	{g, b, a} <= 3'b001; descr <= "1";
	#50 	{g, b, a} <= 3'b010; descr <= "2";
	#50 	{g, b, a} <= 3'b011; descr <= "3";
	
end

endmodule


