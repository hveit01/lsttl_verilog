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
// 8 bit register test bench
`timescale 1ns / 100ps
`include "sn74ls375.v"

module sn74ls375_testbench;
reg [80*8-1:0] descr;
reg [3:0] d;
reg g, oe;
wire [3:0] q, q_;

sn74ls375 dut(.q(q), .q_(q_), .d(d), .g(g));

initial
begin
	$dumpfile("sn74ls375.vcd");
	$dumpvars;
	$monitor("T=%5T: g=%1b d=%4b | q=%4b q_=%4b | %0s", $time, g, d, q, q_, descr);
	
	 		{g, d} <= 5'bx_xxxx; descr <= "INIT";

	#50		{g, d} <= 5'b0_1111; descr <= "pass 1111";
	#50		{g, d} <= 5'b0_0000; descr <= "pass 0000";
	#50		{g, d} <= 5'b0_1010; descr <= "pass 1010";
	#50		{g, d} <= 5'b1_xxxx; descr <= "hold";
	#50		{g, d} <= 5'b0_1100; descr <= "pass 1100";
	#50		{g, d} <= 5'b1_xxxx; descr <= "hold";
end

endmodule


