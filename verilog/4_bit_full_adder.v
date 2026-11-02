
module full_adder_1bit (
    input A,
    input B,
    input CIN,
    output SUM,
    output COUT
);

    assign SUM  = A ^ B ^ CIN;
    assign COUT = (A & B) | (B & CIN) | (A & CIN);

endmodule


module four_bit_full_adder (
    input [3:0] A,
    input [3:0] B,
    input CIN,
    output [3:0] SUM,
    output COUT
);

    wire C1, C2, C3;

    // First Full Adder - Bit 0
    full_adder_1bit FA0 (
        .A(A[0]),
        .B(B[0]),
        .CIN(CIN),
        .SUM(SUM[0]),
        .COUT(C1)
    );

    // Second Full Adder - Bit 1
    full_adder_1bit FA1 (
        .A(A[1]),
        .B(B[1]),
        .CIN(C1),
        .SUM(SUM[1]),
        .COUT(C2)
    );

    // Third Full Adder - Bit 2
    full_adder_1bit FA2 (
        .A(A[2]),
        .B(B[2]),
        .CIN(C2),
        .SUM(SUM[2]),
        .COUT(C3)
    );

    // Fourth Full Adder - Bit 3
    full_adder_1bit FA3 (
        .A(A[3]),
        .B(B[3]),
        .CIN(C3),
        .SUM(SUM[3]),
        .COUT(COUT)
    );

endmodule
