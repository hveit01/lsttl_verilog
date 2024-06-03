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
`include "sn74ls373.v"

module sn74ls373_testbench;
reg [80*8-1:0] descr;
reg [7:0] d;
reg en, oe;
wire [7:0] q;

sn74ls373 dut(.q(q), .d(d), .en(en), .oe(oe));

initial
begin
	$dumpfile("sn74ls373.vcd");
	$dumpvars;
	$monitor("T=%5T: oe=%1b en=%1b d=%8b | q=%8b | %0s", $time, oe, en, d, q, descr);
	
	#1 		{oe, en, d} <= 10'bx_x_xxxxxxxx; descr <= "INIT";

	#50		{oe, en, d} <= 10'b1_x_xxxxxxxx; descr <= "tristate";

	#50		{oe, en, d} <= 10'b0_1_11111111; descr <= "pass 11111111";
	#50		{oe, en, d} <= 10'b0_0_xxxxxxxx; descr <= "hold";
	#50		{oe, en, d} <= 10'b0_1_10101010; descr <= "pass 10101010";
	#50		{oe, en, d} <= 10'b0_0_xxxxxxxx; descr <= "hold";
	#50		{oe, en, d} <= 10'b0_1_00110011; descr <= "pass 00110011";
	#50		{oe, en, d} <= 10'b0_1_11001100; descr <= "pass 11001100";
	#50		{oe, en, d} <= 10'b0_0_xxxxxxxx; descr <= "hold";
end

endmodule


