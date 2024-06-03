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
// 8 bit comparator, open collector
module sn74ls685(p_eq_q, p_gt_q, p, q);
input [7:0] p, q;
output p_eq_q, p_gt_q;
parameter
	// TI TTL data book Vol 1, 1985
	tPLHE_min=0, tPLHE_typ=30, tPLHE_max=45, // worst case
	tPHLE_min=0, tPHLE_typ=23, tPHLE_max=35,
	tPLHG_min=0, tPLHG_typ=31, tPLHG_max=45, // worst case
	tPHLG_min=0, tPHLG_typ=21, tPHLG_max=30;

	assign (strong0, highz1) #(tPLHE_min : tPLHE_typ : tPLH_max,
			 tPHLE_min : tPHLE_typ : tPHL_max)
		p_eq_q = ~(p==q);
		
	assign (strong0, highz1) #(tPLHG_min : tPLHG_typ : tPLHG_max,
			 tPHLG_min : tPHLG_typ : tPHLG_max)
		p_gt_q = ~(p>q);

endmodule
