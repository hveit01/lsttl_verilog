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
// 3-of-8 decoder with address latches

module sn74ls137(y, a, b, c, gl, g1, g2);
input a, b, c, gl, g1, g2;
output [7:0] y;
reg [2:0] latch;
wire [7:0] yint;
wire [2:0] cba;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=16, tPLH_max=24,	// worst case
	tPHL_min=0, tPHL_typ=25, tPHL_max=38;

always @(gl, a, b, c)
begin
	if (gl==0)
		latch <= { c, b, a };
end

assign cba = gl==1 ? latch : {c, b, a};

assign yint = (cba==3'b000 ? 8'b11111110 :
			   (cba==3'b001 ? 8'b11111101 :
                (cba==3'b010 ? 8'b11111011 :
                 (cba==3'b011 ? 8'b11110111 :
                  (cba==3'b100 ? 8'b11101111 :
                   (cba==3'b101 ? 8'b11011111 :
                    (cba==3'b110 ? 8'b10111111 :
                     (cba==3'b111 ? 8'b01111111 : 8'b11111111 ))))))));

assign #(tPLH_min:tPLH_typ:tPLH_max,
         tPHL_min:tPHL_typ:tPLH_max)
		y = (g1==1 && g2==0) ? yint : 8'b11111111;

endmodule
