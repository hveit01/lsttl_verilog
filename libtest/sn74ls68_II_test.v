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
`include "sn74ls68.v"

module sn74ls68_II_testbench;
reg [80*8-1:0] descr;
reg clk, clr;
wire qa, qb, qc, qd;
wire dec;

sn74ls68_II dut(.qa(qa), .qb(qb), .qc(qc), .qd(qd), .clk(clk), .clr(clr));
assign dec = qa;

initial
begin
	{clk, clr} <= 2'b0_1; descr <= "INIT";

	$dumpfile("sn74ls68_II.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: clk=%1b clr=%1b | qdcba=%1b%1b%1b%1b | %0s", $time, clk, clr, qd, qc, qb, qa, descr);

	#50 {clk, clr} <= 2'bx_0; descr <= "RESET";
	#50 {clk, clr} <= 2'b0_0; descr <= "";
	#50 {clk, clr} <= 2'b1_0; descr <= "HOLD WHILE RESET";
	#50 {clk, clr} <= 2'b0_0; descr <= "";
	#50 {clk, clr} <= 2'b0_1; descr <= "ALLOW CLOCK";
	
	#50 {clk, clr} <= 2'b1_1; descr <= "^";
	#50 {clk, clr} <= 2'b0_1; descr <= "CLK1";
	#50 {clk, clr} <= 2'b1_1; descr <= "^";
	#50 {clk, clr} <= 2'b0_1; descr <= "CLK2";
	#50 {clk, clr} <= 2'b1_1; descr <= "^";
	#50 {clk, clr} <= 2'b0_1; descr <= "CLK3";
	#50 {clk, clr} <= 2'b1_1; descr <= "^";
	#50 {clk, clr} <= 2'b0_1; descr <= "CLK4";
	#50 {clk, clr} <= 2'b1_1; descr <= "^";
	#50 {clk, clr} <= 2'b0_1; descr <= "CLK5";
	#50 {clk, clr} <= 2'b1_1; descr <= "^";
	#50 {clk, clr} <= 2'b0_1; descr <= "CLK6";
	#50 {clk, clr} <= 2'b1_1; descr <= "^";
	#50 {clk, clr} <= 2'b0_1; descr <= "CLK7";
	#50 {clk, clr} <= 2'b1_1; descr <= "^";
	#50 {clk, clr} <= 2'b0_1; descr <= "CLK8";
	#50 {clk, clr} <= 2'b1_1; descr <= "^";
	#50 {clk, clr} <= 2'b0_1; descr <= "CLK9";
	#50 {clk, clr} <= 2'b1_1; descr <= "^";
	#50 {clk, clr} <= 2'b0_1; descr <= "CLK10";
	#50 {clk, clr} <= 2'b1_1; descr <= "^";
	#50 {clk, clr} <= 2'b0_1; descr <= "CLK11";
	#50 {clk, clr} <= 2'b1_1; descr <= "^";
	#50 {clk, clr} <= 2'b0_1; descr <= "CLK12";
	#50 {clk, clr} <= 2'b1_1; descr <= "^";
	#50 {clk, clr} <= 2'b0_1; descr <= "CLK13";
	
end

endmodule


