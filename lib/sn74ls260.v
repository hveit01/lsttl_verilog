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
// 5 input NOR
module sn74ls260(y, a, b, c, d, e);
input a, b, c, d, e;
output y;
parameter
	// Motorola databook
	tPLH_min=0, tPLH_typ=5, tPLH_max=15,
	tPHL_min=0, tPHL_typ=5, tPHL_max=15;

	nor #(tPLH_min : tPLH_typ : tPLH_max,
	  tPHL_min : tPHL_typ : tPHL_max)
	(y, a, b, c, d, e);

endmodule
