
`timescale 1ns/1ps

module tb_full_adder_with_register;

    reg [3:0] A, B;
    reg CIN;
    reg clk, reset;

    wire [3:0] SUM;
    wire COUT;

    reg [4:0] expected;

    integer i, j, k;
    integer errors;

    // Instantiate registered Full Adder
    full_adder_with_register DUT (
        .A(A),
        .B(B),
        .CIN(CIN),
        .clk(clk),
        .reset(reset),
        .SUM(SUM),
        .COUT(COUT)
    );

    // Clock generation: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        errors = 0;

        A = 0;
        B = 0;
        CIN = 0;
        reset = 1;

        $display("------------------------------------------");
        $display("  4-BIT FULL ADDER WITH DFF TESTBENCH");
        $display("------------------------------------------");

        // Apply synchronous reset
        @(posedge clk);
        #1;

        if ({COUT, SUM} !== 5'b00000) begin
            $display("ERROR: Reset failed!");
            errors = errors + 1;
        end

        reset = 0;

        // Test all 512 combinations
        for (i = 0; i < 16; i = i + 1) begin

            for (j = 0; j < 16; j = j + 1) begin

                for (k = 0; k < 2; k = k + 1) begin

                    // Apply inputs at negative clock edge
                    @(negedge clk);

                    A = i;
                    B = j;
                    CIN = k;

                    // Calculate expected result
                    expected = {1'b0, A} +
                               {1'b0, B} + CIN;

                    // Wait for positive clock edge
                    @(posedge clk);
                    #1;

                    // Verify stored output
                    if ({COUT, SUM} !== expected) begin

                        $display(
                            "FAILED: A=%b B=%b CIN=%b EXPECTED=%b ACTUAL=%b",
                            A, B, CIN, expected, {COUT, SUM}
                        );

                        errors = errors + 1;

                    end

                end

            end

        end

        $display("------------------------------------------");

        if (errors == 0)
            $display("ALL 512 TEST CASES PASSED!");
        else
            $display("TEST FAILED: %0d ERRORS", errors);

        $display("------------------------------------------");

        $finish;

    end

endmodule
