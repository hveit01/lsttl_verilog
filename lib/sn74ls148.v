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
// 8-line to 4 line priority encoder
module sn74ls148(ei, i, a2, a1, a0, gs, eo);
input ei;
input [7:0] i;
output a2, a1, a0, gs, eo;
wire [2:0] a;

parameter
	// TI TTL data book Vol 1, 1985
	tPLHA_min=0, tPLHA_typ=13, tPLHA_max=19, // worst case
	tPHLA_min=0, tPHLA_typ=12, tPHLA_max=19,
	tPLHG_min=0, tPLHG_typ=18, tPLHG_max=30, // worst case
	tPHLG_min=0, tPHLG_typ=14, tPHLG_max=25,
	tPLHE_min=0, tPLHE_typ=6,  tPLHE_max=10, // worst case
	tPHLE_min=0, tPHLE_typ=14, tPHLE_max=25;

	assign a = (i[7]==0 ? 3'b000 :
				(i[6]==0 ? 3'b001 :
				 (i[5]==0 ? 3'b010 :
				  (i[4]==0 ? 3'b011 :
				   (i[3]==0 ? 3'b100 :
					(i[2]==0 ? 3'b101 :
					 (i[1]==0 ? 3'b110 : 3'b111)))))));

	assign #(tPLHG_min:tPLHG_typ:tPLHG_max, tPHLG_min:tPHLG_typ:tPHLG_max) gs = ei==1 || i==8'b11111111;
	assign #(tPLHE_min:tPLHE_typ:tPLHE_max, tPHLE_min:tPHLE_typ:tPHLE_max) eo = ~(ei==0 && i==8'b11111111);
	
	assign #(tPLHA_min:tPLHA_typ:tPLHA_max, tPHLA_min:tPHLA_typ:tPHLA_max) a0 = a[0];
	assign #(tPLHA_min:tPLHA_typ:tPLHA_max, tPHLA_min:tPHLA_typ:tPHLA_max) a1 = a[1];
	assign #(tPLHA_min:tPLHA_typ:tPLHA_max, tPHLA_min:tPHLA_typ:tPHLA_max) a2 = a[2];
endmodule
