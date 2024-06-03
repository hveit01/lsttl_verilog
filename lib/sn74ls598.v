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
// 8bit serialin shift register with input register, tristate
module sn74ls598(qh, io, rck, sclr, sck, ser1, ser2, ds, cload, g);
input g, rck, sclr, sck, ser, cload, ser1, ser2, ds;
inout [7:0] io;
output qh;
reg [7:0] shifter, lreg;
wire ser, gi;

parameter
	tPLH_min=0,  tPLH_typ=11, tPLH_max=17, // sck -> q
	tPHL_min=0,  tPHL_typ=15, tPHL_max=23,
	tPZH_min=0,  tPZH_typ=26-tPLH_typ, tPZH_max=31-tPLH_max, // g -> q
	tPZL_min=0,  tPZL_typ=29-tPHL_typ, tPZL_max=43-tPHL_max,
	tPLHH_min=0, tPLHH_typ=15, tPLHH_max=23, // sck -> qh
	tPHLH_min=0, tPHLH_typ=20, tPHLH_max=30;

initial
begin
	shifter <= 8'bxxxxxxxx;
	lreg <= 8'bxxxxxxxx;
end

assign ser = ds==0 ? ser1 : ser2;

always @(sclr==0)
begin
	shifter <= 8'b0000000;
end

always @(posedge sck)
begin
	if (sclr==1 && sck==1)
		shifter <= { shifter[6:0], ser };
end

always @(posedge rck)
begin
	if (rck==1)
		lreg <= io;
end

always @(cload)
begin
	if (cload==0)
		shifter <= lreg;
end

assign #(tPLHH_min:tPLHH_typ:tPLHH_max, tPHLH_min:tPHLH_typ:tPHLH_max)
	qh = shifter[7];
	
assign #(tPZH_min:tPZH_typ:tPZH_max, tPZL_min:tPZL_typ:tPZL_max)
	gi = g;

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	io = gi==0 ? shifter : 8'bzzzzzzzz;

endmodule
