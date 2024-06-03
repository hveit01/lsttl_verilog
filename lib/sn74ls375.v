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
// 4 bit latches
module sn74ls375(q, q_, d, g);
input [3:0] d;
input g;
reg [3:0] ff;
output [3:0] q, q_;

parameter
	// TI TTL data book Vol 1, 1985
	tPLHq_min=0,  tPLHq_typ=15,  tPLHq_max=27,
	tPHLq_min=0,  tPHLq_typ=9,   tPHLq_max=17,
	tPLHq__min=0, tPLHq__typ=12, tPLHq__max=20,
	tPHLq__min=0, tPHLq__typ=7,  tPHLq__max=15;

initial
begin
	ff <= 4'bxxxx;
end

always @(g, d)
begin
	if (g==0)
		ff <= d;
end

assign #(tPLHq_min:tPLHq_typ:tPLHq_max, tPHLq_min:tPHLq_typ:tPHLq_max)
	q = g==1 ? ff : d;
assign #(tPLHq__min:tPLHq__typ:tPLHq__max, tPHLq__min:tPHLq__typ:tPHLq__max)
	q_ = ~(g==1 ? ff : d);

endmodule
