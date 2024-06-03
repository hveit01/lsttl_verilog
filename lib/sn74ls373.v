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
// 8 bit latch
module sn74ls373(q, d, en, oe);
input [7:0] d;
input en, oe;
reg [7:0] ff;
output [7:0] q;
wire oeint;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=12, tPLH_max=18,
	tPHL_min=0, tPHL_typ=12, tPHL_max=18,
	tPZH_min=0, tPZH_typ=15-tPLH_typ, tPZH_max=28-tPLH_max,
	tPZL_min=0, tPZL_typ=25-tPHL_typ, tPZL_max=36-tPHL_max;

initial
begin
	ff <= 8'bxxxxxxxx;
end

always @(en, d)
begin
	if (en==1)
		ff <= d;
end

assign #(tPZH_min:tPZH_typ:tPZH_max, tPZL_min:tPZL_typ:tPZL_max)
	oeint = oe;

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	q = oeint==0 ? (en==0 ? ff : d) : 8'bzzzzzzzz;
endmodule
