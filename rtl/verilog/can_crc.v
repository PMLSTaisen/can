//////////////////////////////////////////////////////////////////////
////                                                              ////
////  can_crc.v                                                   ////
////                                                              ////
////                                                              ////
////  This file is part of the CAN Protocol Controller            ////
////  http://www.opencores.org/projects/can/                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////       Igor Mohor                                             ////
////       igorm@opencores.org                                    ////
////                                                              ////
////                                                              ////
////  All additional information is available in the README.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2002, 2003 Authors                             ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//// The CAN protocol is developed by Robert Bosch GmbH and       ////
//// protected by patents. Anybody who wants to implement this    ////
//// CAN IP core on silicon has to obtain a CAN protocol license  ////
//// from Bosch.                                                  ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.1  2003/01/08 02:10:54  mohor
// Acceptance filter added.
//
//
//
//

// synopsys translate_off
`include "timescale.v"
// synopsys translate_on

module can_crc (clk, data, enable, initialize, crc);


parameter Tp = 1;

input         clk;
input         data;
input         enable;               // Must be Destuffed !!!
input         initialize;

output [14:0] crc;

reg    [14:0] crc;

wire          crc_next;
wire   [14:0] crc_tmp;


assign crc_next = data ^ crc[14];
assign crc_tmp = {crc[13:0], 1'b0};

always @ (posedge clk)
begin
  if(initialize)
    crc <= #Tp 0;
//  else if (crc_next)
//    crc <= #Tp {crc[13:0], 1'b0} ^ 15'h4599;
//  else
//    crc <= #Tp {crc[13:0], 1'b0};
  else if (enable)
    begin
      if (crc_next)
        crc <= #Tp crc_tmp ^ 15'h4599;
      else
        crc <= #Tp crc_tmp;
    end    
end


endmodule
