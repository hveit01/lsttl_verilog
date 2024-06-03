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
// 8bit serialin shift register with output register, open collector
module sn74ls599(q, qh, rclr, rck, sclr, sck, ser);
input rclr, rck, sclr, sck, ser;
output [7:0] q;
output qh;
reg [7:0] shifter, preg;

parameter
	tPLH_min=0,  tPLH_typ=28,  tPLH_max=42, // rck -> q
	tPHL_min=0,  tPHL_typ=24,  tPHL_max=35,
	tPLHH_min=0, tPLHH_typ=12, tPLHH_max=18, // sck -> qh
	tPHLH_min=0, tPHLH_typ=17, tPHLH_max=25;

initial
begin
	shifter <= 8'bxxxxxxxx;
	preg <= 8'bxxxxxxxx;
end

always @(sclr==0)
begin
	shifter <= 8'b0000000;
end

always @(rclr==0)
begin
	preg <= 8'b0000000;
end

always @(posedge sck)
begin
	if (sclr==1 && sck==1)
		shifter <= { shifter[6:0], ser };
end

always @(posedge rck)
begin
	if (rclr==1 && rck==1)
		preg <= shifter;
end

assign (strong0, highz1) #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	q = preg;
assign #(tPLHH_min:tPLHH_typ:tPLHH_max, tPHLH_min:tPHLH_typ:tPHLH_max)
	qh = shifter[7];

endmodule
