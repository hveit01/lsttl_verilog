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
// 8 bit register
module sn74ls374(q, d, clk, oe);
input [7:0] d;
input clk, oe;
reg [7:0] ff;
output [7:0] q;
wire oeint;

parameter
	// TI TTL data book Vol 1, 1985
	tPZH_min=0, tPZH_typ=15, tPZH_max=28,
	tPZL_min=0, tPZL_typ=25, tPZL_max=36;

initial
begin
	ff <= 8'bxxxxxxxx;
end

always @(posedge clk)
begin
	if (clk==1)
		ff <= d;
end

assign #(tPZH_min:tPZH_typ:tPZH_max, tPZL_min:tPZL_typ:tPZL_max)
	oeint = oe;

assign q = oeint==0 ? ff : 8'bzzzzzzzz;
endmodule
