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
// 4bit shift register tristate
module sn74ls395(q, qd, clr, in, ldsh, ser, oe, clk);
output [3:0] q;
output qd;
input [3:0] in;
input clr, ldsh, ser, oe, clk;
reg [3:0] shift;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=15, tPLH_max=30,
	tPHL_min=0, tPHL_typ=20, tPHL_max=30,
	tPZH_min=0, tPZH_typ=15, tPZH_max=25,
	tPZL_min=0, tPZL_typ=17, tPZL_max=25;

always @(clr)
begin
	if (clr==0)
		shift <= 0;
end

always @(negedge clk)
begin
	if (clk==0 && clr==1) begin
		if (ldsh==1)
			shift <= in;
		else
			shift <= { shift[2:0], ser };
	end
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	qd = shift[3];
assign #(tPZH_min:tPZH_typ:tPZH_max, tPZL_min:tPZL_typ:tPZL_max)
	q = oe==1 ? 8'bzzzzzzzz : shift;


endmodule
