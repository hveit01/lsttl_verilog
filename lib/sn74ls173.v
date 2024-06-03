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
// 4bit register with enable and tristate
module sn74ls173(q, d, clk, clr, ie1, ie2, oe1, oe2);
input [3:0] d;
input clk, clr, ie1, ie2, oe1, oe2;
output [3:0] q;
reg [3:0] ff;
wire ie, oe;

parameter
	tPLH_min=0, tPLH_typ=17, tPLH_max=25,		// worst case
	tPHL_min=0, tPHL_typ=22, tPHL_max=30;

initial
begin
	ff = 4'bxxxx;
end

assign ie = ie1==0 && ie2==0;
assign oe = oe1==0 && oe2==0;

always @(clr==1)
begin
	ff <= 0;
end

always @(posedge clk)
begin
	if (clr==0 && ie==1)
		ff <= d;
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	q = oe==1 ? ff : 4'bzzzz;

endmodule
