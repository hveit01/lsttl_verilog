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
// 5-bit parallel access shift registers
module sn74ls96(qa, qb, qc, qd, qe, a, b, c, d, e, ser, clk, preset, clear);
input a, b, c, d, e, ser, clk, preset, clear;
output qa, qb, qc, qd, qe;
reg [4:0] r;
wire [4:0] i;
wire pi, ci, clki;

parameter
	// TI TTL data book Vol 1, 1985
	tPLHq_min=0, tPLHq_typ=25, tPLHq_max=40,	//TPL CLK -> Q*
	tPHLq_min=0, tPHLq_typ=25, tPHLq_max=40,
	tPLHp_min=0, tPLHp_typ=28,  tPLHp_max=35,	//TPL PRESET -> Q*
	tPHLc=55;                                   //TPL CLEAR -> Q*
	
assign in = { e, d, c, b, a }; // join inputs
assign #(tPLHp_min:tPLHp_typ:tPLHp_max) pi = preset; // delay preset
assign #(0, tPHLc) ci = clear; // delay clear
assign #(tPLHq_min:tPLHq_typ:tPLHq_max, tPHLq_min:tPHLq_typ:tPHLq_max) clki = clk; // delay clock

always @(ci,pi) // handle preset and clear
begin
	if (ci==0)
		r <= 5'b00000;
	else if (pi==1)
		r <= r | in;
end

always @(negedge clki) // clock in case of no clear/preset
begin
	if (ci==1 && pi==0)
		r <= { r[3:0], ser };
end

assign qa = r[0]; // move reg to output
assign qb = r[1];
assign qc = r[2];
assign qd = r[3];
assign qe = r[4];

endmodule
