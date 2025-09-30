module FA(input logic a, b, c_in, output s, c_out);
    assign s = a ^ b ^ c_in;
    assign c_out = (a & b) | (c_in &  a) | (c_in & b);
endmodule

module adder(input logic [3:0] a, b, input logic c_in, output logic [3:0] s, c_out);
    FA u0(a[0], b[0], c_in, s[0], c_out[0]);
    FA u1(a[1], b[1], c_out[0], s[1], c_out[1]);
    FA u2(a[2], b[2], c_out[1], s[2], c_out[2]);
    FA u3(a[3], b[3], c_out[2], s[3], c_out[3]);
endmodule

module part2(input logic [3:0] A, B, input logic [1:0] Function, output logic [7:0] ALUout);
    logic [3:0] sum;
    logic [3:0] carry;
    logic final_cout;

    adder u0 (
        .a(A),
        .b(B),
        .c_in(1'b0),
        .s(sum),
        .c_out(carry)
    );

    assign final_cout = carry[3];
    always_comb begin
        case (Function)
            2'b00: begin
                ALUout = {3'b000, final_cout, sum};
            end

            2'b01: begin
                if (A | B)
                    ALUout = 8'b00000001;
                else
                    ALUout = 8'b00000000;
            end

            2'b10: begin
                if (A[0] & A[1] & A[2] & A[3] & B[0] & B[1] & B[2] & B[3])
                    ALUout = 8'b00000001;
                else
                    ALUout = 8'b00000000;
            end

            2'b11: begin
                ALUout = {A, B};
            end

            default: begin
                ALUout = 8'b00000000;
            end
        endcase
    end

endmodule
