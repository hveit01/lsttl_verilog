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
// 4 bit bidirectional shift register
module sn74ls194(q, r, l, d, clr, s1, s0, clk);
input [3:0] d;
input r, l, clr, s1, s0, clk;
output [3:0] q;
reg [3:0] shift;
wire [1:0] s;

parameter
	tPLH_min=0,  tPLH_typ=14, tPLH_max=22,
	tPHL_min=0,  tPHL_typ=17, tPHL_max=26;

initial
begin
	shift <= 4'bxxxx;
end

assign s = {s1, s0};


always @(clr)
begin
	if (clr==0)
		shift <= 0;
end

always @(posedge clk)
begin
	if (clr==1) begin
		case (s)
		2'b01:
			shift <= { shift[2:0], r};
		2'b10:
			shift <= { l, shift[3:1]};
		2'b11:
			shift <= d;
		default:
			;
		endcase
	end
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	q = shift;

endmodule
