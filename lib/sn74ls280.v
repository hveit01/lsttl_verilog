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
// 9 bit parity generator/checker
module sn74ls280(even, odd, d);
input [8:0] d;
output even, odd;
wire od;

parameter
	// TI TTL data book Vol 1, 1985
	tPLHe_min=0, tPLHe_typ=33, tPLHe_max=50,
	tPHLe_min=0, tPHLe_typ=29, tPHLe_max=45,
	tPLHo_min=0, tPLHo_typ=23, tPLHo_max=35,
	tPHLo_min=0, tPHLo_typ=31, tPHLo_max=50;

xor(od, d[0], d[1], d[2], d[3], d[4], d[5], d[6], d[7], d[8]);

assign #(tPLHe_min:tPLHe_typ:tPLHe_max,
		 tPHLe_min:tPHLe_typ:tPHLe_max)
	even = ~od;

assign #(tPLHo_min:tPLHo_typ:tPLHo_max,
		 tPHLo_min:tPHLo_typ:tPHLo_max)
	odd = od;

endmodule
