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
// RS flipflop (4 in a case)
module sn74ls279(q, s, r);
input s, r;
output q;
reg ff;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=12, tPLH_max=22, // worst case
	tPHL_min=0, tPHL_typ=15, tPHL_max=27;
	
initial
begin
	ff <= 1'bx;
end
	
always @(r, s)
begin
	case ({s,r})
	2'b00:
		ff <= 1'bx;	// instable
	2'b01:
		ff <= 1'b1;
	2'b10:
		ff <= 1'b0;
	default:
		;
	endcase
end

assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
	q  = s==0 && r==0 ? 1 : ff;

endmodule
