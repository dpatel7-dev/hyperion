// ─────────────────────────────────────────
// HYPERION POSITIONAL ENCODING
// Sinusoidal position encoding
// ─────────────────────────────────────────

module positional_encoding (
    input  clk,
    input  reset,
    input  [2:0] pos,
    input  signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7,
    output signed [15:0] out0,out1,out2,out3,
    output signed [15:0] out4,out5,out6,out7
);

    reg signed [7:0] pe_val0,pe_val1,pe_val2,pe_val3;
    reg signed [7:0] pe_val4,pe_val5,pe_val6,pe_val7;

    always @(*) begin
        case (pos)
            3'd0: begin
                pe_val0 = 8'sd0;
                pe_val1 = 8'sd64;
                pe_val2 = 8'sd0;
                pe_val3 = 8'sd64;
                pe_val4 = 8'sd0;
                pe_val5 = 8'sd64;
                pe_val6 = 8'sd0;
                pe_val7 = 8'sd64;
            end
            3'd1: begin
                pe_val0 = 8'sd53;
                pe_val1 = 8'sd60;
                pe_val2 = 8'sd6;
                pe_val3 = 8'sd63;
                pe_val4 = 8'sd0;
                pe_val5 = 8'sd63;
                pe_val6 = 8'sd0;
                pe_val7 = 8'sd63;
            end
            3'd2: begin
                pe_val0 = 8'sd58;
                pe_val1 = 8'sd51;
                pe_val2 = 8'sd12;
                pe_val3 = 8'sd63;
                pe_val4 = 8'sd1;
                pe_val5 = 8'sd63;
                pe_val6 = 8'sd0;
                pe_val7 = 8'sd63;
            end
            3'd3: begin
                pe_val0 = 8'sd9;
                pe_val1 = 8'sd37;
                pe_val2 = 8'sd18;
                pe_val3 = 8'sd63;
                pe_val4 = 8'sd1;
                pe_val5 = 8'sd63;
                pe_val6 = 8'sd0;
                pe_val7 = 8'sd63;
            end
            3'd4: begin
                pe_val0 = -8'sd48;
                pe_val1 = 8'sd19;
                pe_val2 = 8'sd24;
                pe_val3 = 8'sd63;
                pe_val4 = 8'sd2;
                pe_val5 = 8'sd63;
                pe_val6 = 8'sd0;
                pe_val7 = 8'sd63;
            end
            3'd5: begin
                pe_val0 = -8'sd61;
                pe_val1 = 8'sd0;
                pe_val2 = 8'sd30;
                pe_val3 = 8'sd63;
                pe_val4 = 8'sd3;
                pe_val5 = 8'sd63;
                pe_val6 = 8'sd0;
                pe_val7 = 8'sd63;
            end
            3'd6: begin
                pe_val0 = -8'sd17;
                pe_val1 = -8'sd20;
                pe_val2 = 8'sd36;
                pe_val3 = 8'sd62;
                pe_val4 = 8'sd3;
                pe_val5 = 8'sd63;
                pe_val6 = 8'sd0;
                pe_val7 = 8'sd63;
            end
            3'd7: begin
                pe_val0 = 8'sd42;
                pe_val1 = -8'sd38;
                pe_val2 = 8'sd41;
                pe_val3 = 8'sd62;
                pe_val4 = 8'sd4;
                pe_val5 = 8'sd63;
                pe_val6 = 8'sd0;
                pe_val7 = 8'sd63;
            end
            default: begin
                pe_val0=0; pe_val1=0; pe_val2=0; pe_val3=0;
                pe_val4=0; pe_val5=0; pe_val6=0; pe_val7=0;
            end
        endcase
    end

    assign out0 = x0 + {{8{pe_val0[7]}}, pe_val0};
    assign out1 = x1 + {{8{pe_val1[7]}}, pe_val1};
    assign out2 = x2 + {{8{pe_val2[7]}}, pe_val2};
    assign out3 = x3 + {{8{pe_val3[7]}}, pe_val3};
    assign out4 = x4 + {{8{pe_val4[7]}}, pe_val4};
    assign out5 = x5 + {{8{pe_val5[7]}}, pe_val5};
    assign out6 = x6 + {{8{pe_val6[7]}}, pe_val6};
    assign out7 = x7 + {{8{pe_val7[7]}}, pe_val7};

endmodule
