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
module sn74ls377(q, d, clk, g);
input [7:0] d;
input clk, g;
reg [7:0] ff;
output [7:0] q;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=17, tPLH_max=27,
	tPHL_min=0, tPHL_typ=28, tPHL_max=27;

initial
begin
	ff <= 8'bxxxxxxxx;
end

always @(posedge clk)
begin
	if (g==0 && clk==1)
		ff <= d;
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	q = ff;
endmodule
