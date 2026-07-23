`include "FIFO_if.sv"
module FIFO
#(
    parameter FIFO_WIDTH = 16,
    parameter FIFO_DEPTH = 8  
)
(
 FIFO_if.DUT fifo
);
//Declaring the internal register
  logic [ FIFO_WIDTH - 1 : 0 ] MEM [ FIFO_DEPTH - 1 : 0 ];
//Declaring a parameter to have the width of the read and write pointer
  parameter PTR_WIDTH = $clog2( FIFO_DEPTH );
//read and write pointers
  logic [ PTR_WIDTH - 1  : 0 ] rd_ptr;
  logic [ PTR_WIDTH - 1 : 0 ]  wr_ptr;
//counter to store the capacity of the fifo , meaning fifo is empty --> counter=0 , fifo is full --> counter = FIFO_DEPTH
//note: did PTR_WIDTH : 0 not PTR_WIDTH - 1 : 0
// as if FIFO_WIDTH = 8  then ptr is 3 so we have 0 as empty and 1,2,3,4,5,6,7,8 registers to store at 
//so we want from 0 to and including 8 not 7
  logic [ PTR_WIDTH : 0 ] counter;


//flags 
  assign fifo.full = (  counter == FIFO_DEPTH  );
  assign fifo.almostfull =(  counter == FIFO_DEPTH - 1 );
  assign fifo.empty =( counter == 0 );
  assign fifo.almostempty = ( counter == 1 );

always@( posedge fifo.clk or negedge fifo.rst_n )
  begin
    if(  !fifo.rst_n )
      begin
        foreach(  MEM[ i ]  )
          MEM[ i ] <= 0;

          counter <= 0 ;

          fifo.overflow = 0;
          fifo.underflow = 0;
          fifo.wr_ack = 0;
           
          rd_ptr = 0;
          wr_ptr = 0;

      end
    else
      begin
          //write logic
            if(  fifo.wr_en  && !fifo.full   )
              begin
                MEM[ wr_ptr ] <= fifo.data_in;
                if(  wr_ptr  == FIFO_DEPTH - 1 ) //ptr has reached the end of the memory (no more further memory so we must start from position zero again)
                  wr_ptr <= 0;
                else
                  wr_ptr <= wr_ptr + 1; 
                  fifo.wr_ack <= 1; //declaring that the data has been written correclty       
              end

          //read logic 
             if(  fifo.rd_en  && !fifo.empty )
              begin
                fifo.data_out <= MEM[ rd_ptr ];
                if(  rd_ptr  == FIFO_DEPTH - 1 ) //ptr has reached the end of the memory (no more further memory so we must start from position zero again)
                  rd_ptr <= 0;
                else
                  rd_ptr <= rd_ptr + 1; 
              end
          //updating counter
              case({  fifo.wr_en  && !fifo.full  ,  fifo.rd_en  && !fifo.empty })
                2'b10: counter <= counter + 1; //write so we increment the counter
                2'b01: counter <= counter - 1; //read so we decrement the counter
                default: counter <= counter ;  //read and write at the same time so increment and dcrement so we dont do nothing
                                               // could also mean doing nothing ie. read and write=0 so we did nothing
              endcase

          //overflow logic
              fifo.overflow = (  fifo.wr_en && fifo.full );

          //underflow logic 
              fifo.underflow = (  fifo.rd_en && fifo.empty );
      end
  end  






endmodule