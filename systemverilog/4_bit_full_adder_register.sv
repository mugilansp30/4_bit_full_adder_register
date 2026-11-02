
module full_adder_with_register (
    input  logic [3:0] A,
    input  logic [3:0] B,
    input  logic CIN,
    input  logic clk,
    input  logic reset,

    output logic [3:0] SUM,
    output logic COUT
);

    logic [3:0] adder_sum;
    logic adder_cout;

    logic [4:0] stored_output;

    // Instantiate 4-bit Full Adder
    four_bit_full_adder FA (
        .A(A),
        .B(B),
        .CIN(CIN),
        .SUM(adder_sum),
        .COUT(adder_cout)
    );

    // Register the 4-bit SUM and CARRY
    d_flip_flop DFF0 (
        .D(adder_sum[0]),
        .clk(clk),
        .reset(reset),
        .Q(stored_output[0])
    );

    d_flip_flop DFF1 (
        .D(adder_sum[1]),
        .clk(clk),
        .reset(reset),
        .Q(stored_output[1])
    );

    d_flip_flop DFF2 (
        .D(adder_sum[2]),
        .clk(clk),
        .reset(reset),
        .Q(stored_output[2])
    );

    d_flip_flop DFF3 (
        .D(adder_sum[3]),
        .clk(clk),
        .reset(reset),
        .Q(stored_output[3])
    );

    d_flip_flop DFF4 (
        .D(adder_cout),
        .clk(clk),
        .reset(reset),
        .Q(stored_output[4])
    );

    // Registered outputs
    assign SUM  = stored_output[3:0];
    assign COUT = stored_output[4];

endmodule
