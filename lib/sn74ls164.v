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
// 8bit serialin shift register
module sn74ls164(q, s1, s2, clr, clk);
input s1, s2, clr, clk;
output [7:0] q;
reg [7:0] shifter;
wire s;

parameter
	tPLH_min=8,  tPLH_typ=17, tPLH_max=27, // worst case
	tPHL_min=10, tPHL_typ=21, tPHL_max=32;

initial
begin
	shifter <= 8'bxxxxxxxx;
end

assign s = s1==1 && s2==1 ? 1 : 0;

always @(clr==0)
begin
	shifter <= 8'b0000000;
end



always @(posedge clk)
begin
	if (clr==0)
		shifter <= 0;
	else 
		shifter <= { shifter[6:0], s };
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	q = shifter;

endmodule
