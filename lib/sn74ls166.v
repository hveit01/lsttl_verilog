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
// 8bit shift register
module sn74ls166(qh, clr, clk, en, load, ser, p);
input clr, clk, en, load, ser;
input [7:0] p;
output qh;
reg [7:0] shifter;

parameter
	tPLH_min=5, tPLH_typ=11, tPLH_max=20, // worst case
	tPHL_min=7, tPHL_typ=14, tPHL_max=25;

always @(clr)
begin
	if (clr==0) begin
		shifter <= 0;
	end
end

always @(posedge clk)
begin
	if (en==0) begin
		if (load==1) begin
			if ((clk==1 && en==0) || (clk==0 && en==1)) begin
				shifter <= { shifter[6:0], ser };
			end
		end else begin
			shifter <= p;
		end
	end
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	qh = shifter[7];

endmodule
