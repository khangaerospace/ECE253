module part2 #(parameter CLOCK_FREQUENCY=500)(
input logic ClockIn,
input logic Reset,
input logic [1:0] Speed,
output logic [3:0] CounterValue
);

logic Enable;
RateDivider #(.CLOCK_FREQUENCY(CLOCK_FREQUENCY)) u0 (.ClockIn(ClockIn), .Reset(Reset), .Speed(Speed), .Enable(Enable));
module DisplayCounter u1( .Clock(ClockIn), .Reset(Reset), .EnableDC(Enable), .CounterValue(CounterValue));



endmodule


module RateDivider #(parameter CLOCK_FREQUENCY = 500)(
    input  logic ClockIn,
    input  logic Reset,
    input  logic [1:0] Speed,
    output logic Enable
);
    logic [$clog2(CLOCK_FREQUENCY*4)-1:0] counter;
    logic [$clog2(CLOCK_FREQUENCY*4)-1:0] limcount;

    always_comb begin
        case (Speed)
            2'b00: limcount = 1;
            2'b01: limcount = CLOCK_FREQUENCY;
            2'b10: limcount = CLOCK_FREQUENCY * 2;
            2'b11: limcount = CLOCK_FREQUENCY * 4;
        endcase
    end

    always_ff @(posedge ClockIn or posedge Reset) begin
        if (Reset)
            counter <= 0;
        else if (counter == limcount - 1)
            counter <= 0;
        else
            counter <= counter + 1;
    end

    assign Enable = ~(|counter);  

endmodule



module DisplayCounter (
    input  logic Clock,
    input  logic Reset,
    input  logic EnableDC,
    output logic [3:0] CounterValue
);

    always_ff @(posedge Clock or posedge Reset) begin
        if (Reset)
            CounterValue <= 4'b0000; 
        else if (EnableDC)
            CounterValue <= CounterValue + 1;
    end

endmodule