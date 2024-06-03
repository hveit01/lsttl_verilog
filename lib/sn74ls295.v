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
// 4-bit parallel access shift registers
module sn74ls295(q, in, ser, mode, clk, oe);
input [3:0] in;
input ser, mode, clk, oe;
output [3:0] q;
reg [3:0] shift;
wire [3:0] qin;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=14, tPLH_max=20,	//TPL CLK* -> Q*
	tPHL_min=0, tPHL_typ=19, tPHL_max=30,
	tPZH_min=0, tPZH_typ=18-tPLH_typ, tPZH_max=26-tPLH_max,
	tPZL_min=0, tPZL_typ=20-tPHL_typ, tPZL_max=30-tPHL_max;

always @(negedge clk)
begin
	if (mode==1 && clk==0)
		shift <= in;
	else
		shift <= { shift[2:0], ser };
end

assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
		qin = shift;
assign #(tPZH_min:tPZH_typ:tPZH_max,
		 tPZL_min:tPZL_typ:tPZL_max)
		q = oe==0 ? 4'bzzzz : qin;

endmodule
