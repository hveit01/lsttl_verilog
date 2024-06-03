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
`include "sn74ls290.v"

module sn74ls290_testbench;
reg [80*8-1:0] descr;
reg clka, clr;
reg [1:0] r0, r9;
wire qa, qb, qc, qd;
wire dec;
integer i;
sn74ls290 dut(.qa(qa), .qb(qb), .qc(qc), .qd(qd), .clka(clka), .clkb(dec), .r0(r0), .r9(r9));
assign dec = qa;

initial
begin
	{clka, r0, r9} <= 5'bx_11_00; descr <= "INIT";
	i = 0;

	$dumpfile("sn74ls290.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: clka=%1b r0=%2b r9=%2b | dcba=%1b%1b%1b%1b | %0s", $time, clka, r0, r9, qd, qc, qb, qa, descr);

	#50 {clka, r0, r9} <= 5'bx_11_0x; descr <= "RESET R0";
	#50 {clka, r0, r9} <= 5'bx_0x_11; descr <= "RESET R9";
	#50 {clka, r0, r9} <= 5'bx_11_x0; descr <= "RESET R0";
	#50 {clka, r0, r9} <= 5'bx_x0_11; descr <= "RESET R9";
	#50 {clka, r0, r9} <= 5'bx_11_00; descr <= "RESET R0";
	#50 {clka, r0, r9} <= 5'b0_11_00; descr <= "";
	#50 {clka, r0, r9} <= 5'b1_11_00; descr <= "HOLD WHILE RESET";
	#50 {clka, r0, r9} <= 5'b0_11_00; descr <= "";
	#50 {clka, r0, r9} <= 5'b0_00_00; descr <= "ALLOW CLOCK";
	for(i=0; i<20; i=i+1) begin
		#50 {clka, r0, r9} <= 5'b0_00_00; descr <= "CLK PULSE";
		#50 {clka, r0, r9} <= 5'b1_00_00; descr <= "";
		#50 {clka, r0, r9} <= 5'b0_00_00; descr <= "";
	end
	
end

endmodule


