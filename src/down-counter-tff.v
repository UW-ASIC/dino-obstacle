module down_counter_tff
    #( 	parameter bits = 9)
    (
    input   wire              clk,
    input   wire              rst_n,
    input   wire              load_en,
    input   wire  [bits-1:0]  data,
    output  wire   [bits-1:0]  out
);
    genvar i;
	// Generate for loop to instantiate N times
    wire [bits:0] t_wire;
    wire [bits-1:0] q_wire;
    assign t_wire[0] = 1'b1;
    assign out = ~q_wire;
    tff_load tff_inst_0 (clk, rst_n, t_wire[0], load_en, data[0], q_wire[0]);
	generate
		for (i = 1; i < bits; i = i + 1) begin
            assign t_wire[i] = t_wire[i-1] & q_wire[i-1];
            tff_load tff_inst (clk, rst_n, t_wire[i], load_en, ~data[i], q_wire[i]);
		end
	endgenerate
endmodule