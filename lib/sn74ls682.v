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
// 8 bit comparator
module sn74ls682(p_eq_q, p_gt_q, p, q);
input [7:0] p, q;
output p_eq_q, p_gt_q;
parameter
	// TI TTL data book Vol 1, 1985
	tPLHE_min=0, tPLHE_typ=14, tPLHE_max=25, // worst case
	tPHLE_min=0, tPHLE_typ=15, tPHLE_max=25,
	tPLHG_min=0, tPLHG_typ=21, tPLHG_max=30, // worst case
	tPHLG_min=0, tPHLG_typ=19, tPHLG_max=30;

	assign #(tPLHE_min : tPLHE_typ : tPLH_max,
			 tPHLE_min : tPHLE_typ : tPHL_max)
		p_eq_q = ~(p==q);
	pullup(p_eq_q);

	assign #(tPLHG_min : tPLHG_typ : tPLHG_max,
			 tPHLG_min : tPHLG_typ : tPHLG_max)
		p_gt_q = ~(p>q);
	pullup(p_gt_q);

endmodule
