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
// INVERTER test bench
`timescale 1ns / 100ps
`include "sn74ls04.v"

module sn74ls04_testbench;
reg [80*8-1:0] descr;
reg a;
wire y;

sn74ls04 dut(.y(y), .a(a));

initial
begin
	a <= 0; descr <= "IN=0";

	$dumpfile("sn74ls04.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%1b | y=%1b | %0s", $time, a, y, descr);
	
	#20 	a <= 1; descr <= "IN=1";
	#20 	a <= 0; descr <= "IN=0";
end

endmodule


