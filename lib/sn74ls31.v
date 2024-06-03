// This code is part of the model collection of simulatable TTL devices.
// Note this does not necessarily mean they are synthesizable!!!
//
// Copyright (C) 2022  Holger Veit (hveit01@web.de)
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
// 2 input NAND delay elementmodule sn74ls31nand(y, a, b);
input a, b;
output y;
parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=6, tPLH_max=10,
	tPHL_min=0, tPHL_typ=6, tPHL_max=10;

	nand #(tPLH_min : tPLH_typ : tPLH_max,
	  tPHL_min : tPHL_typ : tPHL_max)
	(y, a, b);

endmodule

module sn74ls31buf(y, a);
input a;
output y;
parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=45, tPLH_max=70,
	tPHL_min=0, tPHL_typ=48, tPHL_max=75;

	buf #(tPLH_min : tPLH_typ : tPLH_max,
	  tPHL_min : tPHL_typ : tPHL_max)
	(y, a);

endmodule

module sn74ls31inv(y, a);
input a;
output y;
parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=32, tPLH_max=50,
	tPHL_min=0, tPHL_typ=23, tPHL_max=35;

	not #(tPLH_min : tPLH_typ : tPLH_max,
	  tPHL_min : tPHL_typ : tPHL_max)
	(y, a);

endmodule
