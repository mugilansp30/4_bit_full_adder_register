
module d_flip_flop (
    input  logic D,
    input  logic clk,
    input  logic reset,
    output logic Q
);

    always_ff @(posedge clk) begin

        if (reset)
            Q <= 1'b0;

        else
            Q <= D;

    end

endmodule
