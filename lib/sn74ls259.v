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
// 8 bit addressable latch
module sn74ls259(q, a, b, c, clr, data, en);
input a, b, c, clr, data, en;
output [7:0] q;
reg [7:0] latch, dec;
wire [2:0] addr;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=19, tPLH_max=30, // worst case
	tPHL_min=0, tPHL_typ=13, tPHL_max=20;

initial
begin
	latch = 8'bxxxxxxxx;
end

assign addr = { c, b, a };
assign ce = { clr, en };

always @(en)
begin
	if (en==0)
		latch[addr] <= clr==0 ? 1'b0 : data;
end

always @(addr, en, data)
begin
	dec <= 8'b00000000;
	dec[addr] <= ~en & data;
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	q = clr==0 ? dec : latch;

endmodule
