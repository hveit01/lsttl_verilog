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
// Dual JK MS FF with Preset and common Clock/Clear
module sn74ls78(q, q_, j, k, clk, clr, pre);
input [1:0] j, k, pre;
input clk, clr;
output [1:0] q, q_;
reg [1:0] m, s;
parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=15, tPLH_max=20,
	tPHL_min=0, tPHL_typ=15, tPHL_max=20;
	

always @(clr==0)
begin
	m <= 2'b00;
	s <= 2'b00;
end
always @(pre[1]==0)
begin
	m[1] <= 1;
	s[1] <= 1;
end
always @(pre[0]==0)
begin
	m[0] <= 1;
	s[0] <= 1;
end

always @(posedge clk)
begin
	if (clr==1) begin
		m[1] <= (j[1]==0 && k[1]==0) ? s[1] :
			    (j[1]==1 && k[1]==0) ? 'b1 :
			    (j[1]==0 && k[1]==1) ? 'b0 : ~s[1];
		m[0] <= (j[0]==0 && k[0]==0) ? s[0] :
			    (j[0]==1 && k[0]==0) ? 'b1 :
			    (j[0]==0 && k[0]==1) ? 'b0 : ~s[0];
	end
end

always @(negedge clk)
begin
	s <= m;
end

assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
	q[1]  = pre[1]==0 ? 1 : 
		    clr==0 ? 0 : s[1];
assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
	q_[1] = clr==0 ? 1 : 
		    pre[1]==0 ? 0 : ~s[1];
assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
	q[0]  = pre[0]==0 ? 1 : 
		    clr==0 ? 0 : s[0];
assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
	q_[0] = clr==0 ? 1 : 
		    pre[0]==0 ? 0 : ~s[0];

endmodule
