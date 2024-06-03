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
// 1 to 4 decoder open collector
`timescale 1ns / 100ps
`include "sn74ls156.v"

module sn74ls153_testbench;
reg [80*8-1:0] descr;
reg a1, a0, d, g;
wire [3:0] qoc, qpu;

sn74ls155 dutoc(.a1(a1), .a0(a0), .d(d), .g(g), .q(qoc));
sn74ls155 dutpu(.a1(a1), .a0(a0), .d(d), .g(g), .q(qpu));
pullup(qpu[0]);
pullup(qpu[1]);
pullup(qpu[2]);
pullup(qpu[3]);

initial
begin

	$dumpfile("sn74ls155.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%1b%1b d=%1b g=%1b | qoc=%4b qpu=%4b | %0s", $time, a1, a0, d, g, qoc, qpu, descr);
	
			{a1, a0, d, g} <= 4'bxx_x_1; descr <= "INIT";
	#40 	{a1, a0, d, g} <= 4'b00_1_0; descr <= "select 0";
	#40 	{a1, a0, d, g} <= 4'b01_1_0; descr <= "select 1";
	#40 	{a1, a0, d, g} <= 4'b10_1_0; descr <= "select 2";
	#40 	{a1, a0, d, g} <= 4'b11_1_0; descr <= "select 3";
	#40 	{a1, a0, d, g} <= 4'bxx_0_x; descr <= "disable d";

end

endmodule


