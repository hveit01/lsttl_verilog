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
// monoflop testbench
`timescale 1ns / 100ps
`include "sn74ls123.v"

module sn74ls123_testbench;
reg [80*8-1:0] descr;
reg a, b, clr;
wire q, q_;

`define RT 10      // 10kOhm
`define CT 876.2   // 876.2pF

sn74ls123 #(.rT(`RT), .cT(`CT)) dut(.q(q), .q_(q_), .a(a), .b(b), .clr(clr));

initial
begin
	{clr, a, b} <= 3'b0xx; descr <= "Low  CLR=0";

	$dumpfile("sn74ls123.vcd");
	$dumpvars;
	$monitor("T=%05g: c=%1b a=%1b b=%1b | mono=%1b | q=%1b q_=%1b | %0s", $time, clr, dut.a, dut.b, dut.mono, q, q_, descr);
	
	$display("Timing params: rT=%.1f kOhm cT=%.1f pF => tW=%.1f nSec", `RT, `CT, dut.tW);
	
	
	#10000 {clr, a, b} <= 3'bx1x; descr <= "Low  A=1";
	#5000  {clr, a, b} <= 3'bxx0; descr <= "Low  B=0";

	#5000  $display("-------------------------------------------------------");
		   {clr, a, b} <= 3'b100; descr <= "^ on B (A=0)";
	#1     {clr, a, b} <= 3'b101; descr <= "";

	#5000  $display("-------------------------------------------------------");
		   {clr, a, b} <= 3'b111; descr <= "v on A (B=1)";
	#1     {clr, a, b} <= 3'b101; descr <= "";

	#5000  $display("-------------------------------------------------------");
		   {clr, a, b} <= 3'b001; descr <= "^ on Clr (A=0,B=1)";
	#1     {clr, a, b} <= 3'b101; descr <= "";

	#5000  $display("-------------------------------------------------------");
		   {clr, a, b} <= 3'b100; descr <= "^ on B (A=0)";
	#1     {clr, a, b} <= 3'b101; descr <= "";
	#2000  {clr, a, b} <= 3'b100; descr <= "Retrigger on B";
	#1     {clr, a, b} <= 3'b101; descr <= "";
	#1000  {clr, a, b} <= 3'b111; descr <= "Retrigger on A";
	#1     {clr, a, b} <= 3'b101; descr <= "";



end

endmodule


