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
module sn74ls541(q, a, g1_, g2_);
input [7:0] a;
input g1_, g2_;
output [7:0] q;
wire gint;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=9,           tPLH_max=15,
	tPHL_min=0, tPHL_typ=10,          tPHL_max=18,
	tPZH_min=0, tPZH_typ=20-tPLH_typ, tPZH_max=32-tPLH_max,
	tPZL_min=0, tPZL_typ=25-tPHL_typ, tPZL_max=38-tPHL_max;
// does not respect tPHZ, tPLZ !

	assign #(tPZH_min : tPZH_typ : tPZH_max,
		   tPZL_min : tPZL_typ : tPZL_max)
		gint = g1_==0 && g2_==0;

	assign #(tPLH_min : tPLH_typ : tPLH_max,
  		     tPHL_min : tPHL_typ : tPHL_max)
		q = gint ? a : 8'bzzzzzzzz;

endmodule
