module lm_test;
    reg clk, reset, start;
    reg [3:0] token_id;
    reg [2:0] position;
    reg signed [7:0]  wq0,wq1,wq2,wq3,wq4,wq5,wq6,wq7;
    reg signed [7:0]  wk0,wk1,wk2,wk3,wk4,wk5,wk6,wk7;
    reg signed [7:0]  wv0,wv1,wv2,wv3,wv4,wv5,wv6,wv7;
    reg signed [7:0]  w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7;
    reg signed [15:0] b1_0,b1_1,b1_2,b1_3,b1_4,b1_5,b1_6,b1_7;
    reg signed [7:0]  w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7;
    reg signed [15:0] b2_0,b2_1,b2_2,b2_3,b2_4,b2_5,b2_6,b2_7;
    reg signed [7:0]  gamma0,gamma1,gamma2,gamma3;
    reg signed [7:0]  gamma4,gamma5,gamma6,gamma7;
    reg signed [7:0]  beta0,beta1,beta2,beta3;
    reg signed [7:0]  beta4,beta5,beta6,beta7;
    wire [3:0] next_token;
    wire signed [15:0] logit0,logit1,logit2,logit3;
    wire signed [15:0] logit4,logit5,logit6,logit7;
    wire signed [15:0] logit8,logit9,logit10,logit11;
    wire signed [15:0] logit12,logit13,logit14,logit15;
    wire done;
    reg  last_done;

    hyperion_lm lm (
        .clk(clk),.reset(reset),.start(start),
        .token_id(token_id),.position(position),
        .wq0(wq0),.wq1(wq1),.wq2(wq2),.wq3(wq3),
        .wq4(wq4),.wq5(wq5),.wq6(wq6),.wq7(wq7),
        .wk0(wk0),.wk1(wk1),.wk2(wk2),.wk3(wk3),
        .wk4(wk4),.wk5(wk5),.wk6(wk6),.wk7(wk7),
        .wv0(wv0),.wv1(wv1),.wv2(wv2),.wv3(wv3),
        .wv4(wv4),.wv5(wv5),.wv6(wv6),.wv7(wv7),
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
        .next_token(next_token),
        .logit0(logit0),.logit1(logit1),
        .logit2(logit2),.logit3(logit3),
        .logit4(logit4),.logit5(logit5),
        .logit6(logit6),.logit7(logit7),
        .logit8(logit8),.logit9(logit9),
        .logit10(logit10),.logit11(logit11),
        .logit12(logit12),.logit13(logit13),
        .logit14(logit14),.logit15(logit15),
        .done(done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (done && !last_done) begin
            $display("");
            $display("╔══════════════════════════════════════════╗");
            $display("║     HYPERION LANGUAGE MODEL — v1.6       ║");
            $display("║     Complete end-to-end LLM pipeline     ║");
            $display("╠══════════════════════════════════════════╣");
            $display("║                                          ║");
            $display("║  Input token:  %0d (position %0d)            ║", token_id, position);
            $display("║                                          ║");
            $display("║  Pipeline:                               ║");
            $display("║    token %0d → embedding → PE             ║", token_id);
            $display("║           → 12 transformer blocks        ║");
            $display("║           → output projection            ║");
            $display("║           → argmax                       ║");
            $display("║                                          ║");
            $display("║  Logits: [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]   ║",
                logit0,logit1,logit2,logit3,
                logit4,logit5,logit6,logit7);
            $display("║          [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]   ║",
                logit8,logit9,logit10,logit11,
                logit12,logit13,logit14,logit15);
            $display("║                                          ║");
            $display("║  Predicted next token: %0d                ║", next_token);
            $display("║                                          ║");
            $display("╠══════════════════════════════════════════╣");
            $display("║  Hyperion language model complete!       ║");
            $display("║  Input word → predicted next word        ║");
            $display("║  This is what GPT does. Built at age 12. ║");
            $display("╚══════════════════════════════════════════╝");
            $finish;
        end
        last_done <= done;
    end

    initial begin
        clk=0; reset=1; start=0; last_done=0;
        token_id=3; position=2;
        wq0=1;wq1=2;wq2=1;wq3=2;wq4=1;wq5=2;wq6=1;wq7=2;
        wk0=1;wk1=1;wk2=1;wk3=1;wk4=1;wk5=1;wk6=1;wk7=1;
        wv0=2;wv1=4;wv2=6;wv3=8;wv4=10;wv5=12;wv6=14;wv7=16;
        w1_0=2;w1_1=3;w1_2=1;w1_3=4;w1_4=2;w1_5=1;w1_6=3;w1_7=2;
        b1_0=5;b1_1=5;b1_2=5;b1_3=5;b1_4=5;b1_5=5;b1_6=5;b1_7=5;
        w2_0=1;w2_1=2;w2_2=1;w2_3=2;w2_4=1;w2_5=2;w2_6=1;w2_7=2;
        b2_0=0;b2_1=0;b2_2=0;b2_3=0;b2_4=0;b2_5=0;b2_6=0;b2_7=0;
        gamma0=1;gamma1=1;gamma2=1;gamma3=1;
        gamma4=1;gamma5=1;gamma6=1;gamma7=1;
        beta0=0;beta1=0;beta2=0;beta3=0;
        beta4=0;beta5=0;beta6=0;beta7=0;
        #30 reset=0; #10 start=1; #10 start=0;
        #100000;
        $display("Timeout"); $finish;
    end
endmodule
