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
// 2x4bit bit register
module sn74ls396(q1, q2, d, clk, g);
input [3:0] d;
input clk, g;
reg [3:0] byte1, byte2;
output [3:0] q1, q2;
wire oeint;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=20, tPLH_max=30,
	tPHL_min=0, tPHL_typ=20, tPHL_max=30;

initial
begin
	byte1 <= 4'bxxx;
	byte2 <= 4'bxxx;
end

always @(posedge clk)
begin
	if (clk==1) begin
		byte2 <= byte1;
		byte1 <= d;
	end
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	q1 = g==0 ? byte1 : 4'b0000;
assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	q2 = g==0 ? byte2 : 4'b0000;

endmodule
