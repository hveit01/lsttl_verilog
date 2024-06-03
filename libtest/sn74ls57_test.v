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
// Frequency dividers
`timescale 1ns / 100ps
`include "sn74ls57.v"

module sn74ls57_testbench;
reg [80*8-1:0] descr;
reg clka, clkb, clr;
wire qa, qb, qc;

sn74ls57 dut(.qa(qa), .qb(qb), .qc(qc), .clka(clka), .clkb(clkb), .clr(clr));

initial
begin
	{clka, clkb, clr} <= 3'b0_0_1; descr <= "INIT";

	$dumpfile("sn74ls57.vcd");
	$dumpvars;
	$monitor("T=%5g: clka=%1b clkb=%1b clr=%1b | qa=%1b qb=%1b qc=%1b | %0s", $time, clka, clkb, clr, qa, qb, qc, descr);

	#50 {clka, clkb, clr} <= 3'bx_x_0; descr <= "RESET";
	#50 {clka, clkb, clr} <= 3'b0_0_0; descr <= "";
	#50 {clka, clkb, clr} <= 3'b1_1_0; descr <= "HOLD WHILE RESET";
	#50 {clka, clkb, clr} <= 3'b0_0_0; descr <= "";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "ALLOW CLOCK";
	
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK1";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK2";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK3 QA=1";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK4 QB=1";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK5 QB=0, QC=1";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK6 QA=0";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK7";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK8";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK9 QA=QB=1";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK10 QB=0 QC=0";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK11";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK12 QA=1";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK13";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK14 QB=1";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK15 QA=1 QB=0 QC=1";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK16";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK17";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK18";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK19 QB=1";
	#50 {clka, clkb, clr} <= 3'b1_1_1; descr <= "^";
	#50 {clka, clkb, clr} <= 3'b0_0_1; descr <= "CLK20 QB=0 QC=0";

	
	
end

endmodule


