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
// 8 bit shift register
module sn74ls91(qh, qh_, clk, a, b);
input clk, a, b;
output qh, qh_;
reg [7:0] sr;
wire in;

parameter 
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=24, tPLH_max=40,
	tPHL_min=0, tPHL_typ=27, tPHL_max=40;

and(in, a, b);

always @(posedge clk)
begin
	sr <= { sr[6:0], in };
end

assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
	qh = sr[7];
assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
	qh_ = ~sr[7];

endmodule
