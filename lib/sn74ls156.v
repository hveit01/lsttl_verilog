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
// 2 to 4 decoder open collector
module sn74ls155(a1, a0, g, d, q);
input a1, a0, g, d;
output [3:0] q;
wire [1:0] a;
wire [3:0] qi;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=21, tPLH_max=32, // worst case
	tPHL_min=0, tPHL_typ=21, tPHL_max=32;

	assign a = { a1, a0 };
	assign qi = (a==2'b00 ? 4'b0111 :
	             (a==2'b01 ? 4'b1011 :
                  (a==2'b10 ? 4'b1101 :
                   (a==2'b11 ? 4'b1110 : 4'bxxxx))));

	assign (strong0,highz1) #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
		q = g==1 || d==0 ? 4'b1111 : qi;

endmodule
