// This code is part of the model collection of simulatable TTL devices.
// Note this does not necessarily mean they are synthesizable!!!
//
// Copyright (C) 2024 Holger Veit (hveit01@web.de)
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
// Decade counter
`timescale 1ns / 100ps
`include "sn74ls490.v"

module sn74ls490_testbench;
reg [80*8-1:0] descr;
reg clk, clr, r9;
wire [3:0] q;
wire dec;
integer i;
sn74ls490 dut(.q(q), .clk(clk), .clr(clr), .r9(r9));

initial
begin
	{clk, clr, r9} <= 3'bx_xx; descr <= "INIT";
	i = 0;

	$dumpfile("sn74ls490.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: clk=%1b clr=%1b r9=%1b | q=%4b | %0s", $time, clk, clr, r9, q, descr);

	#50 {clk, clr, r9} <= 3'bx_10; descr <= "clear";
	#50 {clk, clr, r9} <= 3'bx_01; descr <= "set to 9";
	for(i=0; i<12; i=i+1) begin
		#50 {clk, clr, r9} <= 3'b1_00; descr <= "count";
		#50 {clk, clr, r9} <= 3'b0_00; descr <= "";
	end
	
end

endmodule


