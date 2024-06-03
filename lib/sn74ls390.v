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
// Decade counter (two parts in case)
module sn74ls390(qa, qb, qc, qd, clka, clkb, clr);
input clka, clkb, clr;
output qa, qb, qc, qd;
reg cnta;
reg [2:0] cntbcd;


parameter 
	// TI TTL data book Vol 1, 1985
	tPLHA_min=0, tPLHA_typ=12, tPLHA_max=20,	//TPL CLK1 -> QA
	tPHLA_min=0, tPHLA_typ=13, tPHLA_max=20,
	tPLHB_min=0, tPLHB_typ=13, tPLHB_max=21,	//TPL CLK2 -> QB
	tPHLB_min=0, tPHLB_typ=14, tPHLB_max=21,
	tPLHC_min=0, tPLHC_typ=24, tPLHC_max=39,	//TPL CLK2 -> QC
	tPHLC_min=0, tPHLC_typ=26, tPHLC_max=39,
	tPLHD_min=0, tPLHD_typ=13, tPLHD_max=21,	//TPL CLK2 -> QD
	tPHLD_min=0, tPHLD_typ=14, tPHLD_max=21;

always @(clr)
begin
  if (clr==1) begin
	cnta <= 'b0;
	cntbcd <= 3'b000;
  end
end

/* counter A */
always @(negedge clka)
begin
	if (clr==0)
	begin
		cnta <= ~cnta;
	end
end

assign #(tPLHA_min:tPLHA_typ:tPLHA_max,
		 tPHLA_min:tPHLA_typ:tPHLA_max)
	qa = cnta;

/* counter BCD */
always @(negedge clkb)
begin
	if (clr==0)
	begin
		cntbcd <= cntbcd==3'b100 ? 3'b000 : (cntbcd+1);
	end
end
assign #(tPLHB_min:tPLHB_typ:tPLHB_max,
		 tPHLB_min:tPHLB_typ:tPHLB_max)
	qb = cntbcd[0];
assign #(tPLHC_min:tPLHC_typ:tPLHC_max,
		 tPHLC_min:tPHLC_typ:tPHLC_max)
	qc = cntbcd[1];
assign #(tPLHD_min:tPLHD_typ:tPLHD_max,
		 tPHLD_min:tPHLD_typ:tPHLD_max)
	qd = cntbcd[2];

endmodule
