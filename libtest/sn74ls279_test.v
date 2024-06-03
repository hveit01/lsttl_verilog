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
// RS FF test bench
`timescale 1ns / 100ps
`include "sn74ls279.v"

module sn74ls279_testbench;
reg [80*8-1:0] descr;
reg s, r;
wire q;

sn74ls279 dut(.q(q), .s(s), .r(r));

initial
begin
	$dumpfile("sn74ls279.vcd");
	$dumpvars;
	$monitor("T=%5T: s=%1b r=%1b| q=%1b | %0s", $time, s, r, q, descr);
	
	#1 		{s, r} <= 2'bx_x; descr <= "INIT";

	#40		{s, r} <= 2'b0_1; descr <= "set";
	#40		{s, r} <= 2'b1_1; descr <= "hold";
	#40		{s, r} <= 2'b1_0; descr <= "reset";
	#40		{s, r} <= 2'b1_1; descr <= "hold";
	#40		{s, r} <= 2'b0_0; descr <= "instable";
	#40		{s, r} <= 2'b1_0; descr <= "s goes high first";
	#40		{s, r} <= 2'b1_1; descr <= "hold";
end

endmodule


