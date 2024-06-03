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
module sn74ls240(q_, a, g1_, g2_);
input [7:0] a;
input g1_, g2_;
output [7:0] q_;
wire gint1, gint2;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=9,           tPLH_max=14,
	tPHL_min=0, tPHL_typ=12,          tPHL_max=18,
	tPZH_min=0, tPZH_typ=15-tPLH_typ, tPZH_max=23-tPLH_max,
	tPZL_min=0, tPZL_typ=20-tPHL_typ, tPZL_max=30-tPHL_max;
// does not respect tPHZ, tPLZ !

	assign #(tPZH_min : tPZH_typ : tPZH_max,
		   tPZL_min : tPZL_typ : tPZL_max)
		gint1 = ~g1_;
	assign #(tPZH_min : tPZH_typ : tPZH_max,
		   tPZL_min : tPZL_typ : tPZL_max)
		gint2 = ~g2_;

	assign #(tPLH_min : tPLH_typ : tPLH_max,
  		     tPHL_min : tPHL_typ : tPHL_max)
		q_[3:0] = gint1 ? ~a[3:0] : 4'bzzzz;
	assign #(tPLH_min : tPLH_typ : tPLH_max,
  		     tPHL_min : tPHL_typ : tPHL_max)
		q_[7:4] = gint2 ? ~a[7:4] : 4'bzzzz;

endmodule
