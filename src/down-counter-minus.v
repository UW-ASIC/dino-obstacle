module down_count
(
  input clock,
  input reset,
  output [8:0] count 
);
  
  localparam MAX = 9'd511;
  reg [8:0] counter = 9'b0;
  
  always @(posedge clock)
    begin
      if (counter == 9'b0 || reset)
        	counter <= MAX;
      else
      		counter <= counter - 1;
    end 
   
   assign count = counter;
       
endmodule