`include "FIFO_if.sv"
import FIFO_transaction_pkg::*;
import FIFO_coverage_pkg;
import FIFO_scoreboard_pkg::*;
import FIFO_shared_pkg::*;

module monitor
(
FIFO_if.MON vif  
);

FIFO_transaction F_txn;
FIFO_coverage F_cvg;
FIFO_scoreboard F_scb;

initial
  begin
    //constructing the objects
    F_txn = new();
    F_cvg = new();
    F_scb = new();

    forever
      begin
        @(  negedge vif.clk  );
        //will also wait till driving of the data has been done (just in case)
          @( drive_done );

        //sampling the values (copying the values from the interface to the DUT )
         //clk is not send here as it is not written in the transction module as it cannot be rand
         F_txn.data_out = vif.data_out;
         F_txn.full = vif.full;
         F_txn.almostfull = vif.almostfull;
         F_txn.empty = vif.empty;
         F_txn.almost_empty = vif.almost_empty;
         F_txn.overflow = vif.overflow;
         F_txn.underflow = vif.underflow;
         F_txn.w_ack = vif.w_ack;
         F_txn.data_in = vif.data_in;
         F_txn.wr_en = vif.wr_en;
         F_txn.rd_en = vif.rd_en;
         F_txn.rst_n = vif.rst_n;




         fork
            F_cov.sample_data( F_txn );
            F_scb.check_data( F_txn );5
         join
         

         if( test_finished )
          begin
            $display("============================================================================");
              $display("Correct count = %0d ", correct_count);
              $display("error count = %0d ", error_count);
            $display("============================================================================");
            $finish;              
          end




      end
 end

endmodule 
