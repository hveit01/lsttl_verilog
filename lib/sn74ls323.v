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
// 8bit l/r shiftregister tristate
module sn74ls323(qa, qh, qio, clr, s1, s0, g1, g2, clk, sl, sr);
inout [7:0] qio;
output qa, qh;
input clr, s1, s0, g1, g2, clk, sl, sr;
reg [7:0] shift;
wire g;
wire [1:0] s;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=17, tPLH_max=25,
	tPHL_min=0, tPHL_typ=25, tPHL_max=39,
	tPZH_min=0, tPZH_typ=14, tPZH_max=21,
	tPZL_min=0, tPZL_typ=20, tPZL_max=30;

assign g = g1==1 || g2==1;
assign s = { s1, s0 };

always @(posedge clk)
begin
	if (clk==1) begin
		if (clr==0)
			shift <= 0;
		else begin
			case (s)
			2'b01: // right shift
			shift <= { shift[6:0], sr };
			2'b10: // left shift
			shift <= { sl, shift[7:1] };
			2'b11: // load
			shift <= qio;
			default: // hold
				;
			endcase
		end
	end
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	qa = shift[0];
assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	qh = shift[7];
assign #(tPZH_min:tPZH_typ:tPZH_max, tPZL_min:tPZL_typ:tPZL_max)
	qio = g==1 || s==2'b11 ? 8'bzzzzzzzz : shift;


endmodule
