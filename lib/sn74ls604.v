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
// 2 octal regs an multiplexer
module sn74ls604(y, a, b, ab, clk);
input ab, clk;
input [7:0] a, b;
output [7:0] y;
reg [7:0] rega, regb;
wire clki;

parameter
	tPLH_min=0,  tPLH_typ=31, tPLH_max=45, // ab to y, worst case
	tPHL_min=0,  tPHL_typ=23, tPHL_max=35,
	tPZH_min=0,  tPZH_typ=tPLH_typ-19, tPZH_max=tPLH_max-30, // clk-> y
	tPZL_min=0,  tPZL_typ=28-tPHL_typ, tPZL_max=40-tPHL_max;

initial
begin
	rega <= 8'bxxxxxxxx;
	regb <= 8'bxxxxxxxx;
end

always @(posedge clk)
begin
	if (clk==1) begin
		if (ab==0)
			regb <= b;
		else
			rega <= a;
	end
end

assign #(tPZH_min:tPZH_typ:tPZH_max, tPZH_min:tPZL_typ:tPZL_max) 
	clki = clk;


assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	y = clki==0 ? 8'bzzzzzzzz : (ab==0 ? regb : rega);

endmodule
