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
// Decade counter
`timescale 1ns / 100ps
`include "sn74ls393.v"

module sn74ls393_testbench;
reg [80*8-1:0] descr;
reg clk, clr;
wire qa, qb, qc, qd;
wire dec;
integer i;
sn74ls393 dut(.qa(qa), .qb(qb), .qc(qc), .qd(qd), .clk(clk), .clr(clr));

initial
begin
	{clk, clr} <= 2'bx_x; descr <= "INIT";
	i = 0;

	$dumpfile("sn74ls393.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: clk=%1b clr=%1b | dcba=%1b%1b%1b%1b | %0s", $time, clk, clr, qd, qc, qb, qa, descr);

	#60 {clk, clr} <= 2'bx_1; descr <= "clear";
	#60 {clk, clr} <= 2'b0_1; descr <= "hold while clear";
	#60 {clk, clr} <= 2'b1_1; descr <= "";
	for(i=0; i<20; i=i+1) begin
		#60 {clk, clr} <= 2'b0_0; descr <= "CLK PULSE";
		#60 {clk, clr} <= 2'b1_0; descr <= "";
	end
	
end

endmodule


