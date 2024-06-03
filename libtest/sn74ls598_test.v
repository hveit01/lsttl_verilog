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
// 8 bit shift register with input register, tristate
`timescale 1ns / 100ps
`include "sn74ls598.v"

module sn74ls598_testbench;
reg [80*8-1:0] descr;
reg sclr, sck, rck, ser, cload, ser1, ser2, g, ds;
reg [7:0] in;
wire [7:0] bus;
wire qh;

sn74ls598 dut(.qh(qh), .sclr(sclr), .sck(sck), .rck(rck), .ser1(ser1), .ser2(ser2), .g(g), .ds(ds), .cload(cload), .io(bus));
assign bus = in;

initial
begin
	#1		{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'bx_x_x_x_x_xxxxxxxx_xx_x; descr <= "init";

	$dumpfile("sn74ls597.vcd");
	$dumpvars;
	$monitor("T=%5g: g=%1b rck=%1b sclr=%1b sck=%1b cload=%1b in=%8b ser=%1b%1b ds=%1b | q=%8b qh=%1b | %0s", 
		$time, g, rck, sclr, sck, cload, in, ser1, ser2, ds, bus, qh, descr);
	
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_0_1_1_zzzzzzzz_xx_x; descr <= "clear shift";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_xx_x; descr <= "no change";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 1 from ser1";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_1x_0; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b1_0_1_1_1_zzzzzzzz_xx_x; descr <= "load input (=00001111)";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b1_1_1_1_1_00001111_xx_x; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_0_zzzzzzzz_xx_x; descr <= "cload shift (=00001111)";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 1 from ser2";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_x1_1; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 1 from ser2";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_x1_1; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 1 from ser2";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_x1_1; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 1 from ser2";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_x1_1; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b1_1_1_1_1_zzzzzzzz_xx_x; descr <= "disable output";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 0 from ser2";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_x0_1; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 0 from ser2";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_x0_1; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 0 from ser2";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_x0_1; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 0 from ser1";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_0x_0; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 0 from ser1";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_0x_0; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 0 from ser2";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_x0_1; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_0_1_1_1_zzzzzzzz_xx_x; descr <= "load input from shift";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_xx_x; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 0 from ser1";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_0x_0; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 0 from ser2";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_x0_1; descr <= "";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_0_zzzzzzzz_xx_x; descr <= "cload from reg (=11000000)";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_0_1_zzzzzzzz_xx_x; descr <= "shift 0 from ser2";
	#50 	{g, rck, sclr, sck, cload, in, ser1, ser2, ds} <= 16'b0_1_1_1_1_zzzzzzzz_x0_1; descr <= "";

end

endmodule


