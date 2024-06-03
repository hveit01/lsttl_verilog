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
// synchronous binary up/down counter
module sn74ls191(q, maxmin, rco, d, updn, clk, en, load);
input [3:0] d;
input updn, clk, en, load;
output [3:0] q;
output rco, maxmin;
reg [3:0] cnt;
wire [3:0] inc, dec;

parameter
	tPLH_min=0,  tPLH_typ=14, tPLH_max=22, // worst case
	tPHL_min=0,  tPHL_typ=35, tPHL_max=50,
	tPLHR_min=0, tPLHR_typ=13, tPLHR_max=20,
	tPHLR_min=0, tPHLR_typ=16, tPHLR_max=24,
	tPLHM_min=0, tPLHM_typ=28, tPLHM_max=42,
	tPHLM_min=0, tPHLM_typ=37, tPHLM_max=52;

initial
begin
	cnt <= 4'bxxxx;
end

assign inc = cnt+1;
assign dec = cnt-1;

always @(load==0)
begin
	cnt <= d;
end

always @(posedge clk)
begin
	if (load==1 && en==0) begin
		cnt <= updn ? dec : inc;
	end
end

	assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
		q = cnt;
	assign #(tPLHR_min:tPLHR_typ:tPLHR_max, tPHLR_min:tPHLR_typ:tPHLR_max)
		rco = cnt==15 ? 1 : 0;
	assign #(tPLHM_min:tPLHM_typ:tPLHM_max, tPHLM_min:tPHLM_typ:tPHLM_max)
		maxmin = ~(rco==1 && clk==0);

endmodule
