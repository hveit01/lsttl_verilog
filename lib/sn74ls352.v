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
// 4-to-1 multiplexer, inverting
module sn74ls352(c, a1, a0, g, q);
input a1, a0, g;
input [3:0] c;
output q;
wire [1:0] a;
wire qi;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=19, tPLH_max=29, // worst case
	tPHL_min=0, tPHL_typ=25, tPHL_max=38;

	assign a = { a1, a0 };
	assign qi = (a==2'b00 ? c[0] :
	             (a==2'b01 ? c[1] :
                  (a==2'b10 ? c[2] :
                   (a==2'b11 ? c[3] : 1'bx))));

	assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
		q = g==1 ? 1'b1 : ~qi;

endmodule
