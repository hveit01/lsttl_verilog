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
module sn74ls193(q, carry, borrow, d, clr, up, dn, load);
input [3:0] d;
input up, dn, clr, load;
output [3:0] q;
output carry, borrow;
reg [3:0] cnt;
wire [3:0] inc, dec;

parameter
	tPLH_min=0,  tPLH_typ=27, tPLH_max=38, // worst case
	tPHL_min=0,  tPHL_typ=30, tPHL_max=47,
	tPLHC_min=0, tPLHC_typ=17, tPLHC_max=26,
	tPHLC_min=0, tPHLC_typ=18, tPHLC_max=24,
	tPLHB_min=0, tPLHB_typ=16, tPLHB_max=24,
	tPHLB_min=0, tPHLB_typ=15, tPHLB_max=24;

initial
begin
	cnt <= 4'bxxxx;
end

assign inc = cnt+1;
assign dec = cnt-1;

always @(clr)
begin
	if (clr==1)
		cnt <= 0;
end

always @(load)
begin
	if (load==0)
		cnt <= d;
end

always @(negedge up)
begin
	if (load==1 && clr==0 && up==0) begin
		cnt <= inc;
	end
end

always @(negedge dn)
begin
	if (load==1 && clr==0 && dn==0) begin
		cnt <= dec;
	end
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	q = cnt;
assign #(tPLHC_min:tPLHC_typ:tPLHC_max, tPHLC_min:tPHLC_typ:tPHLC_max)
	carry = ~(cnt==15 && up==0);
assign #(tPLHB_min:tPLHB_typ:tPLHB_max, tPHLB_min:tPHLB_typ:tPHLB_max)
	borrow = ~(cnt==0 && dn==0);

endmodule
