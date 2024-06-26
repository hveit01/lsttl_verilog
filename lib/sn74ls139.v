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
// 2-to-4 decoder
module sn74ls139(y, a, b, g);
input a, b, g;
output [3:0] y;
wire [2:0] ba;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=18, tPLH_max=29,	// worst case
	tPHL_min=0, tPHL_typ=25, tPHL_max=38;

assign ba = (g==1) ? 3'b100 : { 1'b0, b, a};

assign #(tPLH_min:tPLH_typ:tPLH_max,
         tPHL_min:tPHL_typ:tPLH_max)
	y = (ba==3'b100 ? 4'b1111 :
	     (ba==3'b000 ? 4'b1110 :
		  (ba==3'b001 ? 4'b1101 :
           (ba==3'b010 ? 4'b1011 : 4'b0111 ))));

endmodule
