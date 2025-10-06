module part3(input  logic Clock, input  logic Reset_b, input  logic [3:0]  Data, input  logic [2:0]  Function, output logic [7:0]  ALU_reg_out);

    logic [3:0] B;
    logic [7:0] alu_result;

    // Combinational ALU
    always_comb begin
        unique case (Function)
            3'b000: alu_result = {4'b000,Data} + {4'b000,B};
            3'b001: alu_result = {4'b000,Data} * {4'b000,B}; 
            3'b010: alu_result = {4'b000,B} << Data; 
            3'b011: alu_result = ALU_reg_out;
            default: alu_result = 8'b00000000;
        endcase
    end
    
    always_ff @(posedge Clock) begin
        if (Reset_b)
            ALU_reg_out <= 8'b00000000;
        else
            ALU_reg_out <= alu_result;
    end

    assign B = ALU_reg_out[3:0];

endmodule
