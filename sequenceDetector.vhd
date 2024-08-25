module dffo (
    input D, C,
    output Q, Qn
);
    wire n1n3, n2n4, n3n5, n4n3, n5n7, n6n8, Cn;

    not n0(Cn, C);
    nand n1(n1n3, D, C);
    nand n2(n2n4, n1n3, C);
    nand n3(n3n5, n1n3, n4n3);
    nand n4(n4n3, n2n4, n3n5);
    nand n5(n5n7, n3n5, Cn);
    nand n6(n6n8, n5n7, Cn);
    nand n7(Q, n5n7, Qn);
    nand n8(Qn, n6n8, Q);
endmodule

module sequence_detector (
    input X, Clk,
    output Y, Cout
);
    wire dff1i, dff2i, dff3i;
    wire Xn, Q1, Qn1, Q2, Qn2, Q3, Qn3, y2o;

    dffo ff1(dff1i, Q1, Qn1, Clk);
    dffo ff2(dff2i, Q2, Qn2, Clk);
    dffo ff3(dff3i, Q3, Qn3, Clk);
    
    // Precompute Xn to avoid repeated inversion
    not n1(Xn, X);

    // D flip-flop inputs using minimized logic
    nand d3nf(dff3i, 
              ~(Xn & Q3 & Qn2 & Q1),
              ~(X & Qn3 & Q2 & Q1),
              ~(X & Q3 & Qn1)
    );

    nand d2nf(dff2i, 
              ~(Qn3 & Q2 & Qn1),
              ~(Qn2 & Q1 & Q3),
              ~(Qn2 & Q1 & X)
    );

    nand d1nf(dff1i, 
              ~(X & Qn2 & Qn1),
              ~(Q3 & Q2 & Q1 & X),
              ~(Xn & Qn3 & Q2 & Qn1)
    );

    // Y output logic
    nand y1(y2o, Q3, Q2, Qn1);
    nand yf(Y, y2o);

    // Simple Cout logic
    assign Cout = Clk;
endmodule
