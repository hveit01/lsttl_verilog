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
// 8-line to 4 line priority encoder testbench
`timescale 1ns / 100ps
`include "sn74ls348.v"

module sn74ls348_testbench;
reg [80*8-1:0] descr;
reg [7:0] i;
reg ei;
wire a2, a1, a0, eo, gs;

sn74ls348 dut(.i(i), .ei(ei), .a2(a2), .a1(a1), .a0(a0), .gs(gs), .eo(eo));

initial
begin
	{ei, i} <= 9'b1xxxxxxxx; descr <= "INIT";

	$dumpfile("sn74ls348.vcd");
	$dumpvars;
	$monitor("T=%5g: ei=%1b i=%8b | aa=%1b%1b%1b gs=%1b eo=%1b | %0s", $time, ei, i, a2, a1, a0, gs, eo, descr);
	
	#60 	{ei, i} <= 9'b011111111; descr <= "all 1";
	#60 	{ei, i} <= 9'b00xxxxxxx; descr <= "7";
	#60 	{ei, i} <= 9'b010xxxxxx; descr <= "6";
	#60 	{ei, i} <= 9'b0110xxxxx; descr <= "5";
	#60 	{ei, i} <= 9'b01110xxxx; descr <= "4";
	#60 	{ei, i} <= 9'b011110xxx; descr <= "3";
	#60 	{ei, i} <= 9'b0111110xx; descr <= "2";
	#60 	{ei, i} <= 9'b01111110x; descr <= "1";
	#60 	{ei, i} <= 9'b011111110; descr <= "0";
	#60     {ei, i} <= 9'b1xxxxxxxx; descr <= "ei=1";
end

endmodule


