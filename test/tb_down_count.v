module top_module ();
  
  reg clock=1'b0;
  wire[8:0] counter;
  reg reset=1'b1;
  
  
  down_count u1(.clock(clock), .count(counter), .reset(reset));
  
  //clock with period=20
  always #10 clock = ~clock;  
  
  initial begin
        
   $dumpfile("top_module.vcd");
   $dumpvars(0, top_module);
    
    #10 reset=0;
    
  #1000;
    
  $finish;
    
  end
    
    
endmodule