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
`include "sn74ls95.v"

module sn74ls95_testbench;
reg [80*8-1:0] descr;
reg clk1, clk2, ser, mode;
reg a, b, c, d;
wire qa, qb, qc, qd;

sn74ls95 dut(.qa(qa), .qb(qb), .qc(qc), .qd(qd), .a(a), .b(b), .c(c), .d(d), .clk1(clk1), .clk2(clk2), .mode(mode), .ser(ser));

initial
begin

	$dumpfile("sn74ls95.vcd");
	$dumpvars;
	$printtimescale(dut);
	$monitor("T=%5t: mode=%1b clk1=%1b clk2=%1b ser=%1b dcba=%1b%1b%1b%1b | q=%1b%1b%1b%1b | %0s", 
		$time, mode, clk1, clk2, ser, d, c, b, a, qd, qc, qb, qa, descr);

        {mode, clk1, clk2, ser, d, c, b, a} <= 8'b11x_x_0001; descr <= "Load 0001";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b10x_x_0001; descr <= "v on clk1";

	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b001_x_xxxx; descr <= "No change (mode=0, clk*=01)";

	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b1x1_1_0001; descr <= "Shift right 1";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b1x0_1_0001; descr <= "v on clk2";

	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b1x1_0_0001; descr <= "Shift right 0";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b1x0_0_0001; descr <= "v on clk2";

	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b1x1_1_0001; descr <= "Shift right 1";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b1x0_1_0001; descr <= "v on clk2";

	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b1x1_1_0001; descr <= "Shift right 1";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b1x0_1_0001; descr <= "v on clk2";

	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b1x1_1_0001; descr <= "Shift right 1";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b1x0_1_0001; descr <= "v on clk2";

	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b110_x_0101; descr <= "Load 0101";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b100_x_0101; descr <= "v on clk1";

	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b100_x_xxxx; descr <= "No change (mode=v, clk*=00)";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b000_x_xxxx; descr <= "v on mode";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b101_x_xxxx; descr <= "No change (mode=v, clk*=01)";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b001_x_xxxx; descr <= "v on mode";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b010_x_xxxx; descr <= "No change (mode=^, clk*=10)";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b110_x_xxxx; descr <= "^ on mode";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b011_x_xxxx; descr <= "No change (mode=^, clk*=11)";
	#50 {mode, clk1, clk2, ser, d, c, b, a} <= 8'b111_x_xxxx; descr <= "^ on mode";
	
end

endmodule


