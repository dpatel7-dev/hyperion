module generation_test;
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

    // vocabulary lookup task
    task print_token;
        input [3:0] tid;
        begin
            case (tid)
                4'd0:  $write("the ");
                4'd1:  $write("cat ");
                4'd2:  $write("sat ");
                4'd3:  $write("on ");
                4'd4:  $write("mat ");
                4'd5:  $write("a ");
                4'd6:  $write("dog ");
                4'd7:  $write("ran ");
                4'd8:  $write("fast ");
                4'd9:  $write("slow ");
                4'd10: $write("big ");
                4'd11: $write("small ");
                4'd12: $write("red ");
                4'd13: $write("blue ");
                4'd14: $write("hot ");
                4'd15: $write("cold ");
            endcase
        end
    endtask

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

    integer gen_step;
    integer generating;

    always @(posedge clk) begin
        if (done && !last_done && generating) begin
            // print the generated token
            print_token(next_token);

            gen_step = gen_step + 1;
            if (gen_step < 8) begin
                // feed output back as next input — autoregressive generation
                token_id  <= next_token;
                position  <= (position < 7) ? position + 1 : 3'd7;
                reset     <= 1;
            end else begin
                $display("");
                $display("");
                $display("══════════════════════════════════════════════════════");
                $display("HYPERION GENERATED THE ABOVE TEXT FROM SCRATCH");
                $display("══════════════════════════════════════════════════════");
                $display("");
                $display("How it works — same as ChatGPT:");
                $display("  1. Input token looked up in embedding table");
                $display("  2. Position added via sinusoidal encoding");
                $display("  3. 12 transformer blocks process the vector");
                $display("  4. Output projection scores all 16 vocabulary words");
                $display("  5. Highest score = predicted next word");
                $display("  6. That word fed back as input — repeat");
                $display("");
                $display("Hyperion ran this loop 8 times in hardware.");
                $display("GPT-3 runs it up to 2,048 times per response.");
                $display("Same mechanism. Different scale.");
                $display("");
                $display("Built at age 12.");
                $display("══════════════════════════════════════════════════════");
                generating = 0;
                $finish;
            end
        end
        last_done <= done;
    end

    always @(posedge clk) begin
        if (reset) begin
            #20;
            reset <= 0;
            #10;
            start <= 1;
            #10;
            start <= 0;
        end
    end

    initial begin
        clk=0; reset=1; start=0; last_done=0;
        gen_step=0; generating=1;
        token_id=0; position=0;   // start with "the"
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

        $display("");
        $display("══════════════════════════════════════════════════════");
        $display("HYPERION LANGUAGE MODEL — TEXT GENERATION");
        $display("Autoregressive generation — same mechanism as ChatGPT");
        $display("══════════════════════════════════════════════════════");
        $display("");
        $display("Starting word: \"the\"");
        $display("Generating 8 tokens...");
        $display("");
        $write("  > the ");

        #30 reset=0; #10 start=1; #10 start=0;
        #1000000;
        $display("Timeout"); $finish;
    end
endmodule
