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
// 8 bit shift register with input register
`timescale 1ns / 100ps
`include "sn74ls597.v"

module sn74ls597_testbench;
reg [80*8-1:0] descr;
reg sclr, sck, rck, ser, cload;
reg [7:0] in;
wire qh;

sn74ls597 dut(.qh(qh), .sclr(sclr), .sck(sck), .rck(rck), .ser(ser), .cload(cload), .in(in));

initial
begin
	#1		{rck, sclr, sck, cload, in, ser} <= 13'bx_x_x_x_xxxxxxxx_x; descr <= "init";

	$dumpfile("sn74ls597.vcd");
	$dumpvars;
	$monitor("T=%5g: rck=%1b sclr=%1b sck=%1b cload=%1b in=%8b ser=%1b | qh=%1b shift=%8b | %0s", 
		$time, rck, sclr, sck, cload, in, ser, qh, dut.shifter, descr);
	
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_0_1_1_xxxxxxxx_x; descr <= "clear shift";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_x; descr <= "no change";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_0_1_xxxxxxxx_x; descr <= "shift 1";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_1; descr <= "";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b0_1_1_1_xxxxxxxx_x; descr <= "load input (=00001111)";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_00001111_x; descr <= "";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_0_xxxxxxxx_x; descr <= "cload shift (=00001111)";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_0_1_xxxxxxxx_x; descr <= "shift 1";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_1; descr <= "";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_0_1_xxxxxxxx_x; descr <= "shift 1";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_1; descr <= "";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_0_1_xxxxxxxx_x; descr <= "shift 1";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_1; descr <= "";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_0_1_xxxxxxxx_x; descr <= "shift 1";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_1; descr <= "";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_0_1_xxxxxxxx_x; descr <= "shift 0";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_0; descr <= "";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_0_1_xxxxxxxx_x; descr <= "shift 0";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_0; descr <= "";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_0_1_xxxxxxxx_x; descr <= "shift 0";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_0; descr <= "";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_0_1_xxxxxxxx_x; descr <= "shift 0";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_0; descr <= "";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_0_1_xxxxxxxx_x; descr <= "shift 0";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_0; descr <= "";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_0_1_xxxxxxxx_x; descr <= "shift 0";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_0; descr <= "";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_0_1_xxxxxxxx_x; descr <= "shift 0";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_0; descr <= "";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_0_1_xxxxxxxx_x; descr <= "shift 0";
	#50 	{rck, sclr, sck, cload, in, ser} <= 13'b1_1_1_1_xxxxxxxx_0; descr <= "";

end

endmodule


