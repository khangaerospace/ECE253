module FA(input logic a, b, c_in, output s, c_out);
    assign s = a ^ b ^ c_in;
    assign c_out = (a & b) | (c_in &  a) | (c_in & b);
endmodule

module Adder(input logic [3:0] a, b, input logic c_in, output logic [3:0] s, c_out);
    FA u0(a[0], b[0], c_in, s[0], c_out[0]);
    FA u1(a[1], b[1], c_out[0], s[1], c_out[1]);
    FA u2(a[2], b[2], c_out[1], s[2], c_out[2]);
    FA u3(a[3], b[3], c_out[2], s[3], c_out[3]);
endmodule

module part2(input logic [3:0] A, B, input logic [1:0] Function, output logic [7:0] ALUout);
    logic [3:0] sum;
    logic [3:0] carry;
    logic final_cout;
    logic [3:0] OR, AND; 

    Adder u0 (
        .a(A),
        .b(B),
        .c_in(1'b0),
        .s(sum),
        .c_out(carry)
    );
    assign final_cout = carry[3];
    
    assign OR = |{A,B};
    assign AND = &{A,B};
    
    always_comb
    begin
        case (Function)
            2'b00: ALUout = {3'b000, final_cout, sum};
            2'b01: ALUout = {7'b0000000, OR};
            2'b10: ALUout = {7'b0000000, AND};
            2'b11: ALUout = {A, B};
            default: ALUout = 8'b00000000;
        endcase
        
    end
endmodule
