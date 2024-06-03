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
// 8bit l/r shift register signextend
module sn74ls322(qh, qio, clr, g, sp, se, ds, oe, clk, d1, d0);
inout [7:0] qio;
output qh;
input clr, g, sp, se, ds, oe, clk, d1, d0;
reg [7:0] shift;
wire ser;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=22, tPLH_max=33,
	tPHL_min=0, tPHL_typ=27, tPHL_max=35,
	tPZH_min=0, tPZH_typ=15, tPZH_max=35,
	tPZL_min=0, tPZL_typ=15, tPZL_max=35;

assign ser = se==1 ? (ds==1 ? d1 : d0) : shift[0];

always @(clr)
begin
	if (clr==0 && (g==1 || sp==1))
		shift <= 0;
end

always @(posedge clk)
begin
	if (clk==1 && clr==1) begin
		if (g==0) begin
			if (sp==1)
				shift <= { shift[6:0], ser };
			else
				shift <= qio;
		end
	end
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	qh = shift[7];
assign #(tPZH_min:tPZH_typ:tPZH_max, tPZL_min:tPZL_typ:tPZL_max)
	qio = oe==0 && sp==1 ? shift : 8'bzzzzzzzz;


endmodule
