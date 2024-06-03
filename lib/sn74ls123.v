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
// Monoflop
module sn74ls123(a, b, clr, q, q_);
input a, b, clr;
output q, q_;
reg mono;

parameter
	rT = 10,    // in kOhm
	cT = 1000,  // in pFarad

	// TI TTL data book Vol 1, 1985
	tW = 0.32 * rT * cT * (1 + 0.7/rT), // tw is in nsec
	tPLHA_min=0, tPLHA_typ=23, tPLHA_max=33,
	tPHLA_min=0, tPHLA_typ=32, tPHLA_max=45;

always @(clr==0)
begin
	mono <= 0;
end

always @(negedge a)
begin
	if (a==0) begin
		mono <= 1;
	end	
end

always @(posedge b)
begin
	if (b==1) begin
		mono <= 1;
	end	
end

always @(posedge clr)
begin
	if (a==0 && b==1 && clr==1) begin
		mono <= 1;
	end	
end

always @(posedge mono)
begin
	if (mono==1) begin
		mono <= #(tW) 0;
	end
end

assign #(tPLHA_min:tPLHA_typ:tPLHA_max, tPHLA_min:tPHLA_typ:tPHLA_max) q = mono;
assign #(tPLHA_min:tPLHA_typ:tPLHA_max, tPHLA_min:tPHLA_typ:tPHLA_max) q_ = ~mono;

endmodule
