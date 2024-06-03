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

module sn74ls295_2_testbench;
reg [80*8-1:0] descr;
reg clk, ser, mode, oe;
wire [3:0] q;
wire [2:0] in;
reg in3;

sn74ls295 dut(.q(q), .in({in3, in}), .clk(clk), .mode(mode), .ser(ser), .oe(oe));
buf(in[0], q[1]);
buf(in[1], q[2]);
buf(in[2], q[3]);

initial
begin

	$dumpfile("sn74ls295_2.vcd");
	$dumpvars;
	$printtimescale(dut);
	$display("This is the shifter, with external circuitry for left shift.");
	$display("No parallel load possible. Shift left through input3");
	$monitor("T=%5t: oe=%1b mode=%1b clk=%1b ser=%1b in=%1b%3b | q=%4b | %0s", 
		$time, oe, mode, clk, ser, in3, in, q, descr);

    #1  {oe, mode, clk, ser, in3} <= 5'bxxx_x_x; descr <= "INIT";

	#50 {oe, mode, clk, ser, in3} <= 5'b101_1_x; descr <= "Shift in 1010";
	#50 {oe, mode, clk, ser, in3} <= 5'b100_1_x; descr <= "";
	#50 {oe, mode, clk, ser, in3} <= 5'b101_0_x; 
	#50 {oe, mode, clk, ser, in3} <= 5'b100_0_x;
	#50 {oe, mode, clk, ser, in3} <= 5'b101_1_x;
	#50 {oe, mode, clk, ser, in3} <= 5'b100_1_x;
	#50 {oe, mode, clk, ser, in3} <= 5'b101_0_x;
	#50 {oe, mode, clk, ser, in3} <= 5'b100_0_x;

	#50 {oe, mode, clk, ser, in3} <= 5'b111_0_0; descr <= "Shift left 0";
	#50 {oe, mode, clk, ser, in3} <= 5'b110_0_0; descr <= "";
	#50 {oe, mode, clk, ser, in3} <= 5'b111_0_0; descr <= "Shift left 0";
	#50 {oe, mode, clk, ser, in3} <= 5'b110_0_0; descr <= "";
	#50 {oe, mode, clk, ser, in3} <= 5'b111_0_0; descr <= "Shift left 0";
	#50 {oe, mode, clk, ser, in3} <= 5'b110_0_0; descr <= "";
	#50 {oe, mode, clk, ser, in3} <= 5'b111_0_1; descr <= "Shift left 1";
	#50 {oe, mode, clk, ser, in3} <= 5'b110_0_1; descr <= "";
	#50 {oe, mode, clk, ser, in3} <= 5'b111_0_1; descr <= "Shift left 1";
	#50 {oe, mode, clk, ser, in3} <= 5'b110_0_1; descr <= "";
	#50 {oe, mode, clk, ser, in3} <= 5'b111_0_0; descr <= "Shift left 0";
	#50 {oe, mode, clk, ser, in3} <= 5'b110_0_0; descr <= "";

    #50 {oe, mode, clk, ser, in3} <= 5'b0x1_x_x; descr <= "output disable";
    #50 {oe, mode, clk, ser, in3} <= 5'b1x1_x_x; descr <= "output enable";
end

endmodule


