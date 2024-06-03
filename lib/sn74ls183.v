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
// full adder (2 in a single case)
module sn74ls183(cn1, sum, a, b, cn);
input a, b, cn;
output sum, cn1;
wire a_, b_, cn_;
wire cn11, cn12, cn13;
wire sum1, sum2, sum3, sum4;

parameter
	tPLH_min=0, tPLH_typ=10, tPLH_max=15,
	tPHL_min=0, tPHL_typ=12, tPHL_max=18;

not n1(a_, a);
not n2(b_, b);
not n3(cn_, cn);
and a1(cn11, cn_, b_);
and a2(cn12, b_, a_);
and a3(cn13, cn_, a_);
and a4(sum1, cn, b_, a);
and a5(sum2, cn_, b, a);
and a6(sum3, cn_, b_, a_);
and a7(sum4, cn, b, a_);

nor #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	n4(cn1, cn11, cn12, cn13);
nor #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	n5(sum, sum1, sum2, sum3, sum4);

endmodule
