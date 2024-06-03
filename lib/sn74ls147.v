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
// 10-line to 4 line priority encoder
module sn74ls147(i, a, b, c, d);
input [8:0] i;
output a, b, c, d;
wire [3:0] y;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=21, tPLH_max=33, // worst case
	tPHL_min=0, tPHL_typ=15, tPHL_max=23;

	assign y = (i[8]==0 ? 4'b0110 :
				(i[7]==0 ? 4'b0111 :
				 (i[6]==0 ? 4'b1000 :
				  (i[5]==0 ? 4'b1001 :
				   (i[4]==0 ? 4'b1010 :
					(i[3]==0 ? 4'b1011 :
					 (i[2]==0 ? 4'b1100 :
					  (i[1]==0 ? 4'b1101 :
					   (i[0]==0 ? 4'b1110 : 4'b1111)))))))));

	assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max) a = y[0];
	assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max) b = y[1];
	assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max) c = y[2];
	assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max) d = y[3];
endmodule
