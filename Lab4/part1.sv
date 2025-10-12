module part1(input logic clock, reset, ParallelLoadn, RotateRight, ASRight, input logic [3:0] Data_IN, output logic [3:0] Q);

    logic d0_dir, d1_dir, d2_dir, d3_asr, d3_dir;
    logic d0, d1, d2, d3;


    mux2to1 u1(.MuxSelect(RotateRight), .MuxIn({Q[1], Q[3]}), .Out(d0_dir));
    mux2to1 u3(.MuxSelect(ParallelLoadn), .MuxIn({d0_dir, Data_IN[0]}), .Out(d0));
    flipflop fu1(.Clock(clock), .Reset(reset), .result(d0), .Out(Q[0]));

    mux2to1 u4( .MuxSelect(RotateRight), .MuxIn({Q[2], Q[0]}), .Out(d1_dir));
    mux2to1 u5 (.MuxSelect(ParallelLoadn), .MuxIn({d1_dir, Data_IN[1]}), .Out(d1));
    flipflop fu2(.Clock(clock), .Reset(reset), .result(d1), .Out(Q[1]) );


    mux2to1 u6 (.MuxSelect(RotateRight), .MuxIn({Q[3], Q[1]}), .Out(d2_dir));
    mux2to1 u7 (.MuxSelect(ParallelLoadn), .MuxIn({d2_dir, Data_IN[2]}), .Out(d2)) ;
    flipflop fu3(.Clock(clock), .Reset(reset), .result(d2), .Out(Q[2]));


    logic m2_asr;
    mux2to1 u2(.MuxSelect(ASRight), .MuxIn({Q[3], Q[0]}), .Out(m2_asr));
    mux2to1 u8(.MuxSelect(RotateRight), .MuxIn({m2_asr, Q[2]}), .Out(d3_dir) );
    mux2to1 u9(.MuxSelect(ParallelLoadn), .MuxIn({d3_dir, Data_IN[3]}), .Out(d3));
    flipflop fu4(.Clock(clock), .Reset(reset), .result(d3), .Out(Q[3]));

endmodule

module flipflop(input  logic Clock, input  logic Reset, input  logic result, output logic Out);


    always_ff @(posedge Clock) begin
        if (Reset)
            Out <= 1'b0;
        else
            Out <= result;
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