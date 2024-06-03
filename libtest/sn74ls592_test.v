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
// binary counter with input register
`timescale 1ns / 100ps
`include "sn74ls592.v"

module sn74ls592_testbench;
reg [80*8-1:0] descr;
reg [7:0] in;
reg cck, rck, cclr, g, ccken, cload;
wire rco;

integer i;
sn74ls592 dut(.rco(rco), .cck(cck), .rck(rck), .cclr(cclr), .ccken(ccken), .cload(cload), .in(in));

initial
begin
	{cck, rck, cclr, ccken, cload, in} <= 13'bx_x_x_x_x_xxxxxxxx; descr <= "INIT";
	i = 0;

	$dumpfile("sn74ls592.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: cck=%1b rck=%1b cclr=%1b ccken=%1b cload=%1b in=%8b | rco=%1b cnt=%8b | %0s",
		$time, cck, rck, cclr, ccken, cload, in, rco, dut.cnt, descr);

	#1	$display(">>>> load 11110000");
	#50	{cck, rck, cclr, ccken, cload, in} <= 13'bx_0_1_1_1_11110000; descr <= "set input reg";
	#50	{cck, rck, cclr, ccken, cload, in} <= 13'bx_1_1_1_1_11110000; descr <= "";
	#50	{cck, rck, cclr, ccken, cload, in} <= 13'bx_1_1_1_0_xxxxxxxx; descr <= "load into cnt";
	
	#1	$monitor(""); $display("count 14 times to 11111110");
	for(i=0; i<14; i=i+1) begin
		#50	{cck, rck, cclr, ccken, cload, in} <= 13'b0_x_1_0_1_xxxxxxxx; descr <= "count";
		#50 {cck, rck, cclr, ccken, cload, in} <= 13'b1_x_1_0_1_xxxxxxxx; descr <= "";
	end
	#50	$monitor("T=%5t: cck=%1b rck=%1b cclr=%1b ccken=%1b cload=%1b in=%8b | rco=%1b cnt=%8b | %0s",
			$time, cck, rck, cclr, ccken, cload, in, rco, dut.cnt, descr);
		{cck, rck, cclr, ccken, cload, in} <= 13'b0_x_1_0_1_xxxxxxxx; descr <= "count";
	#50 {cck, rck, cclr, ccken, cload, in} <= 13'b1_x_1_0_1_xxxxxxxx; descr <= "";
	#50	{cck, rck, cclr, ccken, cload, in} <= 13'b0_x_1_0_1_xxxxxxxx; descr <= "count";
	#50 {cck, rck, cclr, ccken, cload, in} <= 13'b1_x_1_0_1_xxxxxxxx; descr <= "";
	#50	{cck, rck, cclr, ccken, cload, in} <= 13'b0_x_1_0_1_xxxxxxxx; descr <= "count";
	#50 {cck, rck, cclr, ccken, cload, in} <= 13'b1_x_1_0_1_xxxxxxxx; descr <= "";
	#50	$display("clear and count");
		{cck, rck, cclr, ccken, cload, in} <= 13'bx_x_0_1_1_xxxxxxxx; descr <= "clear";
	#50	{cck, rck, cclr, ccken, cload, in} <= 13'b0_x_1_0_1_xxxxxxxx; descr <= "count";
	#50 {cck, rck, cclr, ccken, cload, in} <= 13'b1_x_1_0_1_xxxxxxxx; descr <= "";
	
end

endmodule


