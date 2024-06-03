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
// monoflop test bench
`timescale 1ns / 100ps
`include "sn74ls122.v"

module sn74ls122_testbench;
reg [80*8-1:0] descr;
reg a1, a2, b1, b2, clr;
wire q, q_;

`define RT 10      // 10kOhm
`define CT 876.2   // 876.2pF

sn74ls122 #(.rT(`RT), .cT(`CT)) dut(.q(q), .q_(q_), .a1(a1), .a2(a2), .b1(b1), .b2(b2), .clr(clr));

initial
begin
	{clr, a1, a2, b1, b2} <= 5'b0xxxx; descr <= "Low  CLR=0";

	$dumpfile("sn74ls122.vcd");
	$dumpvars;
	$monitor("T=%05g: c=%1b ax=%1b%1b bx=%1b%1b | mono=%1b | q=%1b q_=%1b | %0s", $time, clr, dut.a1, dut.a2, dut.b1, dut.b2, dut.mono, q, q_, descr);
	
	$display("Timing params: rT=%.1f kOhm cT=%.1f pF => tW=%.1f nSec", `RT, `CT, dut.tW);
	
	
	#10000 {clr, a1, a2, b1, b2} <= 5'bx11xx; descr <= "Low  A=11";
	#5000  {clr, a1, a2, b1, b2} <= 5'bxxx0x; descr <= "Low  B=0x";
	#5000  {clr, a1, a2, b1, b2} <= 5'bxxxx0; descr <= "Low  B=x0";

	#5000  $display("-------------------------------------------------------");
		   {clr, a1, a2, b1, b2} <= 5'b10x01; descr <= "^ on B1 (A1=0)";
	#1     {clr, a1, a2, b1, b2} <= 5'b10x11; descr <= "";

	#5000  $display("-------------------------------------------------------");
		   {clr, a1, a2, b1, b2} <= 5'b10x10; descr <= "^ on B2 (A1=0)";
	#1     {clr, a1, a2, b1, b2} <= 5'b10x11; descr <= "";

	#5000  $display("-------------------------------------------------------");
		   {clr, a1, a2, b1, b2} <= 5'b1x001; descr <= "^ on B1 (A2=0)";
	#1     {clr, a1, a2, b1, b2} <= 5'b1x011; descr <= "";
	
	#5000  $display("-------------------------------------------------------");
		   {clr, a1, a2, b1, b2} <= 5'b1x010; descr <= "^ on B2 (A2=0)";
	#1     {clr, a1, a2, b1, b2} <= 5'b1x011; descr <= "";
	
	#5000  $display("-------------------------------------------------------");
		   {clr, a1, a2, b1, b2} <= 5'b11111; descr <= "v on A2 (Bx=1)";
	#1     {clr, a1, a2, b1, b2} <= 5'b11011; descr <= "";

	#5000  $display("-------------------------------------------------------");
		   {clr, a1, a2, b1, b2} <= 5'b11111; descr <= "v on A1A2 (Bx=1)";
	#1     {clr, a1, a2, b1, b2} <= 5'b10011; descr <= "";

	#5000  $display("-------------------------------------------------------");
		   {clr, a1, a2, b1, b2} <= 5'b11111; descr <= "v on A1 (Bx=1)";
	#1     {clr, a1, a2, b1, b2} <= 5'b10111; descr <= "";

	#5000  $display("-------------------------------------------------------");
		   {clr, a1, a2, b1, b2} <= 5'b00x11; descr <= "^ on Clr (A1=0,Bx=1)";
	#1     {clr, a1, a2, b1, b2} <= 5'b10x11; descr <= "";

	#5000  $display("-------------------------------------------------------");
		   {clr, a1, a2, b1, b2} <= 5'b0x011; descr <= "^ on Clr (A2=0,Bx=1)";
	#1     {clr, a1, a2, b1, b2} <= 5'b1x011; descr <= "";

	#5000  $display("-------------------------------------------------------");
		   {clr, a1, a2, b1, b2} <= 5'b10x01; descr <= "^ on B1 (A1=0)";
	#1     {clr, a1, a2, b1, b2} <= 5'b10x11; descr <= "";
	#2000  {clr, a1, a2, b1, b2} <= 5'b10x01; descr <= "Retrigger on B1";
	#1     {clr, a1, a2, b1, b2} <= 5'b10x11; descr <= "";



end

endmodule


