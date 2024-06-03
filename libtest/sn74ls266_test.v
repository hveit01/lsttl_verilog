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
// 2 input XOR test bench
`timescale 1ns / 100ps
`include "sn74ls266.v"

module sn74ls266_testbench;
reg [80*8-1:0] descr;
reg a, b;
wire ypu, yoc;

sn74ls266 dutpu(.y(ypu), .a(a), .b(b));
sn74ls266 dutoc(.y(yoc), .a(a), .b(b));
pullup(ypu);

initial
begin

	$dumpfile("sn74ls266.vcd");
	$dumpvars;
	$monitor("T=%5T: a=%1b b=%1b | ypu=%1b yoc=%1b | %0s", $time, a, b, ypu, yoc, descr);
	
			{a, b} <= 2'b00; descr <= "";
	#40 	{a, b} <= 2'b01;
	#40 	{a, b} <= 2'b11;
	#40 	{a, b} <= 2'b10;
	#40 	{a, b} <= 2'b00;
end

endmodule


