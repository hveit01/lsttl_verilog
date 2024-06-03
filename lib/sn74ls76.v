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
// JK MS FF with Preset/Clear
module sn74ls76(q, q_, j, k, clk, clr, pre);
input j, k, clk, clr, pre;
output q, q_;
reg m, s;
parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=15, tPLH_max=20,
	tPHL_min=0, tPHL_typ=15, tPHL_max=20;
	

always @(clr==0)
begin
	m <= 0;
	s <= 0;
end
always @(pre==0)
begin
	m <= 1;
	s <= 1;
end

always @(posedge clk)
begin
	if (clr==1) begin
		m <= (j==0 && k==0) ? s :
			 (j==1 && k==0) ? 'b1 :
			 (j==0 && k==1) ? 'b0 : ~s;
	end
end

always @(negedge clk)
begin
	s <= m;
end

assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
	q  = pre==0 ? 1 : 
		 clr==0 ? 0 : s;
assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
	q_ = clr==0 ? 1 : 
		 pre==0 ? 0 : ~s;

endmodule
