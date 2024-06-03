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
// Binary counter
module sn74ls393(qa, qb, qc, qd, clk, clr);
input clk, clr;
output qa, qb, qc, qd;
reg [3:0] cnt;

parameter 
	// TI TTL data book Vol 1, 1985
	tPLHA_min=0, tPLHA_typ=12, tPLHA_max=20,	//TPL CLK -> QA
	tPHLA_min=0, tPHLA_typ=13, tPHLA_max=20,
	tPLHB_min=0, tPLHB_typ=40, tPLHB_max=60,	//TPL CLK -> Q*
	tPHLB_min=0, tPHLB_typ=40, tPHLB_max=60;

always @(clr)
begin
  if (clr==1) begin
	cnt <= 4'b0000;
  end
end

always @(posedge clk)
begin
	if (clr==0)
	begin
		cnt <= cnt+1;
	end
end
assign #(tPLHA_min:tPLHA_typ:tPLHA_max,
		 tPHLA_min:tPHLA_typ:tPHLA_max)
	qa = cnt[0];
assign #(tPLHB_min:tPLHB_typ:tPLHB_max,
		 tPHLB_min:tPHLB_typ:tPHLB_max)
	qb = cnt[1];
assign #(tPLHB_min:tPLHB_typ:tPLHB_max,
		 tPHLB_min:tPHLB_typ:tPHLB_max)
	qc = cnt[2];
assign #(tPLHB_min:tPLHB_typ:tPLHB_max,
		 tPHLB_min:tPHLB_typ:tPHLB_max)
	qd = cnt[3];

endmodule
