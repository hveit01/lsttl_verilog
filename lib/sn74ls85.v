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
// 4 bit comparator
module sn74ls85(ogt, oeq, olt, a, b, igt, ieq, ilt);
input [3:0] a, b;
input igt, ieq, ilt;
output ogt, oeq, olt;
wire gt3, gt2, gt1, gt0, eq3, eq2, eq1, eq0, eq, lt3, lt2, lt1, lt0;

parameter
	// simulation is inaccurate, and uses maximum delays for each output
	// thus there won't be glitches which might happen in real circuit 

	// TI TTL data book Vol 1, 1985
	tPLHne3_min=0, tPLHne3_typ=17, tPLHne3_max=26,
	tPHLne3_min=0, tPHLne3_typ=20, tPHLne3_max=30,
	tPLHeq4_min=0, tPLHeq4_typ=23, tPLHeq4_max=35,
	tPHLeq4_min=0, tPHLeq4_typ=20, tPHLeq4_max=30;
	
	assign gt3 = a[3]==1 && b[3]==0;
	assign gt2 = a[2]==1 && b[2]==0;
	assign gt1 = a[1]==1 && b[1]==0;
	assign gt0 = a[0]==1 && b[0]==0;
	
	assign eq3 = a[3]==b[3];
	assign eq2 = a[2]==b[2];
	assign eq1 = a[1]==b[1];
	assign eq0 = a[0]==b[0];
	assign eq  = eq3 & eq2 & eq1 & eq0;

	assign lt3 = a[3]==0 && b[3]==1;
	assign lt2 = a[2]==0 && b[2]==1;
	assign lt1 = a[1]==0 && b[1]==1;
	assign lt0 = a[0]==0 && b[0]==1;
	
	assign #(tPLHne3_min:tPLHne3_typ:tPLHne3_max,
			 tPHLne3_min:tPHLne3_typ:tPHLne3_max)
		ogt = gt3 | (eq3 & gt2) | (eq3 & eq2 & gt1) | (eq3 & eq2 & eq1 & gt0) | (eq & ~ilt & ~ieq);
	assign #(tPLHne3_min:tPLHne3_typ:tPLHne3_max,
             tPHLne3_min:tPHLne3_typ:tPHLne3_max)
		olt = lt3 | (eq3 & lt2) | (eq3 & eq2 & lt1) | (eq3 & eq2 & eq1 & lt0) | (eq & ~igt & ~ieq);
	assign #(tPLHeq4_min:tPLHeq4_typ:tPLHeq4_max,
		  	 tPHLeq4_min:tPHLeq4_typ:tPHLeq4_max) oeq = eq & ieq;

endmodule
