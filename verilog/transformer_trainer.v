// ─────────────────────────────────────────
// HYPERION TRANSFORMER TRAINER
// TPU-style training loop for transformer
//
// Pipeline per training step:
//   1. Forward pass  — transformer block
//   2. Loss compute  — MSE(output, target)
//   3. Backward pass — gradient_unit
//   4. Weight update — SGD optimizer
//   5. Repeat
//
// This is what Google TPU does at scale.
// Hyperion does it for one transformer block.
// Same 4-step loop. Different scale.
// ─────────────────────────────────────────

module transformer_trainer (
    input  clk,
    input  reset,
    input  start,

    // input token embedding
    input  signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7,

    // target output (what we want the model to produce)
    input  signed [15:0] target0,target1,target2,target3,
    input  signed [15:0] target4,target5,target6,target7,

    // initial weights (attention Q weights for training demo)
    input  signed [7:0]  wq_init0,wq_init1,wq_init2,wq_init3,
    input  signed [7:0]  wq_init4,wq_init5,wq_init6,wq_init7,

    // FFN weights
    input  signed [7:0]  w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7,
    input  signed [15:0] b1_0,b1_1,b1_2,b1_3,b1_4,b1_5,b1_6,b1_7,
    input  signed [7:0]  w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7,
    input  signed [15:0] b2_0,b2_1,b2_2,b2_3,b2_4,b2_5,b2_6,b2_7,
    input  signed [7:0]  gamma0,gamma1,gamma2,gamma3,
    input  signed [7:0]  gamma4,gamma5,gamma6,gamma7,
    input  signed [7:0]  beta0,beta1,beta2,beta3,
    input  signed [7:0]  beta4,beta5,beta6,beta7,

    // training outputs
    output signed [15:0] out0,out1,out2,out3,
    output signed [15:0] out4,out5,out6,out7,
    output signed [31:0] loss,
    output signed [7:0]  wq_trained0,wq_trained1,wq_trained2,wq_trained3,
    output signed [7:0]  wq_trained4,wq_trained5,wq_trained6,wq_trained7,
    output [4:0]         step,
    output               step_done,
    output               converged
);

    // ── state machine ──
    reg [2:0] state;
    reg [6:0] cycle_count;
    reg [4:0] train_step;

    parameter IDLE     = 3'd0;
    parameter FORWARD  = 3'd1;
    parameter LOSS     = 3'd2;
    parameter BACKWARD = 3'd3;
    parameter UPDATE   = 3'd4;
    parameter DONE     = 3'd5;

    assign step      = train_step;
    assign step_done = (state == DONE);
    assign converged = (loss == 0);

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE; cycle_count <= 0; train_step <= 0;
        end else case (state)
            IDLE:     begin cycle_count<=0; if (start) state<=FORWARD; end
            FORWARD:  begin cycle_count<=cycle_count+1;
                          if (fwd_done) begin cycle_count<=0; state<=LOSS; end end
            LOSS:     begin cycle_count<=cycle_count+1;
                          if (cycle_count>=7'd5) begin cycle_count<=0; state<=BACKWARD; end end
            BACKWARD: begin cycle_count<=cycle_count+1;
                          if (bwd_done) begin cycle_count<=0; state<=UPDATE; end end
            UPDATE:   begin cycle_count<=cycle_count+1;
                          if (cycle_count>=7'd5) begin
                              cycle_count<=0; train_step<=train_step+1; state<=DONE;
                          end end
            DONE:     state <= IDLE;
        endcase
    end

    // ── trained weights (updated each step) ──
    reg signed [7:0] wq0_r,wq1_r,wq2_r,wq3_r;
    reg signed [7:0] wq4_r,wq5_r,wq6_r,wq7_r;

    always @(posedge clk) begin
        if (reset) begin
            wq0_r<=wq_init0; wq1_r<=wq_init1;
            wq2_r<=wq_init2; wq3_r<=wq_init3;
            wq4_r<=wq_init4; wq5_r<=wq_init5;
            wq6_r<=wq_init6; wq7_r<=wq_init7;
        end else if (state==BACKWARD && bwd_done) begin
            // latch gradients exactly when bwd_done fires
            // one cycle later they will be reset to 0
            ldw0 <= dw0; ldw1 <= dw1; ldw2 <= dw2; ldw3 <= dw3;
            ldw4 <= dw4; ldw5 <= dw5; ldw6 <= dw6; ldw7 <= dw7;
        end else if (state==UPDATE && cycle_count==3) begin
            // SGD: w = w - lr*grad
            // lr = 1/512 — conservative to prevent explosion
            wq0_r <= wq0_r - (ldw0>>>9);
            wq1_r <= wq1_r - (ldw1>>>9);
            wq2_r <= wq2_r - (ldw2>>>9);
            wq3_r <= wq3_r - (ldw3>>>9);
            wq4_r <= wq4_r - (ldw4>>>9);
            wq5_r <= wq5_r - (ldw5>>>9);
            wq6_r <= wq6_r - (ldw6>>>9);
            wq7_r <= wq7_r - (ldw7>>>9);
        end
    end

    assign wq_trained0 = wq0_r; assign wq_trained1 = wq1_r;
    assign wq_trained2 = wq2_r; assign wq_trained3 = wq3_r;
    assign wq_trained4 = wq4_r; assign wq_trained5 = wq5_r;
    assign wq_trained6 = wq6_r; assign wq_trained7 = wq7_r;

    // latched gradients — captured before reset clears gradient_unit
    reg signed [15:0] ldw0,ldw1,ldw2,ldw3;
    reg signed [15:0] ldw4,ldw5,ldw6,ldw7;

    // ── FORWARD PASS: transformer block ──
    wire fwd_start = (state==FORWARD && cycle_count==1);
    wire fwd_done;
    wire signed [15:0] fwd0,fwd1,fwd2,fwd3;
    wire signed [15:0] fwd4,fwd5,fwd6,fwd7;

    transformer_block fwd_block (
        .clk(clk),
        .reset(reset || state==IDLE),
        .start(fwd_start),
        .x0(x0),.x1(x1),.x2(x2),.x3(x3),
        .x4(x4),.x5(x5),.x6(x6),.x7(x7),
        .wq0(wq0_r),.wq1(wq1_r),.wq2(wq2_r),.wq3(wq3_r),
        .wq4(wq4_r),.wq5(wq5_r),.wq6(wq6_r),.wq7(wq7_r),
        .wk0(wq0_r),.wk1(wq1_r),.wk2(wq2_r),.wk3(wq3_r),
        .wk4(wq4_r),.wk5(wq5_r),.wk6(wq6_r),.wk7(wq7_r),
        .wv0(wq0_r),.wv1(wq1_r),.wv2(wq2_r),.wv3(wq3_r),
        .wv4(wq4_r),.wv5(wq5_r),.wv6(wq6_r),.wv7(wq7_r),
        .w1_0(w1_0),.w1_1(w1_1),.w1_2(w1_2),.w1_3(w1_3),
        .w1_4(w1_4),.w1_5(w1_5),.w1_6(w1_6),.w1_7(w1_7),
        .b1_0(b1_0),.b1_1(b1_1),.b1_2(b1_2),.b1_3(b1_3),
        .b1_4(b1_4),.b1_5(b1_5),.b1_6(b1_6),.b1_7(b1_7),
        .w2_0(w2_0),.w2_1(w2_1),.w2_2(w2_2),.w2_3(w2_3),
        .w2_4(w2_4),.w2_5(w2_5),.w2_6(w2_6),.w2_7(w2_7),
        .b2_0(b2_0),.b2_1(b2_1),.b2_2(b2_2),.b2_3(b2_3),
        .b2_4(b2_4),.b2_5(b2_5),.b2_6(b2_6),.b2_7(b2_7),
        .gamma0(gamma0),.gamma1(gamma1),
        .gamma2(gamma2),.gamma3(gamma3),
        .gamma4(gamma4),.gamma5(gamma5),
        .gamma6(gamma6),.gamma7(gamma7),
        .beta0(beta0),.beta1(beta1),
        .beta2(beta2),.beta3(beta3),
        .beta4(beta4),.beta5(beta5),
        .beta6(beta6),.beta7(beta7),
        .out0(fwd0),.out1(fwd1),.out2(fwd2),.out3(fwd3),
        .out4(fwd4),.out5(fwd5),.out6(fwd6),.out7(fwd7),
        .done(fwd_done)
    );

    // latch forward outputs
    reg signed [15:0] lat0,lat1,lat2,lat3;
    reg signed [15:0] lat4,lat5,lat6,lat7;

    always @(posedge clk) begin
        if (reset) begin
            lat0<=0;lat1<=0;lat2<=0;lat3<=0;
            lat4<=0;lat5<=0;lat6<=0;lat7<=0;
        end else if (fwd_done) begin
            lat0<=fwd0; lat1<=fwd1; lat2<=fwd2; lat3<=fwd3;
            lat4<=fwd4; lat5<=fwd5; lat6<=fwd6; lat7<=fwd7;
        end
    end

    assign out0=lat0; assign out1=lat1;
    assign out2=lat2; assign out3=lat3;
    assign out4=lat4; assign out5=lat5;
    assign out6=lat6; assign out7=lat7;

    // ── LOSS: MSE = sum((out-target)^2) ──
    wire signed [15:0] e0 = lat0 - target0;
    wire signed [15:0] e1 = lat1 - target1;
    wire signed [15:0] e2 = lat2 - target2;
    wire signed [15:0] e3 = lat3 - target3;
    wire signed [15:0] e4 = lat4 - target4;
    wire signed [15:0] e5 = lat5 - target5;
    wire signed [15:0] e6 = lat6 - target6;
    wire signed [15:0] e7 = lat7 - target7;

    assign loss = ($signed({{16{e0[15]}},e0})*$signed({{16{e0[15]}},e0}) +
                   $signed({{16{e1[15]}},e1})*$signed({{16{e1[15]}},e1}) +
                   $signed({{16{e2[15]}},e2})*$signed({{16{e2[15]}},e2}) +
                   $signed({{16{e3[15]}},e3})*$signed({{16{e3[15]}},e3}) +
                   $signed({{16{e4[15]}},e4})*$signed({{16{e4[15]}},e4}) +
                   $signed({{16{e5[15]}},e5})*$signed({{16{e5[15]}},e5}) +
                   $signed({{16{e6[15]}},e6})*$signed({{16{e6[15]}},e6}) +
                   $signed({{16{e7[15]}},e7})*$signed({{16{e7[15]}},e7})) >>> 8;

    // latch errors so backward pass has stable values
    reg signed [15:0] le0,le1,le2,le3,le4,le5,le6,le7;
    always @(posedge clk) begin
        if (reset) begin
            le0<=0;le1<=0;le2<=0;le3<=0;
            le4<=0;le5<=0;le6<=0;le7<=0;
        end else if (state==LOSS && cycle_count==3) begin
            le0<=e0; le1<=e1; le2<=e2; le3<=e3;
            le4<=e4; le5<=e5; le6<=e6; le7<=e7;
        end
    end

    // ── BACKWARD PASS: gradient_unit ──
    wire bwd_start = (state==BACKWARD && cycle_count==1);
    wire bwd_done;
    wire signed [15:0] dw0,dw1,dw2,dw3;
    wire signed [15:0] dw4,dw5,dw6,dw7;

    gradient_unit bwd (
        .clk(clk),
        .reset(reset || state==IDLE || state==FORWARD || state==LOSS),
        .start(bwd_start),
        .x0(x0[7:0]),.x1(x1[7:0]),.x2(x2[7:0]),.x3(x3[7:0]),
        .x4(x4[7:0]),.x5(x5[7:0]),.x6(x6[7:0]),.x7(x7[7:0]),
        .x8(x0[7:0]),.x9(x1[7:0]),.x10(x2[7:0]),.x11(x3[7:0]),
        .x12(x4[7:0]),.x13(x5[7:0]),.x14(x6[7:0]),.x15(x7[7:0]),
        .g0(le0),.g1(le1),.g2(le2),.g3(le3),
        .g4(le4),.g5(le5),.g6(le6),.g7(le7),
        .g8(le0),.g9(le1),.g10(le2),.g11(le3),
        .g12(le4),.g13(le5),.g14(le6),.g15(le7),
        .w0(wq0_r),.w1(wq1_r),.w2(wq2_r),.w3(wq3_r),
        .w4(wq4_r),.w5(wq5_r),.w6(wq6_r),.w7(wq7_r),
        .w8(wq0_r),.w9(wq1_r),.w10(wq2_r),.w11(wq3_r),
        .w12(wq4_r),.w13(wq5_r),.w14(wq6_r),.w15(wq7_r),
        .dw0(dw0),.dw1(dw1),.dw2(dw2),.dw3(dw3),
        .dw4(dw4),.dw5(dw5),.dw6(dw6),.dw7(dw7),
        .dw8(),.dw9(),.dw10(),.dw11(),
        .dw12(),.dw13(),.dw14(),.dw15(),
        .db0(),.db1(),.db2(),.db3(),
        .db4(),.db5(),.db6(),.db7(),
        .db8(),.db9(),.db10(),.db11(),
        .db12(),.db13(),.db14(),.db15(),
        .dx0(),.dx1(),.dx2(),.dx3(),
        .dx4(),.dx5(),.dx6(),.dx7(),
        .dx8(),.dx9(),.dx10(),.dx11(),
        .dx12(),.dx13(),.dx14(),.dx15(),
        .done(bwd_done)
    );

endmodule
