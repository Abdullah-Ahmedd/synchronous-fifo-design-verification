package FIFO_coverage_pkg;

  import FIFO_transaction_pkg::* ;
class FIFO_coverage;
  //fifo_transaction object
  FIFO_transaction F_cvg_txn;

////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           COVERGROUP                                           //
////////////////////////////////////////////////////////////////////////////////////////////////////

covergroup cg_fifo;

  //coverpoint for write enable
write:    coverpoint F_cvg_txn.wr_en;

  //coverpoint for read enable
read:    coverpoint F_cvg_txn.rd_en;

  //coverpoint for all outputs except data_out
f:    coverpoint F_cvg_txn.full;
af:    coverpoint F_cvg_txn.almostfull;
e:    coverpoint F_cvg_txn.empty;
ae:    coverpoint F_cvg_txn.almost_empty;
of:    coverpoint F_cvg_txn.overflow;
uf:    coverpoint F_cvg_txn.underflow;
wa:   coverpoint F_cvg_txn.wr_ack;


  //corss coverage
      //1) wr_en --- rd_en --- full
        cross write , read , f;
      //2) wr_en --- rd_en --- almostfull
        cross write , read , af;
      //3) wr_en --- rd_en --- empty
        cross write , read , e;
      //4) wr_en --- rd_en --- almostempty
        cross write , read , ae;
      //5) wr_en --- rd_en --- overflow
        cross write , read , of;
      //6) wr_en --- rd_en --- underflow
        cross write , read , uf;
      //7) wr_en --- rd_en --- wr_ack
        cross write , read , wa;

endgroup  


////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           CONSTRUCTOR                                           //
////////////////////////////////////////////////////////////////////////////////////////////////////

function new();
  F_cvg_txn = new();
  cg_fifo = new();
endfunction


//SAMPLE FUNCTION
function void sample_data (FIFO_transaction F_txn );

  F_cvg_txn = F_txn;
  cg_fifo.sample();

endfunction


endclass

endpackage