module top_module (input x, input y, output z);
wire z1,z2,z3,z4;
    A_mod ins1(x,y,z1);
    B_mod ins2(x,y,z2);
    A_mod ins3(x,y,z3);
    B_mod ins4(x,y,z4);
    assign z = (z1 | z2) ^ (z3 & z4);
endmodule

module A_mod (input x, input y, output z);
    assign z = (x^y) &x;
endmodule

module B_mod ( input x, input y, output z );
    assign z = x ^ ~y;
endmodule

