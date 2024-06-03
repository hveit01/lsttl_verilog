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
// JK FF with Preset/Clear
// These are effectively sn74ls112 with common clock/clear in a single case
module sn74ls114(q, q_, j, k, clk, clr, pre);
input j, k, clk, clr, pre;
output q, q_;
reg ff;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=15, tPLH_max=20,
	tPHL_min=0, tPHL_typ=15, tPHL_max=20;
	

always @(clr, pre)
begin
	ff <= (clr==0 && pre==0) ? 'bx : // instable
		  (clr==0 && pre==1) ? 'b0 : // reset
		  (clr==1 && pre==0) ? 'b1 : // set
		  ff;                        // no change
end

always @(negedge clk)
begin
	if (clr==1 && pre==1) begin
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
