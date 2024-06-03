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
// Shift Register
`timescale 1ns / 100ps
`include "sn74ls295.v"

module sn74ls295_1_testbench;
reg [80*8-1:0] descr;
reg clk, ser, mode, oe;
reg [3:0] in;
wire [3:0] q;

sn74ls295 dut(.q(q), .in(in), .clk(clk), .mode(mode), .ser(ser), .oe(oe));

initial
begin

	$dumpfile("sn74ls295_1.vcd");
	$dumpvars;
	$printtimescale(dut);
	$display("This is the basic shifter, without external circuitry for left shift");
	$monitor("T=%5t: oe=%1b mode=%1b clk=%1b ser=%1b in=%4b | q=%4b | %0s", 
		$time, oe, mode, clk, ser, in, q, descr);

    #1 {oe, mode, clk, ser, in} <= 8'bxxx_x_xxxx; descr <= "INIT";


    #50 {oe, mode, clk, ser, in} <= 8'b111_x_0001; descr <= "Load 0001";
	#50 {oe, mode, clk, ser, in} <= 8'b110_x_0001; descr <= "";

	#50 {oe, mode, clk, ser, in} <= 8'b111_x_xxxx; descr <= "No change";

	#50 {oe, mode, clk, ser, in} <= 8'b101_1_0001; descr <= "Shift right 1";
	#50 {oe, mode, clk, ser, in} <= 8'b100_1_0001; descr <= "";

	#50 {oe, mode, clk, ser, in} <= 8'b101_0_0001; descr <= "Shift right 0";
	#50 {oe, mode, clk, ser, in} <= 8'b100_0_0001; descr <= "";

	#50 {oe, mode, clk, ser, in} <= 8'b101_1_0001; descr <= "Shift right 1";
	#50 {oe, mode, clk, ser, in} <= 8'b100_1_0001; descr <= "";

	#50 {oe, mode, clk, ser, in} <= 8'b101_1_0001; descr <= "Shift right 1";
	#50 {oe, mode, clk, ser, in} <= 8'b100_1_0001; descr <= "";

	#50 {oe, mode, clk, ser, in} <= 8'b101_0_0001; descr <= "Shift right 0";
	#50 {oe, mode, clk, ser, in} <= 8'b100_0_0001; descr <= "";

    #50 {oe, mode, clk, ser, in} <= 8'b0x1_x_xxxx; descr <= "output disable";
    #50 {oe, mode, clk, ser, in} <= 8'b1x1_x_xxxx; descr <= "output enable";
end

endmodule


