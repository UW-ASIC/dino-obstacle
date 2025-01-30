`timescale 1ns / 1ps
module obstacle_generator_tb;
    reg clk, rst, en, rng_in;
    wire [9:0] obstacles;

    obstacle_generator uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .rng_in(rng_in),
        .obstacles(obstacles)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $monitor("Time: %0t | Obstacles: %b | RNG: %b", $time, obstacles, rng_in);
        
        clk = 0;
        rst = 1;
        en = 0;
        rng_in = 0;
        
        #10 rst = 0; // Release reset
        #10 en = 1;  // Enable shifting

        // Simulated RNG input
        #10 rng_in = 0;
        #10 rng_in = 1; // First possible obstacle placement
        #20 rng_in = 0;
        #10 rng_in = 1; // New obstacle appears if allowed
        #50 $finish;
    end
endmodule
