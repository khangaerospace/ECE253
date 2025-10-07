module part1(input logic clock, reset, ParallelLoadn, RotateRight, ASRight, input logic [3:0] Data_IN, output logic [3:0] Q);
    logic m1_2, m2_3, m3_f1, m4_5, m5_f2, m6_7, m7_f3, m8_9, m9_f4;

    //Flip Flop 1
    mux2to1 u1(
        .MuxSelect(RotateRight),
        .MuxIn(Q[0], Q[3]),
        .Out(m1_2),
        )

    mux2to1 u2(
        .MuxSelect(ASRight),
        .MuxIn(m1_2, Q[3]),
        .Out(m2_3),
        )

    mux2to1 u3(
        .MuxSelect(ParallelLoadn),
        .MuxIn(m2_3, Data_IN[0]),
        .Out(m3_f1),
        )

    flipflop fu1(
        .Clock(clock),
        .Reset(reset),
        .result(m3_f1),
        .out(Q[0])
        )

    //Flip Flop 2
    mux2to1 u4(
        .MuxSelect(RotateRight),
        .MuxIn(Q[0], Q[1]),
        .Out(m4_5),
        )

    mux2to1 u5(
        .MuxSelect(ParallelLoadn),
        .MuxIn(m4_5, Data_IN[1]),
        .Out(m5_f2),
        )

    flipflop fu2(
        .Clock(clock),
        .Reset(reset),
        .result(m5_f2),
        .out(Q[1])
        )

    //Flip Flop 3
    mux2to1 u6(
        .MuxSelect(RotateRight),
        .MuxIn(Q[2], Q[1]),
        .Out(m6_7),
        )

    mux2to1 u7(
        .MuxSelect(ParallelLoadn),
        .MuxIn(m6_7, Data_IN[2]),
        .Out(m7_f3),
        )

    flipflop fu3(
        .Clock(clock),
        .Reset(reset),
        .result(m7_f3),
        .out(Q[2])
        )

    //Flip Flop 4
    mux2to1 u8(
        .MuxSelect(RotateRight),
        .MuxIn(Q[2], Q[3]),
        .Out(m8_9),
        )

    mux2to1 u9(
        .MuxSelect(ParallelLoadn),
        .MuxIn(m8_9, Data_IN[3]),
        .Out(m9_f4),
        )

    flipflop fu4(
        .Clock(clock),
        .Reset(reset),
        .result(m9_f4),
        .out(Q[3])
        )

endmodule

module flipflop(input  logic Clock, input  logic Reset, input  logic result, output logic out);


    always_ff @(posedge Clock) begin
        if (Reset)
            out <= 4'b0000;
        else
            out <= result;
    end

endmodule

module mux2to1(input logic MuxSelect, input logic [1:0] MuxIn, output logic Out);
    always_comb
    begin
        case (MuxSelect)
            1'b0: Out = MuxIn[0];
            1'b1: Out = MuxIn[1];
            default : Out = 0;
        endcase
    end
endmodule