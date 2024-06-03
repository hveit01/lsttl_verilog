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
// 8 bit shift register with output register
`timescale 1ns / 100ps
`include "sn74ls594.v"

module sn74ls594_testbench;
reg [80*8-1:0] descr;
reg sclr, rclr, sck, rck, ser;
wire [7:0] q;
wire qh;

sn74ls594 dut(.q(q), .qh(qh), .sclr(sclr), .sck(sck), .rclr(rclr), .rck(rck), .ser(ser));

initial
begin
	#1		{rclr, rck, sclr, sck, ser} <= 5'bx_x_x_x_x; descr <= "init";

	$dumpfile("sn74ls594.vcd");
	$dumpvars;
	$monitor("T=%5g: rclr=%1b rck=%1b sclr=%1b sck=%1b ser=%1b | q=%8b qh=%1b | %0s", 
		$time, rclr, rck, sclr, sck, ser, q, qh, descr);
	
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b0_x_0_x_x; descr <= "clear shift, reg";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_x; descr <= "no change";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_0_x; descr <= "shift 1";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_1; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_0_x; descr <= "shift 1";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_1; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_0_x; descr <= "shift 1";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_1; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_0_x; descr <= "shift 1";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_1; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_0_1_1_x; descr <= "store shift (=00001111)";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_1; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_0_x; descr <= "shift 1";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_1; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_0_x; descr <= "shift 1";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_1; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_0_x; descr <= "shift 1";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_1; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_0_x; descr <= "shift 1";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_1; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_0_1_1_1; descr <= "store shift (=11111111)";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_1; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_0_x; descr <= "shift 0";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_0; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_0_x; descr <= "shift 0";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_0; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_0_1_1_1; descr <= "store shift (=11111100)";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_1; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_0_1_x; descr <= "clear shift";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_x; descr <= "";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_0_1_1_1; descr <= "store shift (=00000000)";
	#40 	{rclr, rck, sclr, sck, ser} <= 5'b1_1_1_1_1; descr <= "";

end

endmodule


