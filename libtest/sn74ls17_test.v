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
// Buffer with OC  test bench
`timescale 1ns / 100ps
`include "sn74ls17.v"

module sn74ls17_testbench;
reg [80*8-1:0] descr;
reg a;
wire oc; // test with OC output
wire pu; // test with Pullup output

sn74ls17 dutoc(.y(oc), .a(a));
sn74ls17 dutpu(.y(pu), .a(a));
pullup(pu);

initial
begin
	a <= 1; descr <= "";

	$dumpfile("sn74ls17.vcd");
	$dumpvars;
	$monitor("T=%5g: a=%1b | oc=%1b pu=%1b | %0s", $time, a, oc, pu, descr);
	
	#40 	a <= 0;
	#40 	a <= 1;
	#40 	a <= 0;
end

endmodule


