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
// 8 bit latch with 8-to-1 data selector
module sn74ls357(y, w, d, s2, s1, s0, g1_, g2_, g3, sc, clk);
input s2, s1, s0, g1_, g2_, g3, sc, clk;
input [7:0] d;
output y, w;
reg [2:0] sr;
reg [7:0] dr;
wire [2:0] s, si;
wire [7:0] di;
wire g;

parameter
	// TI TTL data book Vol 1, 1985
	tPLHY_min=0, tPLHY_typ=27, tPLHY_max=41, // worst case
	tPHLY_min=0, tPHLY_typ=34, tPHLY_max=51,
	tPLHW_min=0, tPLHW_typ=32, tPLHW_max=48, // worst case
	tPHLW_min=0, tPHLW_typ=23, tPHLW_max=35;

initial
begin
	dr = 8'bxxxxxxxx;
	sr = 3'bxxx;
end

assign s = { s2, s1, s0 };

always @(sc)
begin
	if (sc==1)
		sr <= s;
end

always @(posedge clk)
begin
	if (clk==1)
		dr <= d;
end

assign si = sc==0 ? s : sr;
assign di = dr;

assign qi = (si==3'b000 ? di[0] :
	         (si==3'b001 ? di[1] :
              (si==3'b010 ? di[2] :
               (si==3'b011 ? di[3] : 
                (si==3'b100 ? di[4] : 
                 (si==3'b101 ? di[5] : 
                  (si==3'b110 ? di[6] : 
                   (si==3'b111 ? di[7] : 1'b1))))))));
				   
assign g = g1_==0 && g2_==0 && g3==1;

assign (strong0, highz1) #(tPLHY_min:tPLHY_typ:tPLHY_max, tPHLY_min:tPHLY_typ:tPHLY_max)
	y = g==1 ? qi : 1'bz;
assign (strong0, highz1) #(tPLHW_min:tPLHW_typ:tPLHW_max, tPHLW_min:tPHLW_typ:tPHLW_max)
	w = g==1 ? ~qi : 1'bz;

endmodule
