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
// 8 bit shift register
`timescale 1ns / 100ps
`include "sn74ls91.v"

module sn74ls91_testbench;
reg [80*8-1:0] descr;
reg clk, a, b;
wire qh, qh_;
integer i;
sn74ls91 dut(.qh(qh), .qh_(qh_), .clk(clk), .a(a), .b(b));

initial
begin
	{clk, a, b} <= 3'bx_00; descr <= "INIT";

	$dumpfile("sn74ls91.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: clk=%1b ab=%1b%1b | qh=%1b qh_=%1b | %0s", $time, clk, a, b, qh, qh_, descr);

	#50 {clk, a, b} <= 3'b0_x0; descr <= "CLK PULSE in=0";
	#50 {clk, a, b} <= 3'b1_x0; descr <= "^";
	#50 {clk, a, b} <= 3'b0_xx; descr <= "v";
	for(i=0; i<5; i=i+1) begin
		#50 {clk, a, b} <= 3'b0_0x; descr <= "CLK PULSE in=0";
		#50 {clk, a, b} <= 3'b1_0x; descr <= "^";
		#50 {clk, a, b} <= 3'b0_xx; descr <= "v";
		#50 {clk, a, b} <= 3'b0_11; descr <= "CLK PULSE in=1";
		#50 {clk, a, b} <= 3'b1_11; descr <= "^";
		#50 {clk, a, b} <= 3'b0_xx; descr <= "v";
		#50 {clk, a, b} <= 3'b0_11; descr <= "CLK PULSE in=1";
		#50 {clk, a, b} <= 3'b1_11; descr <= "^";
		#50 {clk, a, b} <= 3'b0_xx; descr <= "v";
	end
end

endmodule


