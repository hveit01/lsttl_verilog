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
// synchronous decade up/down counter
module sn74ls168(q, rco, d, updn, clk, ep, et, load);
input [3:0] d;
input updn, clk, ep, et, load;
output [3:0] q;
output rco;
reg [3:0] cnt;
reg rc;
wire [3:0] inc, dec;

parameter
	tPLH_min=0,  tPLH_typ=23, tPLH_max=35, // worst case
	tPHL_min=0,  tPHL_typ=17, tPHL_max=25,
	tPLHR_min=0, tPLHR_typ=26, tPLHR_max=40,
	tPHLR_min=0, tPHLR_typ=17, tPHLR_max=25;
	// clear delay ignored

initial
begin
	cnt <= 4'bxxxx;
	rc <= 0;
end

assign inc = (cnt+1) % 10;
assign dec = cnt==0 ? 9 : (cnt-1);

always @(posedge clk)
begin
	if (load==0)
		cnt <= d;
	else if (ep==0 && et==0) begin
		cnt <= updn ? inc : dec;
	end
end

	assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
		q = cnt;
	assign #(tPLHR_min:tPLHR_typ:tPLHR_max, tPHLR_min:tPHLR_typ:tPHLR_max)
		rco = cnt==9 ? 0 : 1;

endmodule
