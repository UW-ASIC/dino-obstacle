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

  reg clock=1'b0;
  wire[8:0] counter;
  reg reset=1'b1;
  down_count u1(.clock(clock), .count({uio_out[0], uo_out[7:0]}), .reset(reset), .load_en(uio_in[1]), .load_value({uio_in[3], uio_in[4]}));


  // All output pins must be assigned. If not used, assign to 0.
  assign uio_oe  = 8'b00000001;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0, ui_in};

endmodule
