// HYPERION TRAINER v4 — latches dw before update
module hyperion_trainer (
    input  clk, input  reset, input  start,
    input  signed [7:0]  a0,a1,a2,a3,a4,a5,a6,a7,
    input  signed [7:0]  a8,a9,a10,a11,a12,a13,a14,a15,
    input  signed [15:0] t0,t1,t2,t3,t4,t5,t6,t7,
    input  signed [15:0] t8,t9,t10,t11,t12,t13,t14,t15,
    input  signed [7:0]  w0,w1,w2,w3,w4,w5,w6,w7,
    input  signed [7:0]  w8,w9,w10,w11,w12,w13,w14,w15,
    input  signed [15:0] bias0,bias1,bias2,bias3,
    input  signed [15:0] bias4,bias5,bias6,bias7,
    input  signed [15:0] bias8,bias9,bias10,bias11,
    input  signed [15:0] bias12,bias13,bias14,bias15,
    input  [7:0] lr_scaled,
    output signed [7:0]  w_new0,w_new1,w_new2,w_new3,
    output signed [7:0]  w_new4,w_new5,w_new6,w_new7,
    output signed [7:0]  w_new8,w_new9,w_new10,w_new11,
    output signed [7:0]  w_new12,w_new13,w_new14,w_new15,
    output signed [15:0] out0,out1,out2,out3,
    output signed [15:0] out4,out5,out6,out7,
    output signed [15:0] out8,out9,out10,out11,
    output signed [15:0] out12,out13,out14,out15,
    output signed [15:0] loss,
    output done
);
    reg [2:0] state;
    reg [6:0] cycle_count;
    parameter IDLE=0,FORWARD=1,LATCH=2,LOSS=3,BACKWARD=4,UPDATE=5,DONE=6;
    assign done = (state==DONE);

    always @(posedge clk) begin
        if (reset) begin state<=IDLE; cycle_count<=0; end
        else case (state)
            IDLE:     begin cycle_count<=0; if (start) state<=FORWARD; end
            FORWARD:  begin cycle_count<=cycle_count+1; if (fwd_done) begin cycle_count<=0; state<=LATCH; end end
            LATCH:    begin cycle_count<=cycle_count+1; if (cycle_count>=6) begin cycle_count<=0; state<=LOSS; end end
            LOSS:     begin cycle_count<=cycle_count+1; if (cycle_count>=6) begin cycle_count<=0; state<=BACKWARD; end end
            BACKWARD: begin cycle_count<=cycle_count+1; if (bwd_done) begin cycle_count<=0; state<=UPDATE; end end
            UPDATE:   begin cycle_count<=cycle_count+1; if (cycle_count>=6) begin cycle_count<=0; state<=DONE; end end
            DONE:     begin state<=IDLE; cycle_count<=0; end
        endcase
    end

    // ── forward pass ──
    wire fwd_start = (state==FORWARD && cycle_count==1);
    wire fwd_done;
    wire signed [15:0] fwd_out0,fwd_out1,fwd_out2,fwd_out3;
    wire signed [15:0] fwd_out4,fwd_out5,fwd_out6,fwd_out7;
    wire signed [15:0] fwd_out8,fwd_out9,fwd_out10,fwd_out11;
    wire signed [15:0] fwd_out12,fwd_out13,fwd_out14,fwd_out15;

    hyperion_layer fwd (
        .clk(clk),.reset(reset||state==IDLE),.start(fwd_start),
        .a0(a0),.a1(a1),.a2(a2),.a3(a3),.a4(a4),.a5(a5),.a6(a6),.a7(a7),
        .a8(a8),.a9(a9),.a10(a10),.a11(a11),.a12(a12),.a13(a13),.a14(a14),.a15(a15),
        .w0(w0),.w1(w1),.w2(w2),.w3(w3),.w4(w4),.w5(w5),.w6(w6),.w7(w7),
        .w8(w8),.w9(w9),.w10(w10),.w11(w11),.w12(w12),.w13(w13),.w14(w14),.w15(w15),
        .bias0(bias0),.bias1(bias1),.bias2(bias2),.bias3(bias3),
        .bias4(bias4),.bias5(bias5),.bias6(bias6),.bias7(bias7),
        .bias8(bias8),.bias9(bias9),.bias10(bias10),.bias11(bias11),
        .bias12(bias12),.bias13(bias13),.bias14(bias14),.bias15(bias15),
        .out0(fwd_out0),.out1(fwd_out1),.out2(fwd_out2),.out3(fwd_out3),
        .out4(fwd_out4),.out5(fwd_out5),.out6(fwd_out6),.out7(fwd_out7),
        .out8(fwd_out8),.out9(fwd_out9),.out10(fwd_out10),.out11(fwd_out11),
        .out12(fwd_out12),.out13(fwd_out13),.out14(fwd_out14),.out15(fwd_out15),
        .done(fwd_done)
    );

    // ── latch forward outputs ──
    reg signed [15:0] lat0,lat1,lat2,lat3,lat4,lat5,lat6,lat7;
    reg signed [15:0] lat8,lat9,lat10,lat11,lat12,lat13,lat14,lat15;
    always @(posedge clk) begin
        if (reset) begin
            lat0<=0;lat1<=0;lat2<=0;lat3<=0;lat4<=0;lat5<=0;lat6<=0;lat7<=0;
            lat8<=0;lat9<=0;lat10<=0;lat11<=0;lat12<=0;lat13<=0;lat14<=0;lat15<=0;
        end else if (fwd_done && state==FORWARD) begin
            lat0<=fwd_out0;lat1<=fwd_out1;lat2<=fwd_out2;lat3<=fwd_out3;
            lat4<=fwd_out4;lat5<=fwd_out5;lat6<=fwd_out6;lat7<=fwd_out7;
            lat8<=fwd_out8;lat9<=fwd_out9;lat10<=fwd_out10;lat11<=fwd_out11;
            lat12<=fwd_out12;lat13<=fwd_out13;lat14<=fwd_out14;lat15<=fwd_out15;
        end
    end
    assign out0=lat0;assign out1=lat1;assign out2=lat2;assign out3=lat3;
    assign out4=lat4;assign out5=lat5;assign out6=lat6;assign out7=lat7;
    assign out8=lat8;assign out9=lat9;assign out10=lat10;assign out11=lat11;
    assign out12=lat12;assign out13=lat13;assign out14=lat14;assign out15=lat15;

    // ── loss ──
    wire signed [15:0] err0=lat0-t0,err1=lat1-t1,err2=lat2-t2,err3=lat3-t3;
    wire signed [15:0] err4=lat4-t4,err5=lat5-t5,err6=lat6-t6,err7=lat7-t7;
    wire signed [15:0] err8=lat8-t8,err9=lat9-t9,err10=lat10-t10,err11=lat11-t11;
    wire signed [15:0] err12=lat12-t12,err13=lat13-t13,err14=lat14-t14,err15=lat15-t15;
    wire signed [31:0] loss_raw =
        err0*err0+err1*err1+err2*err2+err3*err3+
        err4*err4+err5*err5+err6*err6+err7*err7+
        err8*err8+err9*err9+err10*err10+err11*err11+
        err12*err12+err13*err13+err14*err14+err15*err15;
    assign loss = (state>=LOSS) ? loss_raw[31:16] : 16'sd0;

    // ── backward pass ──
    wire bwd_start = (state==BACKWARD && cycle_count==1);
    wire bwd_done;
    wire signed [15:0] dw0_raw,dw1_raw,dw2_raw,dw3_raw;
    wire signed [15:0] dw4_raw,dw5_raw,dw6_raw,dw7_raw;
    wire signed [15:0] dw8_raw,dw9_raw,dw10_raw,dw11_raw;
    wire signed [15:0] dw12_raw,dw13_raw,dw14_raw,dw15_raw;
    wire signed [15:0] db0,db1,db2,db3,db4,db5,db6,db7;
    wire signed [15:0] db8,db9,db10,db11,db12,db13,db14,db15;
    wire signed [15:0] dx0,dx1,dx2,dx3,dx4,dx5,dx6,dx7;
    wire signed [15:0] dx8,dx9,dx10,dx11,dx12,dx13,dx14,dx15;

    gradient_unit bwd (
        .clk(clk),.reset(reset||state==IDLE||state==FORWARD),.start(bwd_start),
        .x0(a0),.x1(a1),.x2(a2),.x3(a3),.x4(a4),.x5(a5),.x6(a6),.x7(a7),
        .x8(a8),.x9(a9),.x10(a10),.x11(a11),.x12(a12),.x13(a13),.x14(a14),.x15(a15),
        .g0(err0),.g1(err1),.g2(err2),.g3(err3),.g4(err4),.g5(err5),.g6(err6),.g7(err7),
        .g8(err8),.g9(err9),.g10(err10),.g11(err11),.g12(err12),.g13(err13),.g14(err14),.g15(err15),
        .w0(w0),.w1(w1),.w2(w2),.w3(w3),.w4(w4),.w5(w5),.w6(w6),.w7(w7),
        .w8(w8),.w9(w9),.w10(w10),.w11(w11),.w12(w12),.w13(w13),.w14(w14),.w15(w15),
        .dw0(dw0_raw),.dw1(dw1_raw),.dw2(dw2_raw),.dw3(dw3_raw),
        .dw4(dw4_raw),.dw5(dw5_raw),.dw6(dw6_raw),.dw7(dw7_raw),
        .dw8(dw8_raw),.dw9(dw9_raw),.dw10(dw10_raw),.dw11(dw11_raw),
        .dw12(dw12_raw),.dw13(dw13_raw),.dw14(dw14_raw),.dw15(dw15_raw),
        .db0(db0),.db1(db1),.db2(db2),.db3(db3),.db4(db4),.db5(db5),.db6(db6),.db7(db7),
        .db8(db8),.db9(db9),.db10(db10),.db11(db11),.db12(db12),.db13(db13),.db14(db14),.db15(db15),
        .dx0(dx0),.dx1(dx1),.dx2(dx2),.dx3(dx3),.dx4(dx4),.dx5(dx5),.dx6(dx6),.dx7(dx7),
        .dx8(dx8),.dx9(dx9),.dx10(dx10),.dx11(dx11),.dx12(dx12),.dx13(dx13),.dx14(dx14),.dx15(dx15),
        .done(bwd_done)
    );

    // ── latch dw when backward done ──
    // this is the key fix — dw resets to 0 when gradient_unit goes IDLE
    // we capture it at the exact cycle bwd_done fires
    reg signed [15:0] dw0,dw1,dw2,dw3,dw4,dw5,dw6,dw7;
    reg signed [15:0] dw8,dw9,dw10,dw11,dw12,dw13,dw14,dw15;
    always @(posedge clk) begin
        if (reset) begin
            dw0<=0;dw1<=0;dw2<=0;dw3<=0;dw4<=0;dw5<=0;dw6<=0;dw7<=0;
            dw8<=0;dw9<=0;dw10<=0;dw11<=0;dw12<=0;dw13<=0;dw14<=0;dw15<=0;
        end else if (bwd_done && state==BACKWARD) begin
            dw0<=dw0_raw;dw1<=dw1_raw;dw2<=dw2_raw;dw3<=dw3_raw;
            dw4<=dw4_raw;dw5<=dw5_raw;dw6<=dw6_raw;dw7<=dw7_raw;
            dw8<=dw8_raw;dw9<=dw9_raw;dw10<=dw10_raw;dw11<=dw11_raw;
            dw12<=dw12_raw;dw13<=dw13_raw;dw14<=dw14_raw;dw15<=dw15_raw;
        end
    end

    // ── weight update uses latched dw ──
    weight_update_unit updater (
        .clk(clk),.reset(reset),
        .enable(state==UPDATE||state==DONE),
        .lr_scaled(lr_scaled),
        .w0(w0),.w1(w1),.w2(w2),.w3(w3),.w4(w4),.w5(w5),.w6(w6),.w7(w7),
        .w8(w8),.w9(w9),.w10(w10),.w11(w11),.w12(w12),.w13(w13),.w14(w14),.w15(w15),
        .dw0(dw0),.dw1(dw1),.dw2(dw2),.dw3(dw3),.dw4(dw4),.dw5(dw5),.dw6(dw6),.dw7(dw7),
        .dw8(dw8),.dw9(dw9),.dw10(dw10),.dw11(dw11),.dw12(dw12),.dw13(dw13),.dw14(dw14),.dw15(dw15),
        .w_new0(w_new0),.w_new1(w_new1),.w_new2(w_new2),.w_new3(w_new3),
        .w_new4(w_new4),.w_new5(w_new5),.w_new6(w_new6),.w_new7(w_new7),
        .w_new8(w_new8),.w_new9(w_new9),.w_new10(w_new10),.w_new11(w_new11),
        .w_new12(w_new12),.w_new13(w_new13),.w_new14(w_new14),.w_new15(w_new15)
    );

endmodule
