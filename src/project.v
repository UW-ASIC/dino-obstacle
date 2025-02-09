/*
 * Copyright (c) 2024 UWASIC
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_obstacles_dino (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    assign uio_oe = 8'b00001111;
    wire [8:0] obstacle1_pos;
    wire [8:0] obstacle2_pos;
    wire [2:0] obstacle1_type;
    wire [2:0] obstacle2_type;
    obstacles #(.GEN_LINE(250)) obstacles_inst (
        .clk(clk),
        .rst_n(rst_n),
        .rng(ui_in),
        .obstacle1_pos(obstacle1_pos),
        .obstacle2_pos(obstacle2_pos),
        .obstacle1_type(obstacle1_type),
        .obstacle2_type(obstacle2_type)
    );
    wire [8:0] obstacle_pos_mux = uio_in[7] ? obstacle1_pos : obstacle2_pos;
    wire [2:0] obstacle_type_mux = uio_in[7] ? obstacle1_type : obstacle2_type;

    assign uio_out = {4'b1111, obstacle_type_mux, obstacle_pos_mux[8]};
    assign uo_out = obstacle_pos_mux[7:0];

    wire _unused = &{uio_in[6:0], ena, 1'b0};

endmodule
