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
// 3-of-8 decoder
module sn74ls138(y, a, b, c, g1, g2a_, g2b_);
input a, b, c, g1, g2a_, g2b_;
output [7:0] y;
wire [3:0] cba;

parameter
	// TI TTL data book Vol 1, 1985
	tPLH_min=0, tPLH_typ=18, tPLH_max=27,	// worst case
	tPHL_min=0, tPHL_typ=27, tPHL_max=41;

assign cba = (g1==0 || g2a_==1 || g2b_==1) ? 4'b1000 : { 1'b0, c, b, a};

assign #(tPLH_min:tPLH_typ:tPLH_max,
         tPHL_min:tPHL_typ:tPLH_max)
	y = (cba==4'b1000 ? 8'b11111111 :
	     (cba==4'b0000 ? 8'b11111110 :
		  (cba==4'b0001 ? 8'b11111101 :
           (cba==4'b0010 ? 8'b11111011 :
            (cba==4'b0011 ? 8'b11110111 :
             (cba==4'b0100 ? 8'b11101111 :
              (cba==4'b0101 ? 8'b11011111 :
               (cba==4'b0110 ? 8'b10111111 : 8'b01111111 ))))))));

endmodule
