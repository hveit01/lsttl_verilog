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
module sn74ls490(q, clk, clr, r9);
input clk, clr, r9;
output [3:0] q;
reg [3:0] cnt;

parameter 
	// TI TTL data book Vol 1, 1985
	tPLHA_min=0, tPLHA_typ=12, tPLHA_max=20,	//TPL CLK -> QA
	tPHLA_min=0, tPHLA_typ=13, tPHLA_max=20,
	tPLHB_min=0, tPLHB_typ=24, tPLHB_max=39,	//TPL CLK -> QB
	tPHLB_min=0, tPHLB_typ=26, tPHLB_max=39,
	tPLHC_min=0, tPLHC_typ=32, tPLHC_max=54,	//TPL CLK -> QC
	tPHLC_min=0, tPHLC_typ=36, tPHLC_max=54,
	tPLHD_min=0, tPLHD_typ=24, tPLHD_max=39,	//TPL CLK -> QD
	tPHLD_min=0, tPHLD_typ=26, tPHLD_max=39;

always @(clr, r9)
begin
  if (clr==1)
	cnt <= 4'b0000;
  else if (r9==1)
	cnt <= 4'b1001;
end

/* counter */
always @(negedge clk)
begin
	if (clr==0 && r9==0)
	begin
		cnt <= cnt==4'b1001 ? 4'b0000 : cnt+1;
	end
end

assign #(tPLHA_min:tPLHA_typ:tPLHA_max,
		 tPHLA_min:tPHLA_typ:tPHLA_max)
	q[0] = cnt[0];
assign #(tPLHB_min:tPLHB_typ:tPLHB_max,
		 tPHLB_min:tPHLB_typ:tPHLB_max)
	q[1] = cnt[1];
assign #(tPLHC_min:tPLHC_typ:tPLHC_max,
		 tPHLC_min:tPHLC_typ:tPHLC_max)
	q[2] = cnt[2];
assign #(tPLHD_min:tPLHD_typ:tPLHD_max,
		 tPHLD_min:tPHLD_typ:tPHLD_max)
	q[3] = cnt[3];

endmodule
