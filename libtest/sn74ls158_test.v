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
// quad 2 to 1 multiplexer  test bench
`timescale 1ns / 100ps
`include "sn74ls158.v"

module sn74ls158_testbench;
reg [80*8-1:0] descr;
reg [3:0] a, b;
reg s, g;
wire [3:0] y;

sn74ls158 dut(.y(y), .a(a), .b(b), .s(s), .g(g));

initial
begin
	{g, s, a, b} <= 10'b1x_xxxx_xxxx; descr <= "g=1";

	$dumpfile("sn74ls158.vcd");
	$dumpvars;
	$monitor("T=%5g: g=%1b s=%1b a=%4b b=%4b | y=%4b | %0s", $time, g, s, a, b, y, descr);
	
	#40 	{g, s, a, b} <= 10'b00_0000_xxxx; descr <= "s=0";
	#40 	{g, s, a, b} <= 10'b01_xxxx_1111; descr <= "s=1";
	#40 	{g, s, a, b} <= 10'b00_1010_xxxx; descr <= "s=0";
	#40 	{g, s, a, b} <= 10'b01_xxxx_0101; descr <= "s=1";
	#40 	{g, s, a, b} <= 10'b00_1111_xxxx; descr <= "s=0";
	#40 	{g, s, a, b} <= 10'b01_xxxx_0000; descr <= "s=1";
end

endmodule


