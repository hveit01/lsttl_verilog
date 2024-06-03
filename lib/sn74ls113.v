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
// JK FF with Preset
module sn74ls113(q, q_, j, k, clk, pre);
input j, k, clk, pre;
output q, q_;
reg ff;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=15, tPLH_max=20,
	tPHL_min=0, tPHL_typ=15, tPHL_max=20;
	

always @(pre==0)
begin
	ff <= 1;
end

always @(negedge clk)
begin
	if (pre==1) begin
		ff <= (j==0 && k==0) ? ff :  // no change
			  (j==1 && k==0) ? 'b1 : // set
			  (j==0 && k==1) ? 'b0 : // reset
			  ~ff;                   // toggle
	end
end

assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
	q  = ff;
assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
	q_ = ~ff; 

endmodule
