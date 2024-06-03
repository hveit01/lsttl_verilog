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
// quad 2 line to 1 multiplexer with storage
module sn74ls298(q, in1, in2, s, clk);
input [3:0] in1, in2;
input s, clk;
output [3:0] q;
wire [3:0] in;
reg [3:0] ff;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=18, tPLH_max=27,
	tPHL_min=0, tPHL_typ=21, tPHL_max=32;

assign in = s==0 ? in1 : in2;

always @(negedge clk)
begin
	if (clk==0)
		ff <= in;
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	q = ff;

endmodule
