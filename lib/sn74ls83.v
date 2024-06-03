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
// 4 bit full adder
module sn74ls83(sum, c4, a, b, c0);
input [3:0] a, b;
input c0;
output [3:0] sum;
output c4;

wire [4:0] tmpsum;

parameter
	// TI TTL data book Vol 1, 1985
	tPLHsum_min=0, tPLHsum_typ=16, tPLHsum_max=24,
	tPHLsum_min=0, tPHLsum_typ=15, tPHLsum_max=24,
	tPLHc4_min=0,  tPLHc4_typ=11,  tPLHc4_max=17,
	tPHLc4_min=0,  tPHLc4_typ=15, tPHLc4_max=22;
	
	assign tmpsum = a + b + c0;
	assign #(tPLHsum_min:tPLHsum_typ:tPLHsum_max,
			 tPLHsum_min:tPLHsum_typ:tPLHsum_max)
		sum = tmpsum[3:0];
	assign #(tPLHc4_min:tPLHc4_typ:tPLHc4_max,
			 tPLHc4_min:tPLHc4_typ:tPLHc4_max)
		c4 = tmpsum[4];

endmodule
