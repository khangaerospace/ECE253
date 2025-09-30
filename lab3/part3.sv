module part3(
    input  logic        Clock,
    input  logic        Reset_b,      // active-high synchronous reset
    input  logic [3:0]  Data,         // input A
    input  logic [2:0]  Function,     // function select
    output logic [7:0]  ALU_reg_out   // registered ALU output
);

    logic [3:0] B;         // feedback from register (low 4 bits)
    logic [7:0] alu_result;

    // Combinational ALU
    always_comb begin
        unique case (Function)
            3'b000: alu_result = Data + B;          // Addition
            3'b001: alu_result = Data * B;          // Multiplication
            3'b010: alu_result = B << Data;         // Left shift
            3'b011: alu_result = ALU_reg_out;       // Hold value
            default: alu_result = 8'b00000000;
        endcase
    end

    // Sequential Register (active-high synchronous reset)
    always_ff @(posedge Clock) begin
        if (Reset_b)
            ALU_reg_out <= 8'b00000000;
        else
            ALU_reg_out <= alu_result;
    end

    // Feedback path (low 4 bits of register)
    assign B = ALU_reg_out[3:0];

endmodule
