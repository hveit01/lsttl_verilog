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
// BCD-DECIMAL decoder
module sn74ls145(y, a, b, c, d);
input a, b, c, d;
output [9:0] y;
wire a_, b_, c_, d_, aa, bb, cc, dd;
wire y0, y1, y2, y3, y4, y5, y6, y7, y8, y9;
parameter
	// TI TTL data book Vol 1, 1985
	tPLH=50,	// basic delay
	tPHL=50;

	not (a_,a);
	not (b_,b);
	not (c_,c);
	not (d_,d);
	not (aa,a_);
	not (bb,b_);
	not (cc,c_);
	not (dd,d_);
	nand (y0, a_, b_, c_, d_);
	nand (y1, aa, b_, c_, d_);
	nand (y2, a_, bb, c_, d_);
	nand (y3, aa, bb, c_, d_);
	nand (y4, a_, b_, cc, d_);
	nand (y5, aa, b_, cc, d_);
	nand (y6, a_, bb, cc, d_);
	nand (y7, aa, bb, cc, d_);
	nand (y8, a_, b_, c_, dd);
	nand (y9, aa, b_, c_, dd);
	assign #(tPLH, tPLH)
		y = { y9, y8, y7, y6, y5, y4, y3, y2, y1, y0 };
endmodule
