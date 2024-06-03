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
// BCD-EXCESS3 decoder
module sn74ls43(y, a, b, c, d);
input a, b, c, d;
output [9:0] y;
wire a_, b_, c_, d_, aa, bb, cc, dd;
wire y0, y1, y2, y3, y4, y5, y6, y7, y8, y9;
parameter
	// TI TTL data book Vol 1, 1985
	tPLH2_min=0, tPLH2_typ=15, tPLH2_max=25,	// basic delay
	tPHL2_min=0, tPHL2_typ=15, tPHL2_max=25,
	tPLH3_min=0, tPLH3_typ=5,  tPLH3_max=5,		// add delay when 3 gates in path
	tPHL3_min=0, tPHL3_typ=5,  tPHL3_max=5;

	not (a_,a);
	not (b_,b);
	not (c_,c);
	not (d_,d);
	not #(tPLH3_min:tPLH3_typ:tPLH3_max,
		  tPHL3_min:tPHL3_typ:tPLH3_max) (aa,a_);
	not #(tPLH3_min:tPLH3_typ:tPLH3_max,
		  tPHL3_min:tPHL3_typ:tPLH3_max) (bb,b_);
	not #(tPLH3_min:tPLH3_typ:tPLH3_max,
		  tPHL3_min:tPHL3_typ:tPLH3_max) (cc,c_);
	not #(tPLH3_min:tPLH3_typ:tPLH3_max,
		  tPHL3_min:tPHL3_typ:tPLH3_max) (dd,d_);
	nand (y0, aa, bb, c_, d_);
	nand (y1, a_, b_, cc, d_);
	nand (y2, aa, b_, cc, d_);
	nand (y3, a_, bb, cc, d_);
	nand (y4, aa, bb, cc, d_);
	nand (y5, a_, b_, c_, dd);
	nand (y6, aa, bb, c_, dd);
	nand (y7, a_, bb, c_, dd);
	nand (y8, aa, b_, c_, dd);
	nand (y9, a_, b_, cc, dd);
	assign #(tPLH2_min:tPLH2_typ:tPLH2_max,
		  tPHL2_min:tPHL2_typ:tPLH2_max)
		y = { y9, y8, y7, y6, y5, y4, y3, y2, y1, y0 };
endmodule
