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
// 8 bit comparator, open collector
`timescale 1ns / 100ps
`include "sn74ls689.v"

module sn74ls689_testbench;
reg [80*8-1:0] descr;
reg [7:0] p, q;
reg g;
wire p_eq_q;

sn74ls689 dut(.p_eq_q(p_eq_q), .p(p), .q(q), .g(g));

initial
begin
	{g, p, q} <= 17'bx_xxxxxxxx_xxxxxxxx; descr <= "INIT";

	$dumpfile("sn74ls689.vcd");
	$dumpvars;
	$display("no pullup, H shown as Z");
	$monitor("T=%5g: g=%1b p=%8b q=%8b | (p=q)=%1b | %0s", $time, g, p, q, p_eq_q, descr);
	
	#30 	{g, p, q} <= 17'b1_xxxxxxxx_xxxxxxxx; descr <= "g=1";
	#30 	{g, p, q} <= 17'b0_11111111_11111111; descr <= "same";
	#30 	{g, p, q} <= 17'b0_00000000_00000000; descr <= "";
	#30 	{g, p, q} <= 17'b0_11001100_11001100; descr <= "";
	#30 	{g, p, q} <= 17'b0_11111111_00000000; descr <= "different";
	#30 	{g, p, q} <= 17'b0_11001100_00110011; descr <= "";
	#30 	{g, p, q} <= 17'b0_11001100_11001101; descr <= "";
	#30 	{g, p, q} <= 17'b0_11110000_11110010; descr <= "";
end

endmodule


