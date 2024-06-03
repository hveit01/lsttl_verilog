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
// Decade counter
module sn74ls90(qa, qb, qc, qd, clka, clkb, r0, r9);
input clka, clkb;
input [1:0] r0, r9;
output qa, qb, qc, qd;
reg cnta;
reg [2:0] cntbcd;
wire res0, res9;

parameter 
	// TI TTL data book Vol 1, 1985
	tPLHA_min=0, tPLHA_typ=10, tPLHA_max=16,	//TPL CLK1 -> QA
	tPHLA_min=0, tPHLA_typ=12, tPHLA_max=18,
	tPLHB_min=0, tPLHB_typ=10, tPLHB_max=16,	//TPL CLK2 -> QB
	tPHLB_min=0, tPHLB_typ=14, tPHLB_max=21,
	tPLHC_min=0, tPLHC_typ=21, tPLHC_max=32,	//TPL CLK2 -> QC
	tPHLC_min=0, tPHLC_typ=23, tPHLC_max=35,
	tPLHD_min=0, tPLHD_typ=21, tPLHD_max=32,	//TPL CLK2 -> QD
	tPHLD_min=0, tPHLD_typ=23, tPHLD_max=35;

nand(res0, r0[1], r0[0]);
nand(res9, r9[1], r9[0]);

always @(res0 or res9)
begin
  if (res9==0) begin
	cnta <= 'b1;
	cntbcd <= 3'b100;
  end else if (res0==0) begin
	cnta <= 'b0;
	cntbcd <= 3'b000;
  end
end

/* counter A */
always @(negedge clka)
begin
	if (res0==1 && res9==1)
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
	if (res0==1 && res9==1)
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
