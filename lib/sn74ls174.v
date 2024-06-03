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
// 6 D-flipflops with clear
module sn74ls174(q, d, clk, clr);
input [5:0] d;
input clk, clr;
output [5:0] q;
reg [5:0] ff;

parameter
	tPLH_min=0, tPLH_typ=20, tPLH_max=30,		// worst case (CLR time)
	tPHL_min=0, tPHL_typ=23, tPHL_max=35;

initial
begin
	ff = 6'bxxxxxx;
end

always @(clr==0)
begin
	ff <= 0;
end

always @(posedge clk)
begin
	if (clr==1)
		ff <= d;
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	q = ff;

endmodule
