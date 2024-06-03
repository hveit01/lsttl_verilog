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
module sn74ls75(q, q_, d, g);
input [3:0] d;
input g;
output [3:0] q;
output [3:0] q_;
reg [3:0] ff;
wire [3:0] dint, dintbar;

parameter
	// note since iverilog is unreliable convecerning path delays, I had to emulate this
	// with fake additional delays

	// TI TTL data book Vol 1, 1985
	tPLHdq_min=0,  tPLHdq_typ=15,  tPLHdq_max=27,
	tPHLdq_min=0,  tPHLdq_typ=9,   tPHLdq_max=17,

	tPLHdqbar_min=0, tPLHdqbar_typ=12, tPLHdqbar_max=20,
	tPHLdqbar_min=0, tPHLdqbar_typ=7,  tPHLdqbar_max=15,

	tPLHgq_min=0,  tPLHgq_typ=0,  tPLHgq_max=0,			// delay + tPLHdq_*/tPLHdq_*
	tPHLgq_min=0,  tPHLgq_typ=6,  tPHLgq_max=10,		// delay + tPLHdq_*/tPLHdq_*

	tPLHgqbar_min=0, tPLHgqbar_typ=4, tPLHgqbar_max=10, // delay + tPLHdqbar_*/tPLHdqbar_*
	tPHLgqbar_min=0, tPHLgqbar_typ=0,  tPHLgqbar_max=0; // delay + tPHLdqbar_*/tPHLdqbar_*

assign #(tPLHdq_min:tPLHdq_typ:tPLHdq_max,
		 tPHLdq_min:tPHLdq_typ:tPHLdq_max)
	dint = d;
assign #(tPLHdqbar_min:tPLHdqbar_typ:tPLHdqbar_max,
		 tPHLdqbar_min:tPHLdqbar_typ:tPHLdqbar_max)
	dintbar = ~d;

always @(negedge g)
begin
	ff <= d;
end

assign #(tPLHgq_min:tPLHgq_typ:tPLHgq_max,
		 tPHLgq_min:tPHLgq_typ:tPHLgq_max)
	q  = g==1 ? dint : ff;
assign #(tPLHgqbar_min:tPLHgqbar_typ:tPLHgq_max,
		 tPHLgqbar_min:tPHLgqbar_typ:tPHLgq_max)
	q_ = g==1 ? dintbar: ~q;

endmodule
