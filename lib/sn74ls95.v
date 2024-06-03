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
// 4-bit parallel access shift registers
module sn74ls95(qa, qb, qc, qd, a, b, c, d, ser, mode, clk1, clk2);
input a, b, c, d, ser, mode, clk1, clk2;
output qa, qb, qc, qd;
reg ra, rb, rc, rd;
wire clki, mode_, c1, c2;
parameter
	// TI TTL data book Vol 1, 1985
	tENABLE=15,                             // TPL MODE -> CLK*
	tINHIBIT=5,                             // typ and max not given
	tPLH_min=0, tPLH_typ=18, tPLH_max=27,	//TPL CLK* -> Q*
	tPHL_min=0, tPHL_typ=21, tPHL_max=32;

always @(negedge clk1)
begin
	if (mode==1 && clk1==0)
	begin
		ra <= a;
		rb <= b;
		rc <= c;
		rd <= d;
	end
end

always @(negedge clk2)
begin
	if (mode==1 && clk2==0)
	begin
		rd <= rc;
		rc <= rb;
		rb <= ra;
		ra <= ser;
	end
end


assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
		qa = ra;
assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
		qb = rb;
assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
		qc = rc;
assign #(tPLH_min:tPLH_typ:tPLH_max,
		 tPHL_min:tPHL_typ:tPHL_max)
		qd = rd;

endmodule
