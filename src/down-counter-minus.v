module down_count
(
  input clock,
  input reset,
  input [1:0] load_value,
  input load_en,
  output [8:0] count
);
  
  localparam MAX = 9'd511;
  reg [8:0] counter = 9'b0;
  
  always @(posedge clock)
    begin
      if (counter == 9'b0 || load_en || reset)
        counter <= {7'b1111111, load_value};
      else
      		counter <= counter - 1;
    end 
   
   assign count = counter;
       
endmodule