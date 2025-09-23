module v7404 (input logic pin1, pin3, pin5, pin9, pin11, pin13, output logic
pin2, pin4, pin6, pin8, pin10, pin12);
    
    assign pin2 = ~pin1;
    assign pin4 = ~pin3;
    assign pin6 = ~pin5;
    assign pin8 = ~pin9;
    assign pin10 = ~pin11;
    assign pin12 = ~pin13;
    
endmodule

module v7408 (input logic pin1, output logic pin3, input logic pin5, input
    logic pin9, output logic pin11, input logic pin13, input logic pin2, input
    logic pin4, output logic pin6, output logic pin8, input logic pin10, input
    logic pin12);
    
    assign pin3 = pin1 & pin2;
    assign pin6 = pin4 & pin5;
    assign pin8 = pin9 & pin10;
    assign pin11 = pin12 & pin13;

endmodule


module v7432 (input logic pin1, output logic pin3, input logic pin5, input
    logic pin9, output logic pin11, input logic pin13, input logic pin2, input
    logic pin4, output logic pin6, output logic pin8, input logic pin10, input
    logic pin12);
    
    assign pin3 = pin1 | pin2;
    assign pin6 = pin4 | pin5;
    assign pin8 = pin9 | pin10;
    assign pin11 = pin12 | pin13;
    
endmodule

module mux2to1(input logic x, y, s, output logic m);

    // internal logic
    logic s_n;
    logic x_sn;
    logic y_s;
    
    
    v7404 inv_s(
        .pin1(s), 
        .pin2(s_n),
        .pin3(), .pin4(),
        .pin5(), .pin6(),
        .pin9(), .pin8(),
        .pin11(), .pin10(),
        .pin13(), .pin12()
    );
    
    
    v7408 and1(
        .pin1(x), .pin2(s_n), .pin3(x_sn),
        .pin4(y), .pin5(s),
        .pin9(), .pin10(),
        .pin12(), .pin13(), .pin11(),
        .pin6(y_s), .pin8()
    );

    
    
    v7432 or1(
        .pin1(x_sn), .pin2(y_s), .pin3(m),
        .pin4(), .pin5(),
        .pin9(), .pin10(),
        .pin12(), .pin13(), .pin11(),
        .pin6(), .pin8()
    );
    
    
endmodule
