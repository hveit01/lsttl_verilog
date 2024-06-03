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
// Decade counter
`timescale 1ns / 100ps
`include "sn74ls390.v"

module sn74ls390_testbench;
reg [80*8-1:0] descr;
reg clka, clkb, clr;
wire qa, qb, qc, qd;
wire dec;
integer i;
sn74ls390 dut(.qa(qa), .qb(qb), .qc(qc), .qd(qd), .clka(clka), .clkb(dec), .clr(clr));
assign dec = qa;

initial
begin
	{clka, clr} <= 2'bx_1; descr <= "INIT";
	i = 0;

	$dumpfile("sn74ls390.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: clka=%1b clr=%1b | dcba=%1b%1b%1b%1b | %0s", $time, clka, clr, qd, qc, qb, qa, descr);
	$display("CLKB is connected to QA");

	#50 {clka, clr} <= 2'bx_1; descr <= "RESET R0";
	#50 {clka, clr} <= 2'b0_1; descr <= "HOLD WHILE RESET";
	#50 {clka, clr} <= 2'b1_1; descr <= "";
	for(i=0; i<12; i=i+1) begin
		#50 {clka, clr} <= 2'b0_0; descr <= "CLK PULSE";
		#50 {clka, clr} <= 2'b1_0; descr <= "";
	end
	
end

endmodule


