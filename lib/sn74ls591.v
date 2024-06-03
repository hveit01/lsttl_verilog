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
// binary counter with register, open collector
module sn74ls591(q, rco, cck, rck, ccken, cclr, g);
input cck, rck, ccken, cclr, g;
output [7:0] q;
output rco;
reg [7:0] cnt, preg;


parameter 
	// TI TTL data book Vol 1, 1985
	tPZH_min=0, tPZH_typ=25, tPZH_max=38,	// g -> q
	tPZL_min=0, tPZL_typ=30, tPZL_max=45,
	tPLH_min=0, tPLH_typ=14, tPLH_max=22,	// cck -> rco
	tPHL_min=0, tPHL_typ=0,  tPHL_max=30;

initial
begin
	cnt = 8'bxxxxxxxx;
end

always @(cclr)
begin
	if (cclr==0)
		cnt <= 8'b00000000;
end

always @(posedge cck)
begin
  if (cclr==1 && ccken==0)
	cnt <= cnt+1;
end

always @(posedge rck)
begin
	preg <= cnt;
end

assign (strong0, highz1) #(tPZH_min:tPZH_typ:tPZH_max,
		 tPZL_min:tPZL_typ:tPZL_max)
	q = g==0 ? preg : 8'bzzzzzzzz;

assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
	rco = ~(cnt==8'b11111111);

endmodule
