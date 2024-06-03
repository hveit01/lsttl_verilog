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
// Tristate buffer, noninverting
module sn74ls449(a, b, gab, gba, dir);
inout [3:0] a, b;
input gab, gba;
input [3:0] dir;
wire gabi, gbai;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=8,         tPLH_max=13,
	tPHL_min=0, tPHL_typ=7,         tPHL_max=12,
	tPZH_min=0, tPZH_typ=24-tPLH_typ, tPZH_max=40-tPLH_max,
	tPZL_min=0, tPZL_typ=25-tPHL_typ, tPZL_max=15-tPHL_max;
// does not respect tPHZ, tPLZ !

assign #(tPZH_min:tPZH_typ:tPZH_max,
	     tPZL_min:tPZL_typ:tPZL_max)
	gbai = gba;
assign #(tPZH_min:tPZH_typ:tPZH_max,
	     tPZL_min:tPZL_typ:tPZL_max)
	gabi = gab;

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	a[0] = gbai==1'b0 && dir[0]==1'b0 ? b[0] : 1'bz;
assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	a[1] = gbai==1'b0 && dir[1]==1'b0 ? b[1] : 1'bz;
assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	a[2] = gbai==1'b0 && dir[2]==1'b0 ? b[2] : 1'bz;
assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	a[3] = gbai==1'b0 && dir[3]==1'b0 ? b[3] : 1'bz;
assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	b[0] = gabi==1'b0 && dir[0]==1'b1 ? a[0] : 1'bz;
assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	b[1] = gabi==1'b0 && dir[1]==1'b1 ? a[1] : 1'bz;
assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	b[2] = gabi==1'b0 && dir[2]==1'b1 ? a[2] : 1'bz;
assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	b[3] = gabi==1'b0 && dir[3]==1'b1 ? a[3] : 1'bz;

endmodule
