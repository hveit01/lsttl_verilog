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
// 8 bit shift register with output register, open collector
`timescale 1ns / 100ps
`include "sn74ls596.v"

module sn74ls596_testbench;
reg [80*8-1:0] descr;
reg sclr, g, sck, rck, ser;
wire [7:0] q;
wire qh;

sn74ls596 dut(.q(q), .qh(qh), .sclr(sclr), .sck(sck), .g(g), .rck(rck), .ser(ser));
//pullup(q[0]);
//pullup(q[1]);
//pullup(q[2]);
//pullup(q[3]);
//pullup(q[4]);
//pullup(q[5]);
//pullup(q[6]);
//pullup(q[7]);

initial
begin
	#1		{g, rck, sclr, sck, ser} <= 5'bx_x_x_x_x; descr <= "init";

	$dumpfile("sn74ls596.vcd");
	$dumpvars;
	$display("Pullups disabled - H values shown as Z");
	$monitor("T=%5g: g=%1b rck=%1b sclr=%1b sck=%1b ser=%1b | q=%8b qh=%1b | %0s", 
		$time, g, rck, sclr, sck, ser, q, qh, descr);
	
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_0_1_x; descr <= "clear shift";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_x; descr <= "no change";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_0_x; descr <= "shift 1";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_1; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_0_1_1_x; descr <= "store shift (=00000001)";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_1; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b1_1_1_1_x; descr <= "disable output";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_0_x; descr <= "shift 1";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_1; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_0_x; descr <= "shift 1";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_1; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_0_x; descr <= "shift 1";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_1; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_0_1_1_x; descr <= "store shift (=00001111)";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_1; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_0_x; descr <= "shift 1";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_1; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_0_x; descr <= "shift 1";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_1; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_0_x; descr <= "shift 1";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_1; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_0_x; descr <= "shift 1";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_1; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_0_1_1_1; descr <= "store shift (=11111111)";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_1; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_0_x; descr <= "shift 0";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_0; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_0_x; descr <= "shift 0";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_0; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_0_1_1_1; descr <= "store shift (=11111100)";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_1; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_0_1_x; descr <= "clear shift";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_x; descr <= "";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_0_1_1_1; descr <= "store shift (=00000000)";
	#50 	{g, rck, sclr, sck, ser} <= 5'b0_1_1_1_1; descr <= "";

end

endmodule


