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
// Frequency dividers
module sn74ls57(qa, qb, qc, clka, clkb, clr);
input clka, clkb, clr;
output qa, qb, qc;
wire qbint;
reg [2:0] cnta;
reg [2:0] cntb;
reg cntc;

parameter 
	// TI TTL data book Vol 1, 1985
	tPLHA_min=0, tPLHA_typ=14, tPLHA_max=25,	//TPL CLKA -> QA
	tPHLA_min=0, tPHLA_typ=18, tPHLA_max=30,
	tPLHB_min=0, tPLHB_typ=8,  tPLHB_max=15,	//TPL CLKB -> QB
	tPHLB_min=0, tPHLB_typ=14, tPHLB_max=25,
	tPLHC_min=0, tPLHC_typ=18, tPLHC_max=30,	//TPL CLKB -> QC
	tPHLC_min=0, tPHLC_typ=24, tPHLC_max=35,
	tPHL0_min=0, tPHL0_typ=17, tPHL0_max=30;	//TPL CLR -> QA, QB, QC

/* async clear/enable */
always @(clr==0)
begin
  cnta <= 2'b00;
  cntb <= 3'b000;
  cntc <= 0;
end

/* counter A */
always @(negedge clka)
begin
	if (clr==1)
	begin
		cnta <= cnta == 3'b101 ? 2'b000 : (cnta + 1);
	end
end
assign #(tPLHA_min:tPLHA_typ:tPLHA_max,
		 tPHLA_min:tPHLA_typ:tPHLA_max)
	qa = cnta >= 3'b011 ? 'b1 : 'b0;

/* counter B,C */
always @(negedge clkb)
begin
	if (clr==1)
	begin
		cntb <= cntb == 3'b100 ? 3'b000 : (cntb + 1);
	end
end
assign #(tPLHB_min:tPLHB_typ:tPLHB_max,
		tPHLB_min:tPHLB_typ:tPHLB_max)
	qb = cntb >= 3'b100 ? 'b1 : 'b0;

/* counter C */
always @(negedge qb)
begin
	if (clr==1)
	begin
		cntc <= ~cntc;
	end
end
assign #(tPLHC_min:tPLHC_typ:tPLHC_max,
	  	 tPHLC_min:tPHLC_typ:tPHLC_max)
	qc = cntc=='b1 ? 'b1 : 'b0;

endmodule
