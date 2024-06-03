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
// 8 bit comparator
`timescale 1ns / 100ps
`include "sn74ls686.v"

module sn74ls686_testbench;
reg [80*8-1:0] descr;
reg [7:0] p, q;
reg g;
wire p_eq_q, p_gt_q;

sn74ls686 dut(.p_eq_q(p_eq_q), .p_gt_q(p_gt_q), .p(p), .q(q), .g(g));

initial
begin
	{g, g, p, q} <= 17'bx_xxxxxxxx_xxxxxxxx; descr <= "INIT";

	$dumpfile("sn74ls686.vcd");
	$dumpvars;
	$monitor("T=%5g: g=%1b p=%8b q=%8b | (p=q)=%1b (p>q)=%1b | %0s", $time, g, p, q, p_eq_q, p_gt_q, descr);
	
	#50 	{g, p, q} <= 17'b1_11111111_11111111; descr <= "g=1";
	#50 	{g, p, q} <= 17'b0_11111111_11111111; descr <= "same";
	#50 	{g, p, q} <= 17'b0_11111111_00000000; descr <= "greater";
	#50 	{g, p, q} <= 17'b0_00110011_11001100; descr <= "less";
	#50 	{g, p, q} <= 17'b0_00000000_00000000; descr <= "same";
	#50 	{g, p, q} <= 17'b0_11001100_00110011; descr <= "greater";
	#50 	{g, p, q} <= 17'b0_00111100_00111101; descr <= "less";
	#50 	{g, p, q} <= 17'b0_11001100_11001100; descr <= "same";
end

endmodule


