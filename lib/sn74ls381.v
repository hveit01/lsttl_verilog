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
// 4 bit ALU
module sn74ls381(f, p, g, a, b, cn, s);
input [3:0] a, b;
input cn;
input [2:0] s;
output [3:0] f;
output p, g;
wire [3:0] fi;
wire pi, gi;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=20, tPLH_max=27, // A,B to F
	tPHL_min=0, tPHL_typ=14, tPHL_max=21,
	tPLHG_min=0, tPLHG_typ=20, tPLHG_max=30, // A,B to G
	tPHLG_min=0, tPHLG_typ=21, tPHLG_max=33,
	tPLHP_min=0, tPLHP_typ=23, tPLHP_max=33, // A,B to P
	tPHLP_min=0, tPHLP_typ=15, tPHLP_max=23;

buf(s0, s[0]);
buf(s1, s[1]);
buf(s2, s[2]);
not(s0_, s[0]);
not(s1_, s[1]);
not(s2_, s[2]);

and(a11, s2_, s1_, s0); 	
and(a12, s2_, s1, s0_);		
and(a13, s2, s1, s0);		
nor(n1, a11, a12, a13);		

and(a21, s1_, s0);			
and(a22, s2, s0);			
and(a23, s1, s0_);			
nor(n2, a21, a22, a23);

and(a31, s1, s0);
and(a32, s2, s1_);
nor(n3, a31, a32);

nand(n4, s2_, s1_, s0); 
nand(n5, s2_, s1, s0);
nand(n6, s2_, s1, s0_); 

and(a71, s2_, s0);
and(a72, s2_, s1);
or(o7, a71, a72);

buf(a0, a[0]);
buf(a1, a[1]);
buf(a2, a[2]);
buf(a3, a[3]);
buf(b0, b[0]);
buf(b1, b[1]);
buf(b2, b[2]);
buf(b3, b[3]);
not(a0_, a[0]);
not(a1_, a[1]);
not(a2_, a[2]);
not(a3_, a[3]);
not(b0_, b[0]);
not(b1_, b[1]);
not(b2_, b[2]);
not(b3_, b[3]);

and(aabn0, a0, b0_, n3);
and(aab0, a0, b0, n2);
and(aanb0, a0_, b0, n3);
and(aanbn0, a0_, b0_, n1);
nor(na0, aabn0, aab0, aanb0, aanbn0);

and(babn0,  a0, b0_, n6);
and(bab0, a0, b0, n5);
and(banb0, a0_, b0, n4);
and(banbn0, a0_, b0_);
nor(nb0, babn0, bab0, banb0, banbn0);

and(aabn1, a1, b1_, n3);
and(aab1, a1, b1, n2);
and(aanb1, a1_, b1, n3);
and(aanbn1, a1_, b1_, n1);
nor(na1, aabn1, aab1, aanb1, aanbn1);

and(babn1, a1, b1_, n6);
and(bab1, a1, b1, n5);
and(banb1, a1_, b1, n4);
and(banbn1, a1_, b1_);
nor(nb1, babn1, bab1, banb1, banbn1);

and(aabn2, a2, b2_, n3);
and(aab2, a2, b2, n2);
and(aanb2, a2_, b2, n3);
and(aanbn2, a2_, b2_, n1);
nor(na2, aabn2, aab2, aanb2, aanbn2);

and(babn2, a2, b2_, n6);
and(bab2, a2, b2, n5);
and(banb2, a2_, b2, n4);
and(banbn2, a2_, b2_);
nor(nb2, babn2, bab2, banb2, banbn2);

and(aabn3,  a3, b3_, n3);
and(aab3, a3, b3, n2);
and(aanb3, a3_, b3, n3);
and(aanbn3, a3_, b3_, n1);
nor(na3, aabn3, aab3, aanb3, aanbn3);

and(babn3,  a3, b3_, n6);
and(bab3, a3, b3, n5);
and(banb3, a3_, b3, n4);
and(banbn3, a3_, b3_);
nor(nb3, babn3, bab3, banb3, banbn3);

nand(nf0, o7, cn);
xnor(fi[0], nf0, na0);

and(af11, o7, cn, na0);
and(af12, o7, nb0);
nor(nf1, af11, af12);
xnor(fi[1], nf1, na1);

and(af21, o7, cn, na0, na1);
and(af22, o7, na1, nb0);
and(af23, o7, nb1);
nor(nf2, af21, af22, af23);
xnor(fi[2], nf2, na2);

and(af31, o7, cn, na0, na1, na2);
and(af32, o7, na2, na1, nb0);
and(af33, o7, na2, nb1);
and(af34, o7, nb2);
nor(nf3, af31, af32, af33, af34);
xnor(fi[3], nf3, na3);

and(acn41, cn, na0, na1, na2, na3);
and(acn42, na1, na2, na3, nb0);
and(acn43, na2, na3, nb1);
and(acn44, na3, nb2);
and(acn45, nb3);
nor(ncn4, acn41, acn42, acn43, acn44, acn45);
// xor(ovri, nf3, ncn4);
// not(cn4i, ncn4);

nand(pi, na0, na1, na2, na3);

and(ng1, na1, na2, na3, nb0);
and(ng2, na2, na3, nb1);
and(ng3, na3, nb2);
and(ng4, nb3);
nor(gi, ng1, ng2, ng3, ng4);

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	f = fi;
assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	g = gi;
assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	p = pi;
endmodule
