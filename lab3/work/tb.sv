module tb;
    logic [3:0] A, B;
    logic [1:0] Function;
    logic [7:0] ALUout;

    // Instantiate ALU
    part2 dut (
        .A(A),
        .B(B),
        .Function(Function),
        .ALUout(ALUout)
    );

    initial begin
        // Test case 1: Addition (3 + 5 = 8)
        A = 4'b0011;  
        B = 4'b0101;
        Function = 2'b00;
        #10 $display("Function=00 (Add) A=%b B=%b ALUout=%b", A, B, ALUout);

        // Test case 2: OR detection
        A = 4'b0000;  
        B = 4'b0001;  
        Function = 2'b01;
        #10 $display("Function=01 (OR detect) A=%b B=%b ALUout=%b", A, B, ALUout);

        // Test case 3: AND-all detection
        A = 4'b1111;  
        B = 4'b1111;  
        Function = 2'b10;
        #10 $display("Function=10 (AND-all) A=%b B=%b ALUout=%b", A, B, ALUout);

        // Test case 4: Concatenation
        A = 4'b1010;  
        B = 4'b0101;  
        Function = 2'b11;
        #10 $display("Function=11 (Concat) A=%b B=%b ALUout=%b", A, B, ALUout);

        $stop;
    end
endmodule
