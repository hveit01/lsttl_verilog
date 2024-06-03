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
module sn74ls165(qh, qh_, clk, en, load, ser, p);
input clk, en, load, ser;
input [7:0] p;
output qh, qh_;
reg [7:0] shifter;

parameter
	tPLH_min=0, tPLH_typ=16, tPLH_max=24, // worst case
	tPHL_min=0, tPHL_typ=21, tPHL_max=31;

//initial
//begin
//	shifter <= 8'bxxxxxxxx;
//end

always @(load)
begin
	if (load==0) begin
		shifter <= p;
	end
end

always @(posedge clk or posedge en)
begin
	if (load==1) begin
		if ((clk==1 && en==0) || (clk==0 && en==1)) begin
			shifter <= { shifter[6:0], ser };
		end
	end
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	qh = shifter[7];
assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	qh_ = ~shifter[7];

endmodule
