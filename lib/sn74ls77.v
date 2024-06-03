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
// quad D latches
module sn74ls77(q, d, g);
input [3:0] d;
input g;
output [3:0] q;
reg [3:0] ff;
wire [3:0] dint;

parameter
	// TI TTL data book Vol 1, 1985
	tPHLdq_min=0,  tPHLdq_typ=11,  tPHLdq_max=19,
	tPLHdq_min=0,  tPLHdq_typ=9,   tPLHdq_max=17,

	tPLHgq_min=0,  tPLHgq_typ=0,  tPLHgq_max=0,			// unprecise delay + tPLHdq_*/tPLHdq_*
	tPHLgq_min=0,  tPHLgq_typ=1,  tPHLgq_max=1;			// delay + tPLHdq_*/tPLHdq_*

assign #(tPLHdq_min:tPLHdq_typ:tPLHdq_max,
		 tPHLdq_min:tPHLdq_typ:tPHLdq_max)
	dint = d;

always @(negedge g)
begin
	ff <= d;
end

assign #(tPLHgq_min:tPLHgq_typ:tPLHgq_max,
		 tPHLgq_min:tPHLgq_typ:tPHLgq_max)
	q  = g==1 ? dint : ff;

endmodule
