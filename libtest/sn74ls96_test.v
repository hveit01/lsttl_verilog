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
// Decade counter
`timescale 1ns / 100ps
`include "sn74ls96.v"

module sn74ls96_testbench;
reg [80*8-1:0] descr;
reg clk, clr, pre, ser;
reg a, b, c, d, e;
wire qa, qb, qc, qd, qe;

sn74ls96 dut(.qa(qa), .qb(qb), .qc(qc), .qd(qd), .qe(qe), .a(a), .b(b), .c(c), .d(d), .e(e),
             .clk(clk), .preset(pre), .clear(clr), .ser(ser));

initial
begin

	$dumpfile("sn74ls96.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: clr=%1b pre=%1b edcba=%1b%1b%1b%1b%1b clk=%1b ser=%1b  | q=%1b%1b%1b%1b%1b | %0s", 
		$time, clr, pre, e, d, c, b, a, clk, ser, qe, qd, qc, qb, qa, descr);

         {clr, pre, e, d, c, b, a, clk, ser} <= 9'b00_xxxxx_x_x; descr <= "Clear by Pre=0";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b0x_00000_x_x; descr <= "Clear by 00000";

    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b11_11111_x_x; descr <= "Preset to 11111";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b11_00000_0_x; descr <= "Preset no change";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b0x_00000_0_x; descr <= "Clear to 00000";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b11_10101_0_x; descr <= "Preset 1x1x1";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b10_xxxxx_0_x; descr <= "No change";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b10_xxxxx_1_1; descr <= "Shift 1 by clk=^";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b10_xxxxx_0_1; descr <= "";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b10_xxxxx_1_0; descr <= "Shift 0 by clk=^";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b10_xxxxx_0_0; descr <= "";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b10_xxxxx_1_0; descr <= "Shift 0 by clk=^";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b10_xxxxx_0_0; descr <= "";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b10_xxxxx_1_0; descr <= "Shift 0 by clk=^";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b10_xxxxx_0_0; descr <= "";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b10_xxxxx_1_1; descr <= "Shift 1 by clk=^";
    #100 {clr, pre, e, d, c, b, a, clk, ser} <= 9'b10_xxxxx_0_1; descr <= "";
	
end

endmodule


