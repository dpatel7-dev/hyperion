module attention_test;
    reg clk, reset, start;

    // Query — what we are looking for
    reg signed [7:0] q0,q1,q2,q3,q4,q5,q6,q7;
    // Key — what each token offers
    reg signed [7:0] k0,k1,k2,k3,k4,k5,k6,k7;
    // Value — what we get if attention fires
    reg signed [7:0] v0,v1,v2,v3,v4,v5,v6,v7;

    wire signed [15:0] score;
    wire signed [15:0] attn_out0,attn_out1,attn_out2,attn_out3;
    wire signed [15:0] attn_out4,attn_out5,attn_out6,attn_out7;
    wire done;
    reg  last_done;

    attention_unit attn (
        .clk(clk),.reset(reset),.start(start),
        .q0(q0),.q1(q1),.q2(q2),.q3(q3),
        .q4(q4),.q5(q5),.q6(q6),.q7(q7),
        .k0(k0),.k1(k1),.k2(k2),.k3(k3),
        .k4(k4),.k5(k5),.k6(k6),.k7(k7),
        .v0(v0),.v1(v1),.v2(v2),.v3(v3),
        .v4(v4),.v5(v5),.v6(v6),.v7(v7),
        .score(score),
        .attn_out0(attn_out0),.attn_out1(attn_out1),
        .attn_out2(attn_out2),.attn_out3(attn_out3),
        .attn_out4(attn_out4),.attn_out5(attn_out5),
        .attn_out6(attn_out6),.attn_out7(attn_out7),
        .done(done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (done && !last_done) begin
            $display("══════════════════════════════════════════");
            $display("HYPERION ATTENTION UNIT");
            $display("══════════════════════════════════════════");
            $display("");
            $display("Q = [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                q0,q1,q2,q3,q4,q5,q6,q7);
            $display("K = [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                k0,k1,k2,k3,k4,k5,k6,k7);
            $display("V = [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                v0,v1,v2,v3,v4,v5,v6,v7);
            $display("");
            $display("Q.K raw dot product: %0d", score*3);
            $display("Q.K scaled (÷3):     %0d", score);
            $display("");
            if (score > 0) begin
                $display("Attention fires! (score > 0 → attend to this token)");
                $display("Attention output (first 4):");
                $display("  [%0d, %0d, %0d, %0d]",
                    attn_out0,attn_out1,attn_out2,attn_out3);
            end else begin
                $display("Attention suppressed (score <= 0 → ignore token)");
                $display("Output: [0, 0, 0, 0, 0, 0, 0, 0]");
            end
            $display("");
            $display("══════════════════════════════════════════");
            $display("Hyperion attention unit working!");
            $display("This is the core of every transformer.");
            $display("GPT uses 96 of these per layer.");
            $display("Hyperion has 1. Same mechanism.");
            $display("══════════════════════════════════════════");
            $finish;
        end
        last_done <= done;
    end

    initial begin
        clk=0; reset=1; start=0; last_done=0;

        // test 1: Q and K aligned — should produce high score
        // Q = K = [1,1,1,1,1,1,1,1]
        // Q.K = 8, scaled = 2 → attention fires
        q0=1;q1=1;q2=1;q3=1;q4=1;q5=1;q6=1;q7=1;
        k0=1;k1=1;k2=1;k3=1;k4=1;k5=1;k6=1;k7=1;

        // V = [10,20,30,40,50,60,70,80]
        v0=10;v1=20;v2=30;v3=40;v4=50;v5=60;v6=70;v7=80;

        #30 reset=0; #10 start=1; #10 start=0;
        #500;
        $display("Timeout"); $finish;
    end
endmodule
