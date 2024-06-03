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
// 8-to-1 multiplexer
module sn74ls151(s, i, a, b, c, y, w);
input s, a, b, c;
input [7:0] i;
output y, w;
wire [2:0] cba;
wire yi;

parameter
	// TI TTL data book Vol 1, 1985
	tPLHY_min=0, tPLHY_typ=25, tPLHY_max=38, // worst case
	tPHLY_min=0, tPHLY_typ=25, tPHLY_max=38,
	tPLHW_min=0, tPLHW_typ=17, tPLHW_max=26, // worst case
	tPHLW_min=0, tPHLW_typ=19, tPHLW_max=30;

	assign cba = { c, b, a };

	assign 
		yi = (cba==3'b000 ? i[0] :
	          (cba==3'b001 ? i[1] :
               (cba==3'b010 ? i[2] :
                (cba==3'b011 ? i[3] :
                 (cba==3'b100 ? i[4] :
                  (cba==3'b101 ? i[5] :
                   (cba==3'b110 ? i[6] :
                    (cba==3'b111 ? i[7] : 1'b0))))))));

	assign #(tPLHY_min:tPLHY_typ:tPLHY_max, tPHLY_min:tPHLY_typ:tPHLY_max) y = s==0 && yi;
	assign #(tPLHW_min:tPLHW_typ:tPLHW_max, tPHLW_min:tPHLW_typ:tPHLW_max) w = ~(s==0 && yi);

endmodule
