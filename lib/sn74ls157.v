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
// quad 2 line to 1 multiplexer
module sn74ls157(y, a, b, s, g);
input [3:0] a, b;
input s, g;
output [3:0] y;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=13, tPLH_max=20, // worst case
	tPHL_min=0, tPHL_typ=18, tPHL_max=27;

	assign sg = {s, g};

	assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
		y = (g==1'b1 ? 4'b0000 : 
		     (s=='b0 ? a : b));

endmodule
