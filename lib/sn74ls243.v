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
module sn74ls243(a, b, ga_, gb);
inout [3:0] a, b;
input ga_, gb;
wire [1:0] gab;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=9,           tPLH_max=14,
	tPHL_min=0, tPHL_typ=12,           tPHL_max=18,
	tPZH_min=0, tPZH_typ=15-tPLH_typ, tPZH_max=23-tPLH_max,
	tPZL_min=0, tPZL_typ=20-tPHL_typ, tPZL_max=30-tPHL_max;
// does not respect tPHZ, tPLZ !

	assign #(tPZH_min:tPZH_typ:tPZH_max,
		     tPZL_min:tPZL_typ:tPZL_max)
		gab = { ga_, gb };

	assign #(tPLH_min:tPLH_typ:tPLH_max,
  		     tPHL_min:tPHL_typ:tPHL_max)
		a = gab==2'b11 ? b : 4'bzzzz;
	assign #(tPLH_min:tPLH_typ:tPLH_max,
  		     tPHL_min:tPHL_typ:tPHL_max)
		b = gab==2'b00 ? a : 4'bzzzz;

endmodule
