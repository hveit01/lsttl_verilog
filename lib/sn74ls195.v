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
// 4 bit shift register
module sn74ls195(q, qd_, clr, load, clk, j, k_, d);
input [3:0] d;
input clr, load, clk, j, k_;
output [3:0] q;
output qd_;
reg [3:0] shift;
wire [1:0] jk;

parameter
	tPLH_min=0,  tPLH_typ=14, tPLH_max=22,
	tPHL_min=0,  tPHL_typ=17, tPHL_max=26;

initial
begin
	shift <= 4'bxxxx;
end

always @(clr)
begin
	if (clr==0)
		shift <= 0;
end

assign jk = {j, k_};

always @(posedge clk)
begin
	if (load==0)
		shift <= d;
	else if (clr==1 && clk==1) begin
		case (jk)
		2'b01:
			shift <= { shift[2:0], shift[0] };
		2'b00, 2'b11:
			shift <= { shift[2:0], j };
		2'b10:
			shift <= { shift[2:0], ~shift[0] };
		default:
			;
		endcase
	end
end

assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	q = shift;
assign #(tPLH_min:tPLH_typ:tPLH_max, tPHL_min:tPHL_typ:tPHL_max)
	qd_ = ~shift[3];

endmodule
