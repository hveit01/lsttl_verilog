// This code is part of the model collection of simulatable TTL devices.
// Note this does not necessarily mean they are synthesizable!!!
//
// Copyright (C) 2022  Holger Veit (hveit01@web.de)
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
// BCD-7segment decoder
module sn74ls49(y, a, b, c, d, bi);
input a, b, c, d, bi;
output [6:0] y;
wire [3:0] dcba;
wire  [6:0] q;
parameter
	// TI TTL data book Vol 1, 1985
	toff_min=0, toff_typ=50, toff_max=100,		// typ not specified in data sheet
	ton_min=0,  ton_typ=50,  ton_max=100;

	assign dcba = {d, c, b, a};
	assign 
		q = bi==0         ? 7'b0000000 :
			dcba==4'b0000 ? 7'b1111110 :
			dcba==4'b0001 ? 7'b0110000 :
			dcba==4'b0010 ? 7'b1101101 :
			dcba==4'b0011 ? 7'b1111001 :
			dcba==4'b0100 ? 7'b0110011 :
			dcba==4'b0101 ? 7'b1011011 :
			dcba==4'b0110 ? 7'b0011111 :
			dcba==4'b0111 ? 7'b1110000 :
			dcba==4'b1000 ? 7'b1111111 :
			dcba==4'b1001 ? 7'b1110011 :
			dcba==4'b1010 ? 7'b0001101 :
			dcba==4'b1011 ? 7'b0011001 :
			dcba==4'b1100 ? 7'b0100011 :
			dcba==4'b1101 ? 7'b1001011 :
			dcba==4'b1110 ? 7'b0001111 : 7'b0000000;

	assign #(ton_min:ton_typ:ton_max,
			 toff_min:toff_typ:toff_max) 
		y = q;

endmodule
