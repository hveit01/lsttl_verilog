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
// Tristate buffer
module sn74ls126(y, a, c);
input a, c;
output y;
wire cint;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=8,           tPLH_max=13,
	tPHL_min=0, tPHL_typ=12,          tPHL_max=18,
	tPZH_min=0, tPZH_typ=11-tPLH_typ, tPZH_max=18-tPLH_max,
	tPZL_min=0, tPZL_typ=16-tPHL_typ, tPZL_max=25-tPHL_max;
// does not respect tPHZ, tPLZ !

	assign #(tPZH_min : tPZH_typ : tPZH_max,
		   tPZL_min : tPZL_typ : tPZL_max)
		cint = c;
	assign #(tPLH_min : tPLH_typ : tPLH_max,
		   tPHL_min : tPHL_typ : tPHL_max)
		y = cint ? a : 1'bz;

endmodule
