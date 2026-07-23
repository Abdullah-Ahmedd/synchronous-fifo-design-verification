interface FIFO_if
#(
    parameter FIFO_WIDTH = 16,
    parameter FIFO_DEPTH = 8
)
(
//Declaring the clock 
  input bit clk
);
////////////////////////////////////////////////////////////////////////////////////////////////////
//                                    Signal declaration                                          //
////////////////////////////////////////////////////////////////////////////////////////////////////



logic [ FIFO_WIDTH - 1 : 0 ] data_in;
logic wr_en;
logic rd_en;
logic rst_n;

logic [ FIFO_WIDTH - 1 : 0 ] data_out;
logic full;
logic almostfull;
logic empty;
logic almost_empty;
logic overflow;
logic underflow;
logic wr_ack;



////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            MODPORTS                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////

//1- DUT MODPORT
modport DUT
(
//inputs
input clk,
input data_in,
input wr_en,
input rd_en,
input rst_n,
//outputs
output data_out,
output full,
output almostfull,
output empty,
output almost_empty,
output overflow,
output underflow,
output wr_ack
);

//2-tb MODPORTS
modport TB
(
//inputs
input clk,
input data_out,
input full,
input almostfull,
input empty,
input almost_empty,
input overflow,
input underflow,
input wr_ack,
//outputs
output data_in,
output wr_en,
output rd_en,
output rst_n
);


//3-monitor MODPORT 
modport MON
(
//inputs
input clk,
input data_out,
input full,
input almostfull,
input empty,
input almost_empty,
input overflow,
input underflow,
input wr_ack,

input data_in,
input wr_en,
input rd_en,
input rst_n
);



endinterface