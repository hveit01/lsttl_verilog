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
// tridirectional bus transceiver, tristate
module sn74ls442(a, b, c, cs, s1, s0, ga, gb, gc);
inout [3:0] a, b, c;
input cs, s1, s0, ga, gb, gc;
wire [1:0] s;
wire [2:0] g;
wire [3:0] src;
wire toa, tob, toc, off;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=10, tPLH_max=14,
	tPHL_min=0, tPHL_typ=13, tPHL_max=20;

assign s = { s1, s0 };
assign g = { ga, gb, gc };

assign off = cs==1 || s==2'b11 || g==3'b111 ||
			 (s==2'b00 && gb==1'b1 && gc==1'b1) ||
			 (s==2'b01 && ga==1'b1 && gc==1'b1) ||
			 (s==2'b10 && ga==1'b1 && gb==1'b1);

assign src = (s==2'b00 ? a :
			  (s==2'b01 ? b :
			   (s==2'b10 ? c : 4'b1111)));

assign #(tPLH_min:tPLH_typ:tPLH_max, tPLH_min:tPLH_typ:tPLH_max)
	a = off || ga != 1'b0 ? 4'bzzzz : src; 
assign #(tPLH_min:tPLH_typ:tPLH_max, tPLH_min:tPLH_typ:tPLH_max)
	b = off || gb != 1'b0 ? 4'bzzzz : src;
assign #(tPLH_min:tPLH_typ:tPLH_max, tPLH_min:tPLH_typ:tPLH_max)
	c = off || gc != 1'b0 ? 4'bzzzz : src;

endmodule
