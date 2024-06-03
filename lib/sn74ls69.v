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
// Binary counters
module sn74ls69_I(qa, qb, qc, qd, clk1, clk2, clr);
input clk1, clk2, clr;
output qa, qb, qc, qd;
reg cnta;
reg [2:0] cntbcd;

parameter 
	// TI TTL data book Vol 1, 1985
	tPLHA_min=0, tPLHA_typ=7,  tPLHA_max=11,	//TPL CLK1 -> QA
	tPHLA_min=0, tPHLA_typ=14, tPHLA_max=21,
	tPLHB_min=0, tPLHB_typ=7,  tPLHB_max=11,	//TPL CLK2 -> QB
	tPHLB_min=0, tPHLB_typ=14, tPHLB_max=21,
	tPLHC_min=0, tPLHC_typ=16, tPLHC_max=24,	//TPL CLK2 -> QC
	tPHLC_min=0, tPHLC_typ=21, tPHLC_max=32,
	tPLHD_min=0, tPLHD_typ=25, tPLHD_max=38,	//TPL CLK2 -> QD
	tPHLD_min=0, tPHLD_typ=30, tPHLD_max=45;

/* async clear/enable */
always @(clr==0)
begin
  cnta <= 'b0;
  cntbcd <= 3'b000;
end

/* counter A */
always @(negedge clk1)
begin
	if (clr==1)
	begin
		cnta <= ~cnta;
	end
end
assign #(tPLHA_min:tPLHA_typ:tPLHA_max,
		 tPHLA_min:tPHLA_typ:tPHLA_max)
	qa = cnta;

/* counter BCD */
always @(negedge clk2)
begin
	if (clr==1)
	begin
		cntbcd <= cntbcd+1;
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

module sn74ls69_II(qa, qb, qc, qd, clk, clr);
input clk, clr;
output qa, qb, qc, qd;
reg [3:0] cntabcd;

parameter 
	// TI TTL data book Vol 1, 1985
	tPLHA_min=0, tPLHA_typ=7,  tPLHA_max=11,	//TP CLK1 -> QA
	tPHLA_min=0, tPHLA_typ=14, tPHLA_max=21,
	tPLHB_min=0, tPLHB_typ=14, tPLHB_max=21,	//TP CLK2 -> QB
	tPHLB_min=0, tPHLB_typ=19, tPHLB_max=29,
	tPLHC_min=0, tPLHC_typ=23, tPLHC_max=35,	//TP CLK2 -> QC
	tPHLC_min=0, tPHLC_typ=27, tPHLC_max=40,
	tPLHD_min=0, tPLHD_typ=32, tPLHD_max=48,	//TP CLK2 -> QD
	tPHLD_min=0, tPHLD_typ=36, tPHLD_max=54;
	// TPHL clr -> Q not supported

/* async clear/enable */
always @(clr==0)
begin
  cntabcd <= 4'b000;
end

/* counter BCD */
always @(negedge clk)
begin
	if (clr==1)
	begin
		cntabcd <= cntabcd+1;
	end
end
assign #(tPLHA_min:tPLHA_typ:tPLHA_max,
		 tPHLA_min:tPHLA_typ:tPHLA_max)
	qa = cntabcd[0];
assign #(tPLHB_min:tPLHB_typ:tPLHB_max,
		 tPHLB_min:tPHLB_typ:tPHLB_max)
	qb = cntabcd[1];
assign #(tPLHC_min:tPLHC_typ:tPLHC_max,
		 tPHLC_min:tPHLC_typ:tPHLC_max)
	qc = cntabcd[2];
assign #(tPLHD_min:tPLHD_typ:tPLHD_max,
		 tPHLD_min:tPHLD_typ:tPHLD_max)
	qd = cntabcd[3];

endmodule
