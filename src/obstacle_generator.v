module obstacle_generator (
    input clk,
    input rst,
    input en,       // Enable shifting. Set this enable based on how quick you want the obstacles to move I guess
    input rng_in,   // External RNG input (1 to place obstacle)
    output reg [7:0] obstacles
);
    reg [1:0] zero_counter; // Tracks consecutive zeros

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            obstacles <= 8'b00000000;
            zero_counter <= 2'b00;
        end else if (en) begin
            // Shift obstacles left
            obstacles <= {obstacles[6:0], 1'b0};

            // Update zero counter
            if (obstacles[1:0] == 2'b00)
                zero_counter <= 2'b10; // Reset counter after two zeros
            else if (zero_counter != 0)
                zero_counter <= zero_counter - 1;

            // Place new obstacle if allowed
            if (zero_counter == 0 && rng_in) begin
                obstacles[0] <= 1'b1;
            end
        end
    end
endmodule