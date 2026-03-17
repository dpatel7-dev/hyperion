module embedding_table (
    input  clk, input reset,
    input  [3:0] token_id,
    output signed [15:0] out0,out1,out2,out3,
    output signed [15:0] out4,out5,out6,out7
);
    reg signed [7:0] e0,e1,e2,e3,e4,e5,e6,e7;
    always @(*) begin
        case (token_id)
            4'd0: begin
                e0 = -8'sd36;
                e1 = -8'sd58;
                e2 = 8'sd6;
                e3 = -8'sd2;
                e4 = -8'sd7;
                e5 = -8'sd29;
                e6 = -8'sd38;
                e7 = -8'sd42;
            end
            4'd1: begin
                e0 = 8'sd44;
                e1 = -8'sd56;
                e2 = -8'sd57;
                e3 = -8'sd41;
                e4 = -8'sd9;
                e5 = -8'sd5;
                e6 = -8'sd58;
                e7 = -8'sd14;
            end
            4'd2: begin
                e0 = 8'sd43;
                e1 = -8'sd8;
                e2 = 8'sd50;
                e3 = 8'sd7;
                e4 = -8'sd63;
                e5 = -8'sd24;
                e6 = 8'sd44;
                e7 = 8'sd23;
            end
            4'd3: begin
                e0 = 8'sd7;
                e1 = -8'sd25;
                e2 = -8'sd9;
                e3 = 8'sd22;
                e4 = -8'sd38;
                e5 = -8'sd41;
                e6 = 8'sd33;
                e7 = -8'sd40;
            end
            4'd4: begin
                e0 = 8'sd27;
                e1 = 8'sd24;
                e2 = 8'sd3;
                e3 = -8'sd53;
                e4 = 8'sd53;
                e5 = -8'sd33;
                e6 = 8'sd32;
                e7 = -8'sd44;
            end
            4'd5: begin
                e0 = 8'sd11;
                e1 = 8'sd28;
                e2 = -8'sd15;
                e3 = -8'sd47;
                e4 = -8'sd53;
                e5 = -8'sd6;
                e6 = 8'sd10;
                e7 = -8'sd44;
            end
            4'd6: begin
                e0 = -8'sd5;
                e1 = -8'sd39;
                e2 = 8'sd33;
                e3 = 8'sd7;
                e4 = 8'sd52;
                e5 = 8'sd29;
                e6 = -8'sd23;
                e7 = 8'sd30;
            end
            4'd7: begin
                e0 = 8'sd26;
                e1 = -8'sd11;
                e2 = 8'sd4;
                e3 = -8'sd46;
                e4 = -8'sd21;
                e5 = -8'sd2;
                e6 = -8'sd23;
                e7 = 8'sd54;
            end
            4'd8: begin
                e0 = 8'sd33;
                e1 = 8'sd5;
                e2 = -8'sd8;
                e3 = 8'sd19;
                e4 = -8'sd50;
                e5 = -8'sd6;
                e6 = -8'sd56;
                e7 = 8'sd16;
            end
            4'd9: begin
                e0 = 8'sd38;
                e1 = 8'sd4;
                e2 = -8'sd48;
                e3 = -8'sd10;
                e4 = 8'sd16;
                e5 = -8'sd10;
                e6 = 8'sd63;
                e7 = 8'sd37;
            end
            4'd10: begin
                e0 = 8'sd53;
                e1 = -8'sd28;
                e2 = 8'sd3;
                e3 = -8'sd29;
                e4 = -8'sd1;
                e5 = 8'sd3;
                e6 = 8'sd45;
                e7 = 8'sd38;
            end
            4'd11: begin
                e0 = 8'sd28;
                e1 = -8'sd8;
                e2 = -8'sd29;
                e3 = 8'sd62;
                e4 = -8'sd41;
                e5 = -8'sd52;
                e6 = -8'sd36;
                e7 = -8'sd25;
            end
            4'd12: begin
                e0 = -8'sd24;
                e1 = 8'sd44;
                e2 = -8'sd48;
                e3 = 8'sd34;
                e4 = 8'sd33;
                e5 = 8'sd55;
                e6 = 8'sd0;
                e7 = -8'sd62;
            end
            4'd13: begin
                e0 = -8'sd35;
                e1 = 8'sd4;
                e2 = 8'sd23;
                e3 = -8'sd36;
                e4 = 8'sd11;
                e5 = 8'sd47;
                e6 = -8'sd24;
                e7 = 8'sd52;
            end
            4'd14: begin
                e0 = -8'sd64;
                e1 = 8'sd3;
                e2 = -8'sd19;
                e3 = -8'sd37;
                e4 = 8'sd12;
                e5 = -8'sd14;
                e6 = -8'sd25;
                e7 = 8'sd31;
            end
            4'd15: begin
                e0 = -8'sd23;
                e1 = -8'sd64;
                e2 = 8'sd18;
                e3 = 8'sd61;
                e4 = -8'sd60;
                e5 = -8'sd36;
                e6 = 8'sd28;
                e7 = 8'sd14;
            end
            default: begin
                e0=0;e1=0;e2=0;e3=0;e4=0;e5=0;e6=0;e7=0;
            end
        endcase
    end
    assign out0 = {{8{e0[7]}}, e0};
    assign out1 = {{8{e1[7]}}, e1};
    assign out2 = {{8{e2[7]}}, e2};
    assign out3 = {{8{e3[7]}}, e3};
    assign out4 = {{8{e4[7]}}, e4};
    assign out5 = {{8{e5[7]}}, e5};
    assign out6 = {{8{e6[7]}}, e6};
    assign out7 = {{8{e7[7]}}, e7};
endmodule