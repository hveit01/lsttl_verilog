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
// 4x4 bit register file with open collector
`timescale 1ns / 100ps
`include "sn74ls170.v"

module sn74ls170_testbench;
reg [80*8-1:0] descr;
reg [3:0] d;
reg [1:0] wa, ra;
reg we_, re_;
wire [3:0] qoc, qpu;

sn74ls170 dutoc(.q(qoc), .d(d), .we_(we_), .wa(wa), .re_(re_), .ra(ra));
sn74ls170 dutpu(.q(qpu), .d(d), .we_(we_), .wa(wa), .re_(re_), .ra(ra));
pullup(qpu[0]);
pullup(qpu[1]);
pullup(qpu[2]);
pullup(qpu[3]);

initial
begin
	#1		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";

	$dumpfile("sn74ls170.vcd");
	$dumpvars;
	$monitor("T=%5g: d=%4b we_=%1b wa=%2b re_=%1b ra=%2b | qpu=%4b qoc=%4b | %0s", $time, d, we_, wa, re_, ra, qpu, qoc, descr);
	
	#50		{d, we_, wa, re_, ra} <= 10'b1001_0_00_1_xx; descr <= "write 0=1001";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'b1011_0_01_1_xx; descr <= "write 1=1011";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'b1101_0_10_1_xx; descr <= "write 2=1101";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'b1111_0_11_1_xx; descr <= "write 3=1111";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_0_10; descr <= "read 2";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_0_01; descr <= "read 1";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_0_00; descr <= "read 0";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_0_11; descr <= "read 3";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'b0100_0_10_1_xx; descr <= "write 2=0100";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_0_01; descr <= "read 1";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_0_10; descr <= "read 2";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'b0000_0_00_0_10; descr <= "write 0=0000, read 2";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'b0110_0_11_0_00; descr <= "write 3=0110, read 0";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_0_11; descr <= "read 3";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_0_10; descr <= "read 2";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_0_01; descr <= "read 1";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_0_00; descr <= "read 0";
	#50		{d, we_, wa, re_, ra} <= 10'bxxxx_1_xx_1_xx; descr <= "";
end

endmodule


