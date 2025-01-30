/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
  assign uio_oe = 8'b00000001;
  // All output pins must be assigned. If not used, assign to 0.
  down_counter_tff #(.bits(9)) down_counter_tff_inst (
        .clk(clk),
        .rst_n(rst_n),
        .load_en(ui_in[0]),
        .data({uio_in[7:6],ui_in[5:0]}),
        .out({uio_out[0],uo_out[7:0]})
        );
  
  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule