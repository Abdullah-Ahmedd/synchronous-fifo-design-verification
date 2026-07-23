package FIFO_shared_pkg;

  //test completed bit , when all the tests are completed the tb will raise this bit
    int test_finished = 0; 
  //total number of successful tests
    int correct_count = 0;  
  //total number of failed tests
    int error_count = 0;


    //event that is triggered at the negative edge of the clock
    //when the driving of the stimulus is done
    //this event is triggered by the testbench
       event drive_done;

endpackage