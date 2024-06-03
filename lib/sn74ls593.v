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
// binary counter with input register
module sn74ls593(io, rco, cck, rck, ccken, cclr, cload, g, g_);
input cck, rck, ccken, cclr, cload, g, g_;
inout [7:0] io;
output rco;
reg [7:0] lreg, cnt;

parameter 
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=15, tPLH_max=23,	// cck -> rco
	tPHL_min=0, tPHL_typ=20, tPHL_max=30,
	tPZH_min=0, tPZH_typ=31, tPZH_max=47,	// g -> io, worst case
	tPZL_min=0, tPZL_typ=31, tPZL_max=47;

initial
begin
	cnt = 8'bxxxxxxxx;
	lreg = 8'bxxxxxxxx;
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
	lreg <= io;
end

always @(cload)
begin
	if (cload==0)
		cnt <= lreg;
end

assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
	rco = ~(cnt==8'b11111111);

assign #(tPZH_min:tPZH_typ:tPZH_max,
		 tPZL_min:tPZL_typ:tPZL_max)
	io = (g==1 && g_==0) ? cnt : 8'bzzzzzzzz;

endmodule
