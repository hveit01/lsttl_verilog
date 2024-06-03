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
`include "sn74ls93.v"

module sn74ls93_testbench;
reg [80*8-1:0] descr;
reg clka, clr;
reg [1:0] r0;
wire qa, qb, qc, qd;
wire dec;
integer i;
sn74ls93 dut(.qa(qa), .qb(qb), .qc(qc), .qd(qd), .clka(clka), .clkb(dec), .r0(r0));
assign dec = qa;

initial
begin
	{clka, r0} <= 3'bx_11; descr <= "INIT";
	i = 0;

	$dumpfile("sn74ls93.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: clka=%1b r0=%2b | dcba=%1b%1b%1b%1b | %0s", $time, clka, r0, qd, qc, qb, qa, descr);

	#60 {clka, r0} <= 3'b0_11; descr <= "RESET R0";
	#60 {clka, r0} <= 3'b1_11; descr <= "HOLD WHILE RESET";
	#60 {clka, r0} <= 3'b0_11; descr <= "";
	#60 {clka, r0} <= 3'b0_00; descr <= "ALLOW CLOCK";
	for(i=0; i<20; i=i+1) begin
		#60 {clka, r0} <= 3'b0_00; descr <= "CLK PULSE";
		#60 {clka, r0} <= 3'b1_00; descr <= "";
		#60 {clka, r0} <= 3'b0_00; descr <= "";
	end
	
end

endmodule


