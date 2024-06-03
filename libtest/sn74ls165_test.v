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
// 8 bit shift register
`timescale 1ns / 100ps
`include "sn74ls165.v"

module sn74ls165_testbench;
reg [80*8-1:0] descr;
reg load, en, clk, ser;
reg [7:0] p;
wire qh, qh_;

sn74ls165 dut(.qh(qh), .qh_(qh_), .load(load), .ser(ser), .clk(clk), .en(en), .p(p));

initial
begin
			    {load, clk, en, ser, p} <= 12'bx_x_x_x_xxxxxxxx; descr <= "init";

	$dumpfile("sn74ls165.vcd");
	$dumpvars;
	$monitor("T=%5g: load=%1b p=%8b clk=%1b en=%1b ser=%1b | shifter=%8b | qh=%1b qh_=%1b | %0s", $time, load, p, clk, en, ser, dut.shifter, qh, qh_, descr);
	
	#40 		{load, clk, en, ser, p} <= 12'b0_x_x_x_10100101; descr <= "load P";

	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_0_xxxxxxxx; descr <= "shift 0 (clk^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_1_0_0_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_0_xxxxxxxx; descr <= "shift 0 (clk^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_1_0_0_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_0_xxxxxxxx; descr <= "shift 0 (clk^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_1_0_0_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_0_xxxxxxxx; descr <= "shift 0 (clk^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_1_0_0_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_0_xxxxxxxx; descr <= "shift 0 (clk^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_1_0_0_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_0_xxxxxxxx; descr <= "shift 0 (clk^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_1_0_0_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_0_xxxxxxxx; descr <= "shift 0 (clk^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_1_0_0_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_0_xxxxxxxx; descr <= "shift 0 (clk^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_1_0_0_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_1_xxxxxxxx; descr <= "shift 1 (en^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_1_1_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_1_xxxxxxxx; descr <= "shift 1 (en^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_1_1_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_1_xxxxxxxx; descr <= "shift 1 (en^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_1_1_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_1_xxxxxxxx; descr <= "shift 1 (en^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_1_1_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_1_xxxxxxxx; descr <= "shift 1 (en^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_1_1_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_1_xxxxxxxx; descr <= "shift 1 (en^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_1_1_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_1_xxxxxxxx; descr <= "shift 1 (en^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_1_1_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_1_xxxxxxxx; descr <= "shift 1 (en^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_1_1_xxxxxxxx; descr <= "";
	#40 		{load, clk, en, ser, p} <= 12'b1_0_0_0_xxxxxxxx; descr <= "shift 0 (clk^)";
	#40 		{load, clk, en, ser, p} <= 12'b1_1_0_0_xxxxxxxx; descr <= "";
end

endmodule


