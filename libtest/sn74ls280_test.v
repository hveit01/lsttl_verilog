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
// 9 bit parity generator/checker
`timescale 1ns / 100ps
`include "sn74ls280.v"

module sn74ls280_testbench;
reg [80*8-1:0] descr;
reg [8:0] d;
wire even, odd;

sn74ls280 dut(.even(even), .odd(odd), .d(d));

initial
begin
	$dumpfile("sn74ls280.vcd");
	$dumpvars;
	$monitor("T=%5T: d=%9b | even=%1b odd=%1b | %0s", $time, d, even, odd, descr);
	
	#1 		d <= 9'bxxxxxxxxx; descr <= "INIT";

	#60		d <= 9'b000000000; descr <= "";
	#60		d <= 9'b000000001;
	#60		d <= 9'b000000011;
	#60		d <= 9'b000000111;
	#60		d <= 9'b000001111;
	#60		d <= 9'b000011111;
	#60		d <= 9'b000111111;
	#60		d <= 9'b001111111;
	#60		d <= 9'b011111111;
	#60		d <= 9'b111111111;
end

endmodule


