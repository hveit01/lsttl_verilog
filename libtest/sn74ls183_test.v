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
// 
`timescale 1ns / 100ps
`include "sn74ls183.v"

module sn74ls183_testbench;
reg [80*8-1:0] descr;
reg a, b, cn;
wire sum, cn1;

sn74ls183 dut(.a(a), .b(b), .cn(cn), .sum(sum), .cn1(cn1));

initial
begin
	#1		{cn, b, a} <= 3'bxxx; descr <= "";

	$dumpfile("sn74ls183.vcd");
	$dumpvars;
	$monitor("T=%5g: cn=%1b b=%1b a=%1b | sum=%1b cn1=%1b | %0s", $time, cn, b, a, sum, cn1, descr);

	#30		{cn, b, a} <= 3'b000; descr <= "";
	#30		{cn, b, a} <= 3'b001; descr <= "";
	#30		{cn, b, a} <= 3'b010; descr <= "";
	#30		{cn, b, a} <= 3'b011; descr <= "";
	#30		{cn, b, a} <= 3'b100; descr <= "";
	#30		{cn, b, a} <= 3'b101; descr <= "";
	#30		{cn, b, a} <= 3'b110; descr <= "";
	#30		{cn, b, a} <= 3'b111; descr <= "";
end

endmodule


