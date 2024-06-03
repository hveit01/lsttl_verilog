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
`include "sn74ls685.v"

module sn74ls685_testbench;
reg [80*8-1:0] descr;
reg [7:0] p, q;
wire p_eq_q, p_gt_q;

sn74ls685 dut(.p_eq_q(p_eq_q), .p_gt_q(p_gt_q), .p(p), .q(q));

initial
begin
	{p, q} <= 16'bxxxxxxxx_xxxxxxxx; descr <= "INIT";

	$dumpfile("sn74ls685.vcd");
	$dumpvars;
	$display("no pullup, so H is shown as Z");
	$monitor("T=%5g: p=%8b q=%8b | (p=q)=%1b (p>q)=%1b | %0s", $time, p, q, p_eq_q, p_gt_q, descr);
	
	#50 	{p, q} <= 16'b11111111_11111111; descr <= "same";
	#50 	{p, q} <= 16'b00000000_00000000; descr <= "";
	#50 	{p, q} <= 16'b11001100_11001100; descr <= "";
	#50 	{p, q} <= 16'b11111111_00000000; descr <= "greater";
	#50 	{p, q} <= 16'b00110011_11001100; descr <= "less";
	#50 	{p, q} <= 16'b11001100_00110011; descr <= "greater";
	#50 	{p, q} <= 16'b00111100_00111101; descr <= "less";
end

endmodule


