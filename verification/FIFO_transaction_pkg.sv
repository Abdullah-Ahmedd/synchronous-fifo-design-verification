package FIFO_transaction_pkg;

class FIFO_transaction;

//PARAMETERS
  parameter FIFO_WIDTH = 16;
  parameter FIFO_DEPTH = 8;



////////////////////////////////////////////////////////////////////////////////////////////////////
//                                    Signal declaration                                          //
////////////////////////////////////////////////////////////////////////////////////////////////////



//inputs (randomzied)
  rand logic [ FIFO_WIDTH - 1 : 0 ] data_in;
  rand logic wr_en;
  rand logic rd_en;
  rand logic rst_n;

//outputs (never randomzied)
  logic [ FIFO_WIDTH - 1 : 0 ] data_out;
  logic full;
  logic almostfull;
  logic empty;
  logic almost_empty;
  logic overflow;
  logic underflow;
  logic wr_ack;  

//class variables
  int RD_EN_ON_DIST;
  int WR_EN_ON_DIST;



////////////////////////////////////////////////////////////////////////////////////////////////////
//                                        Constructor                                             //
////////////////////////////////////////////////////////////////////////////////////////////////////



function new ( int rd_en_on_dist = 30 , int wr_en_on_dist = 70 );

  RD_EN_ON_DIST = rd_en_on_dist;
  WR_EN_ON_DIST = wr_en_on_dist;

endfunction  



////////////////////////////////////////////////////////////////////////////////////////////////////
//                                        CONSTRAINTS                                             //
////////////////////////////////////////////////////////////////////////////////////////////////////

// reset constraint
  constraint reset_c
  {
  rst_n dist {  1 := 95 , 0 := 5  };  
  }
// write enable constraint 
  constraint write_en_c
  {
   wr_en dist {1 := WR_EN_ON_DIST , 0 := ( 100 - WR_EN_ON_DIST ) } ; 
  }

// read enable constraint 
  constraint read_en_c
  {
   rd_en dist {1 := RD_EN_ON_DIST , 0 := ( 100 - RD_EN_ON_DIST ) } ; 
  }







endclass



  
endpackage 