module tff_load(
    input   wire    clk,
    input   wire    rst_n,
    input   wire    t,
    input   wire    load_en,
    input   wire    data,
    output  reg     q
);
    always @(posedge clk) begin
        if(!rst_n) begin
            q <= 0;
        end else if (load_en) begin
            q <= data;
        end else begin
            q <= q ^ t;
        end
    end
endmodule