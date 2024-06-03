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
// 4x4 bit register file with open collector
module sn74ls170(q, d, we_, wa, re_, ra);
input [3:0] d;
input we_, re_;
input [1:0] wa, ra;
output [3:0] q;
reg [3:0] ram [0:3];
wire [3:0] di;

parameter
	tPLHW_min=0, tPLHW_typ=25, tPLHW_max=40,	// write D->Reg
	tPHLW_min=0, tPHLW_typ=34, tPHLW_max=45,
	tPLHR_min=0, tPLHR_typ=23, tPLHR_max=35,	// read Reg->Q
	tPHLR_min=0, tPHLR_typ=30, tPHLR_max=40;

initial
begin
	ram[0] = 4'bxxxx;
	ram[1] = 4'bxxxx;
	ram[2] = 4'bxxxx;
	ram[3] = 4'bxxxx;
end

assign #(tPLHW_min:tPLHW_typ:tPLHW_max, tPHLW_min:tPHLW_typ:tPHLW_max)
	di = d;

always @(we_==0)
begin
	ram[wa] <= di;
end

assign (strong0,highz1) #(tPLHR_min:tPLHR_typ:tPLHR_max, tPHLR_min:tPHLR_typ:tPHLR_max)
	q[0] = re_==0 ? ram[ra][0] : 1'bz;
assign (strong0,highz1) #(tPLHR_min:tPLHR_typ:tPLHR_max, tPHLR_min:tPHLR_typ:tPHLR_max)
	q[1] = re_==0 ? ram[ra][1] : 1'bz;
assign (strong0,highz1) #(tPLHR_min:tPLHR_typ:tPLHR_max, tPHLR_min:tPHLR_typ:tPHLR_max)
	q[2] = re_==0 ? ram[ra][2] : 1'bz;
assign (strong0,highz1) #(tPLHR_min:tPLHR_typ:tPLHR_max, tPHLR_min:tPHLR_typ:tPHLR_max)
	q[3] = re_==0 ? ram[ra][3] : 1'bz;

endmodule
