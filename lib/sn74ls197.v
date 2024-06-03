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
// binary counter
module sn74ls197(q, d, clr, clk1, clk2, load);
input [3:0] d;
input clr, clk1, clk2, load;
output [3:0] q;
reg [2:0] bcd;
reg a;
wire [3:0] inc;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH1_min=0,  tPLH1_typ=8,  tPLH1_max=15, // clk1 -> qa
	tPHL1_min=0,  tPHL1_typ=14, tPHL1_max=21,
	tPLH2_min=0,  tPLH2_typ=55, tPLH2_max=78, // clk2 -> qb,qc,qd
	tPHL2_min=0,  tPHL2_typ=63, tPHL2_max=95;
	// load, clear delay ignored

initial
begin
	a <= 1'bx;
	bcd <= 3'bxxx;
end

always @(load)
begin
	if (load==0) begin
		a <= d[0];
		bcd <= d[3:1];
	end
end

always @(clr)
begin
	if (clr==0) begin
		a <= 0;
		bcd <= 0;
	end
end

assign inc = bcd+1;

always @(negedge clk1)
begin
	if (load==1 && clr==1)
		a <= ~a;
end

always @(negedge clk2)
begin
	if (load==1 && clr==1)
		bcd <= inc;
end

assign #(tPLH1_min:tPLH1_typ:tPLH1_max, tPHL1_min:tPHL1_typ:tPHL1_max)
	q[0] = a;
assign #(tPLH2_min:tPLH2_typ:tPLH2_max, tPHL2_min:tPHL2_typ:tPHL2_max)
	q[3:1] = bcd;

endmodule
