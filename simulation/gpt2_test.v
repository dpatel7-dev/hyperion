module gpt2_test;
    reg clk, reset, start;
    reg signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7;
    reg signed [7:0] wq0;
    reg signed [7:0] wq1;
    reg signed [7:0] wq2;
    reg signed [7:0] wq3;
    reg signed [7:0] wq4;
    reg signed [7:0] wq5;
    reg signed [7:0] wq6;
    reg signed [7:0] wq7;
    reg signed [7:0] wk0;
    reg signed [7:0] wk1;
    reg signed [7:0] wk2;
    reg signed [7:0] wk3;
    reg signed [7:0] wk4;
    reg signed [7:0] wk5;
    reg signed [7:0] wk6;
    reg signed [7:0] wk7;
    reg signed [7:0] wv0;
    reg signed [7:0] wv1;
    reg signed [7:0] wv2;
    reg signed [7:0] wv3;
    reg signed [7:0] wv4;
    reg signed [7:0] wv5;
    reg signed [7:0] wv6;
    reg signed [7:0] wv7;
    reg signed [7:0] w1_0;
    reg signed [7:0] w1_1;
    reg signed [7:0] w1_2;
    reg signed [7:0] w1_3;
    reg signed [7:0] w1_4;
    reg signed [7:0] w1_5;
    reg signed [7:0] w1_6;
    reg signed [7:0] w1_7;
    reg signed [15:0] b1_0;
    reg signed [15:0] b1_1;
    reg signed [15:0] b1_2;
    reg signed [15:0] b1_3;
    reg signed [15:0] b1_4;
    reg signed [15:0] b1_5;
    reg signed [15:0] b1_6;
    reg signed [15:0] b1_7;
    reg signed [7:0] w2_0;
    reg signed [7:0] w2_1;
    reg signed [7:0] w2_2;
    reg signed [7:0] w2_3;
    reg signed [7:0] w2_4;
    reg signed [7:0] w2_5;
    reg signed [7:0] w2_6;
    reg signed [7:0] w2_7;
    reg signed [15:0] b2_0;
    reg signed [15:0] b2_1;
    reg signed [15:0] b2_2;
    reg signed [15:0] b2_3;
    reg signed [15:0] b2_4;
    reg signed [15:0] b2_5;
    reg signed [15:0] b2_6;
    reg signed [15:0] b2_7;
    reg signed [7:0] gamma0;
    reg signed [7:0] gamma1;
    reg signed [7:0] gamma2;
    reg signed [7:0] gamma3;
    reg signed [7:0] gamma4;
    reg signed [7:0] gamma5;
    reg signed [7:0] gamma6;
    reg signed [7:0] gamma7;
    reg signed [7:0] beta0;
    reg signed [7:0] beta1;
    reg signed [7:0] beta2;
    reg signed [7:0] beta3;
    reg signed [7:0] beta4;
    reg signed [7:0] beta5;
    reg signed [7:0] beta6;
    reg signed [7:0] beta7;
    wire signed [7:0] ga_a_b1_wq0 = wq0;
    wire signed [7:0] ga_a_b1_wq1 = wq1;
    wire signed [7:0] ga_a_b1_wq2 = wq2;
    wire signed [7:0] ga_a_b1_wq3 = wq3;
    wire signed [7:0] ga_a_b1_wq4 = wq4;
    wire signed [7:0] ga_a_b1_wq5 = wq5;
    wire signed [7:0] ga_a_b1_wq6 = wq6;
    wire signed [7:0] ga_a_b1_wq7 = wq7;
    wire signed [7:0] ga_a_b1_wk0 = wk0;
    wire signed [7:0] ga_a_b1_wk1 = wk1;
    wire signed [7:0] ga_a_b1_wk2 = wk2;
    wire signed [7:0] ga_a_b1_wk3 = wk3;
    wire signed [7:0] ga_a_b1_wk4 = wk4;
    wire signed [7:0] ga_a_b1_wk5 = wk5;
    wire signed [7:0] ga_a_b1_wk6 = wk6;
    wire signed [7:0] ga_a_b1_wk7 = wk7;
    wire signed [7:0] ga_a_b1_wv0 = wv0;
    wire signed [7:0] ga_a_b1_wv1 = wv1;
    wire signed [7:0] ga_a_b1_wv2 = wv2;
    wire signed [7:0] ga_a_b1_wv3 = wv3;
    wire signed [7:0] ga_a_b1_wv4 = wv4;
    wire signed [7:0] ga_a_b1_wv5 = wv5;
    wire signed [7:0] ga_a_b1_wv6 = wv6;
    wire signed [7:0] ga_a_b1_wv7 = wv7;
    wire signed [7:0] ga_a_b1_w1_0 = w1_0;
    wire signed [7:0] ga_a_b1_w1_1 = w1_1;
    wire signed [7:0] ga_a_b1_w1_2 = w1_2;
    wire signed [7:0] ga_a_b1_w1_3 = w1_3;
    wire signed [7:0] ga_a_b1_w1_4 = w1_4;
    wire signed [7:0] ga_a_b1_w1_5 = w1_5;
    wire signed [7:0] ga_a_b1_w1_6 = w1_6;
    wire signed [7:0] ga_a_b1_w1_7 = w1_7;
    wire signed [15:0] ga_a_b1_b1_0 = b1_0;
    wire signed [15:0] ga_a_b1_b1_1 = b1_1;
    wire signed [15:0] ga_a_b1_b1_2 = b1_2;
    wire signed [15:0] ga_a_b1_b1_3 = b1_3;
    wire signed [15:0] ga_a_b1_b1_4 = b1_4;
    wire signed [15:0] ga_a_b1_b1_5 = b1_5;
    wire signed [15:0] ga_a_b1_b1_6 = b1_6;
    wire signed [15:0] ga_a_b1_b1_7 = b1_7;
    wire signed [7:0] ga_a_b1_w2_0 = w2_0;
    wire signed [7:0] ga_a_b1_w2_1 = w2_1;
    wire signed [7:0] ga_a_b1_w2_2 = w2_2;
    wire signed [7:0] ga_a_b1_w2_3 = w2_3;
    wire signed [7:0] ga_a_b1_w2_4 = w2_4;
    wire signed [7:0] ga_a_b1_w2_5 = w2_5;
    wire signed [7:0] ga_a_b1_w2_6 = w2_6;
    wire signed [7:0] ga_a_b1_w2_7 = w2_7;
    wire signed [15:0] ga_a_b1_b2_0 = b2_0;
    wire signed [15:0] ga_a_b1_b2_1 = b2_1;
    wire signed [15:0] ga_a_b1_b2_2 = b2_2;
    wire signed [15:0] ga_a_b1_b2_3 = b2_3;
    wire signed [15:0] ga_a_b1_b2_4 = b2_4;
    wire signed [15:0] ga_a_b1_b2_5 = b2_5;
    wire signed [15:0] ga_a_b1_b2_6 = b2_6;
    wire signed [15:0] ga_a_b1_b2_7 = b2_7;
    wire signed [7:0] ga_a_b1_gamma0 = gamma0;
    wire signed [7:0] ga_a_b1_gamma1 = gamma1;
    wire signed [7:0] ga_a_b1_gamma2 = gamma2;
    wire signed [7:0] ga_a_b1_gamma3 = gamma3;
    wire signed [7:0] ga_a_b1_gamma4 = gamma4;
    wire signed [7:0] ga_a_b1_gamma5 = gamma5;
    wire signed [7:0] ga_a_b1_gamma6 = gamma6;
    wire signed [7:0] ga_a_b1_gamma7 = gamma7;
    wire signed [7:0] ga_a_b1_beta0 = beta0;
    wire signed [7:0] ga_a_b1_beta1 = beta1;
    wire signed [7:0] ga_a_b1_beta2 = beta2;
    wire signed [7:0] ga_a_b1_beta3 = beta3;
    wire signed [7:0] ga_a_b1_beta4 = beta4;
    wire signed [7:0] ga_a_b1_beta5 = beta5;
    wire signed [7:0] ga_a_b1_beta6 = beta6;
    wire signed [7:0] ga_a_b1_beta7 = beta7;
    wire signed [7:0] ga_a_b2_wq0 = wq0;
    wire signed [7:0] ga_a_b2_wq1 = wq1;
    wire signed [7:0] ga_a_b2_wq2 = wq2;
    wire signed [7:0] ga_a_b2_wq3 = wq3;
    wire signed [7:0] ga_a_b2_wq4 = wq4;
    wire signed [7:0] ga_a_b2_wq5 = wq5;
    wire signed [7:0] ga_a_b2_wq6 = wq6;
    wire signed [7:0] ga_a_b2_wq7 = wq7;
    wire signed [7:0] ga_a_b2_wk0 = wk0;
    wire signed [7:0] ga_a_b2_wk1 = wk1;
    wire signed [7:0] ga_a_b2_wk2 = wk2;
    wire signed [7:0] ga_a_b2_wk3 = wk3;
    wire signed [7:0] ga_a_b2_wk4 = wk4;
    wire signed [7:0] ga_a_b2_wk5 = wk5;
    wire signed [7:0] ga_a_b2_wk6 = wk6;
    wire signed [7:0] ga_a_b2_wk7 = wk7;
    wire signed [7:0] ga_a_b2_wv0 = wv0;
    wire signed [7:0] ga_a_b2_wv1 = wv1;
    wire signed [7:0] ga_a_b2_wv2 = wv2;
    wire signed [7:0] ga_a_b2_wv3 = wv3;
    wire signed [7:0] ga_a_b2_wv4 = wv4;
    wire signed [7:0] ga_a_b2_wv5 = wv5;
    wire signed [7:0] ga_a_b2_wv6 = wv6;
    wire signed [7:0] ga_a_b2_wv7 = wv7;
    wire signed [7:0] ga_a_b2_w1_0 = w1_0;
    wire signed [7:0] ga_a_b2_w1_1 = w1_1;
    wire signed [7:0] ga_a_b2_w1_2 = w1_2;
    wire signed [7:0] ga_a_b2_w1_3 = w1_3;
    wire signed [7:0] ga_a_b2_w1_4 = w1_4;
    wire signed [7:0] ga_a_b2_w1_5 = w1_5;
    wire signed [7:0] ga_a_b2_w1_6 = w1_6;
    wire signed [7:0] ga_a_b2_w1_7 = w1_7;
    wire signed [15:0] ga_a_b2_b1_0 = b1_0;
    wire signed [15:0] ga_a_b2_b1_1 = b1_1;
    wire signed [15:0] ga_a_b2_b1_2 = b1_2;
    wire signed [15:0] ga_a_b2_b1_3 = b1_3;
    wire signed [15:0] ga_a_b2_b1_4 = b1_4;
    wire signed [15:0] ga_a_b2_b1_5 = b1_5;
    wire signed [15:0] ga_a_b2_b1_6 = b1_6;
    wire signed [15:0] ga_a_b2_b1_7 = b1_7;
    wire signed [7:0] ga_a_b2_w2_0 = w2_0;
    wire signed [7:0] ga_a_b2_w2_1 = w2_1;
    wire signed [7:0] ga_a_b2_w2_2 = w2_2;
    wire signed [7:0] ga_a_b2_w2_3 = w2_3;
    wire signed [7:0] ga_a_b2_w2_4 = w2_4;
    wire signed [7:0] ga_a_b2_w2_5 = w2_5;
    wire signed [7:0] ga_a_b2_w2_6 = w2_6;
    wire signed [7:0] ga_a_b2_w2_7 = w2_7;
    wire signed [15:0] ga_a_b2_b2_0 = b2_0;
    wire signed [15:0] ga_a_b2_b2_1 = b2_1;
    wire signed [15:0] ga_a_b2_b2_2 = b2_2;
    wire signed [15:0] ga_a_b2_b2_3 = b2_3;
    wire signed [15:0] ga_a_b2_b2_4 = b2_4;
    wire signed [15:0] ga_a_b2_b2_5 = b2_5;
    wire signed [15:0] ga_a_b2_b2_6 = b2_6;
    wire signed [15:0] ga_a_b2_b2_7 = b2_7;
    wire signed [7:0] ga_a_b2_gamma0 = gamma0;
    wire signed [7:0] ga_a_b2_gamma1 = gamma1;
    wire signed [7:0] ga_a_b2_gamma2 = gamma2;
    wire signed [7:0] ga_a_b2_gamma3 = gamma3;
    wire signed [7:0] ga_a_b2_gamma4 = gamma4;
    wire signed [7:0] ga_a_b2_gamma5 = gamma5;
    wire signed [7:0] ga_a_b2_gamma6 = gamma6;
    wire signed [7:0] ga_a_b2_gamma7 = gamma7;
    wire signed [7:0] ga_a_b2_beta0 = beta0;
    wire signed [7:0] ga_a_b2_beta1 = beta1;
    wire signed [7:0] ga_a_b2_beta2 = beta2;
    wire signed [7:0] ga_a_b2_beta3 = beta3;
    wire signed [7:0] ga_a_b2_beta4 = beta4;
    wire signed [7:0] ga_a_b2_beta5 = beta5;
    wire signed [7:0] ga_a_b2_beta6 = beta6;
    wire signed [7:0] ga_a_b2_beta7 = beta7;
    wire signed [7:0] ga_b_b1_wq0 = wq0;
    wire signed [7:0] ga_b_b1_wq1 = wq1;
    wire signed [7:0] ga_b_b1_wq2 = wq2;
    wire signed [7:0] ga_b_b1_wq3 = wq3;
    wire signed [7:0] ga_b_b1_wq4 = wq4;
    wire signed [7:0] ga_b_b1_wq5 = wq5;
    wire signed [7:0] ga_b_b1_wq6 = wq6;
    wire signed [7:0] ga_b_b1_wq7 = wq7;
    wire signed [7:0] ga_b_b1_wk0 = wk0;
    wire signed [7:0] ga_b_b1_wk1 = wk1;
    wire signed [7:0] ga_b_b1_wk2 = wk2;
    wire signed [7:0] ga_b_b1_wk3 = wk3;
    wire signed [7:0] ga_b_b1_wk4 = wk4;
    wire signed [7:0] ga_b_b1_wk5 = wk5;
    wire signed [7:0] ga_b_b1_wk6 = wk6;
    wire signed [7:0] ga_b_b1_wk7 = wk7;
    wire signed [7:0] ga_b_b1_wv0 = wv0;
    wire signed [7:0] ga_b_b1_wv1 = wv1;
    wire signed [7:0] ga_b_b1_wv2 = wv2;
    wire signed [7:0] ga_b_b1_wv3 = wv3;
    wire signed [7:0] ga_b_b1_wv4 = wv4;
    wire signed [7:0] ga_b_b1_wv5 = wv5;
    wire signed [7:0] ga_b_b1_wv6 = wv6;
    wire signed [7:0] ga_b_b1_wv7 = wv7;
    wire signed [7:0] ga_b_b1_w1_0 = w1_0;
    wire signed [7:0] ga_b_b1_w1_1 = w1_1;
    wire signed [7:0] ga_b_b1_w1_2 = w1_2;
    wire signed [7:0] ga_b_b1_w1_3 = w1_3;
    wire signed [7:0] ga_b_b1_w1_4 = w1_4;
    wire signed [7:0] ga_b_b1_w1_5 = w1_5;
    wire signed [7:0] ga_b_b1_w1_6 = w1_6;
    wire signed [7:0] ga_b_b1_w1_7 = w1_7;
    wire signed [15:0] ga_b_b1_b1_0 = b1_0;
    wire signed [15:0] ga_b_b1_b1_1 = b1_1;
    wire signed [15:0] ga_b_b1_b1_2 = b1_2;
    wire signed [15:0] ga_b_b1_b1_3 = b1_3;
    wire signed [15:0] ga_b_b1_b1_4 = b1_4;
    wire signed [15:0] ga_b_b1_b1_5 = b1_5;
    wire signed [15:0] ga_b_b1_b1_6 = b1_6;
    wire signed [15:0] ga_b_b1_b1_7 = b1_7;
    wire signed [7:0] ga_b_b1_w2_0 = w2_0;
    wire signed [7:0] ga_b_b1_w2_1 = w2_1;
    wire signed [7:0] ga_b_b1_w2_2 = w2_2;
    wire signed [7:0] ga_b_b1_w2_3 = w2_3;
    wire signed [7:0] ga_b_b1_w2_4 = w2_4;
    wire signed [7:0] ga_b_b1_w2_5 = w2_5;
    wire signed [7:0] ga_b_b1_w2_6 = w2_6;
    wire signed [7:0] ga_b_b1_w2_7 = w2_7;
    wire signed [15:0] ga_b_b1_b2_0 = b2_0;
    wire signed [15:0] ga_b_b1_b2_1 = b2_1;
    wire signed [15:0] ga_b_b1_b2_2 = b2_2;
    wire signed [15:0] ga_b_b1_b2_3 = b2_3;
    wire signed [15:0] ga_b_b1_b2_4 = b2_4;
    wire signed [15:0] ga_b_b1_b2_5 = b2_5;
    wire signed [15:0] ga_b_b1_b2_6 = b2_6;
    wire signed [15:0] ga_b_b1_b2_7 = b2_7;
    wire signed [7:0] ga_b_b1_gamma0 = gamma0;
    wire signed [7:0] ga_b_b1_gamma1 = gamma1;
    wire signed [7:0] ga_b_b1_gamma2 = gamma2;
    wire signed [7:0] ga_b_b1_gamma3 = gamma3;
    wire signed [7:0] ga_b_b1_gamma4 = gamma4;
    wire signed [7:0] ga_b_b1_gamma5 = gamma5;
    wire signed [7:0] ga_b_b1_gamma6 = gamma6;
    wire signed [7:0] ga_b_b1_gamma7 = gamma7;
    wire signed [7:0] ga_b_b1_beta0 = beta0;
    wire signed [7:0] ga_b_b1_beta1 = beta1;
    wire signed [7:0] ga_b_b1_beta2 = beta2;
    wire signed [7:0] ga_b_b1_beta3 = beta3;
    wire signed [7:0] ga_b_b1_beta4 = beta4;
    wire signed [7:0] ga_b_b1_beta5 = beta5;
    wire signed [7:0] ga_b_b1_beta6 = beta6;
    wire signed [7:0] ga_b_b1_beta7 = beta7;
    wire signed [7:0] ga_b_b2_wq0 = wq0;
    wire signed [7:0] ga_b_b2_wq1 = wq1;
    wire signed [7:0] ga_b_b2_wq2 = wq2;
    wire signed [7:0] ga_b_b2_wq3 = wq3;
    wire signed [7:0] ga_b_b2_wq4 = wq4;
    wire signed [7:0] ga_b_b2_wq5 = wq5;
    wire signed [7:0] ga_b_b2_wq6 = wq6;
    wire signed [7:0] ga_b_b2_wq7 = wq7;
    wire signed [7:0] ga_b_b2_wk0 = wk0;
    wire signed [7:0] ga_b_b2_wk1 = wk1;
    wire signed [7:0] ga_b_b2_wk2 = wk2;
    wire signed [7:0] ga_b_b2_wk3 = wk3;
    wire signed [7:0] ga_b_b2_wk4 = wk4;
    wire signed [7:0] ga_b_b2_wk5 = wk5;
    wire signed [7:0] ga_b_b2_wk6 = wk6;
    wire signed [7:0] ga_b_b2_wk7 = wk7;
    wire signed [7:0] ga_b_b2_wv0 = wv0;
    wire signed [7:0] ga_b_b2_wv1 = wv1;
    wire signed [7:0] ga_b_b2_wv2 = wv2;
    wire signed [7:0] ga_b_b2_wv3 = wv3;
    wire signed [7:0] ga_b_b2_wv4 = wv4;
    wire signed [7:0] ga_b_b2_wv5 = wv5;
    wire signed [7:0] ga_b_b2_wv6 = wv6;
    wire signed [7:0] ga_b_b2_wv7 = wv7;
    wire signed [7:0] ga_b_b2_w1_0 = w1_0;
    wire signed [7:0] ga_b_b2_w1_1 = w1_1;
    wire signed [7:0] ga_b_b2_w1_2 = w1_2;
    wire signed [7:0] ga_b_b2_w1_3 = w1_3;
    wire signed [7:0] ga_b_b2_w1_4 = w1_4;
    wire signed [7:0] ga_b_b2_w1_5 = w1_5;
    wire signed [7:0] ga_b_b2_w1_6 = w1_6;
    wire signed [7:0] ga_b_b2_w1_7 = w1_7;
    wire signed [15:0] ga_b_b2_b1_0 = b1_0;
    wire signed [15:0] ga_b_b2_b1_1 = b1_1;
    wire signed [15:0] ga_b_b2_b1_2 = b1_2;
    wire signed [15:0] ga_b_b2_b1_3 = b1_3;
    wire signed [15:0] ga_b_b2_b1_4 = b1_4;
    wire signed [15:0] ga_b_b2_b1_5 = b1_5;
    wire signed [15:0] ga_b_b2_b1_6 = b1_6;
    wire signed [15:0] ga_b_b2_b1_7 = b1_7;
    wire signed [7:0] ga_b_b2_w2_0 = w2_0;
    wire signed [7:0] ga_b_b2_w2_1 = w2_1;
    wire signed [7:0] ga_b_b2_w2_2 = w2_2;
    wire signed [7:0] ga_b_b2_w2_3 = w2_3;
    wire signed [7:0] ga_b_b2_w2_4 = w2_4;
    wire signed [7:0] ga_b_b2_w2_5 = w2_5;
    wire signed [7:0] ga_b_b2_w2_6 = w2_6;
    wire signed [7:0] ga_b_b2_w2_7 = w2_7;
    wire signed [15:0] ga_b_b2_b2_0 = b2_0;
    wire signed [15:0] ga_b_b2_b2_1 = b2_1;
    wire signed [15:0] ga_b_b2_b2_2 = b2_2;
    wire signed [15:0] ga_b_b2_b2_3 = b2_3;
    wire signed [15:0] ga_b_b2_b2_4 = b2_4;
    wire signed [15:0] ga_b_b2_b2_5 = b2_5;
    wire signed [15:0] ga_b_b2_b2_6 = b2_6;
    wire signed [15:0] ga_b_b2_b2_7 = b2_7;
    wire signed [7:0] ga_b_b2_gamma0 = gamma0;
    wire signed [7:0] ga_b_b2_gamma1 = gamma1;
    wire signed [7:0] ga_b_b2_gamma2 = gamma2;
    wire signed [7:0] ga_b_b2_gamma3 = gamma3;
    wire signed [7:0] ga_b_b2_gamma4 = gamma4;
    wire signed [7:0] ga_b_b2_gamma5 = gamma5;
    wire signed [7:0] ga_b_b2_gamma6 = gamma6;
    wire signed [7:0] ga_b_b2_gamma7 = gamma7;
    wire signed [7:0] ga_b_b2_beta0 = beta0;
    wire signed [7:0] ga_b_b2_beta1 = beta1;
    wire signed [7:0] ga_b_b2_beta2 = beta2;
    wire signed [7:0] ga_b_b2_beta3 = beta3;
    wire signed [7:0] ga_b_b2_beta4 = beta4;
    wire signed [7:0] ga_b_b2_beta5 = beta5;
    wire signed [7:0] ga_b_b2_beta6 = beta6;
    wire signed [7:0] ga_b_b2_beta7 = beta7;
    wire signed [7:0] gb_a_b1_wq0 = wq0;
    wire signed [7:0] gb_a_b1_wq1 = wq1;
    wire signed [7:0] gb_a_b1_wq2 = wq2;
    wire signed [7:0] gb_a_b1_wq3 = wq3;
    wire signed [7:0] gb_a_b1_wq4 = wq4;
    wire signed [7:0] gb_a_b1_wq5 = wq5;
    wire signed [7:0] gb_a_b1_wq6 = wq6;
    wire signed [7:0] gb_a_b1_wq7 = wq7;
    wire signed [7:0] gb_a_b1_wk0 = wk0;
    wire signed [7:0] gb_a_b1_wk1 = wk1;
    wire signed [7:0] gb_a_b1_wk2 = wk2;
    wire signed [7:0] gb_a_b1_wk3 = wk3;
    wire signed [7:0] gb_a_b1_wk4 = wk4;
    wire signed [7:0] gb_a_b1_wk5 = wk5;
    wire signed [7:0] gb_a_b1_wk6 = wk6;
    wire signed [7:0] gb_a_b1_wk7 = wk7;
    wire signed [7:0] gb_a_b1_wv0 = wv0;
    wire signed [7:0] gb_a_b1_wv1 = wv1;
    wire signed [7:0] gb_a_b1_wv2 = wv2;
    wire signed [7:0] gb_a_b1_wv3 = wv3;
    wire signed [7:0] gb_a_b1_wv4 = wv4;
    wire signed [7:0] gb_a_b1_wv5 = wv5;
    wire signed [7:0] gb_a_b1_wv6 = wv6;
    wire signed [7:0] gb_a_b1_wv7 = wv7;
    wire signed [7:0] gb_a_b1_w1_0 = w1_0;
    wire signed [7:0] gb_a_b1_w1_1 = w1_1;
    wire signed [7:0] gb_a_b1_w1_2 = w1_2;
    wire signed [7:0] gb_a_b1_w1_3 = w1_3;
    wire signed [7:0] gb_a_b1_w1_4 = w1_4;
    wire signed [7:0] gb_a_b1_w1_5 = w1_5;
    wire signed [7:0] gb_a_b1_w1_6 = w1_6;
    wire signed [7:0] gb_a_b1_w1_7 = w1_7;
    wire signed [15:0] gb_a_b1_b1_0 = b1_0;
    wire signed [15:0] gb_a_b1_b1_1 = b1_1;
    wire signed [15:0] gb_a_b1_b1_2 = b1_2;
    wire signed [15:0] gb_a_b1_b1_3 = b1_3;
    wire signed [15:0] gb_a_b1_b1_4 = b1_4;
    wire signed [15:0] gb_a_b1_b1_5 = b1_5;
    wire signed [15:0] gb_a_b1_b1_6 = b1_6;
    wire signed [15:0] gb_a_b1_b1_7 = b1_7;
    wire signed [7:0] gb_a_b1_w2_0 = w2_0;
    wire signed [7:0] gb_a_b1_w2_1 = w2_1;
    wire signed [7:0] gb_a_b1_w2_2 = w2_2;
    wire signed [7:0] gb_a_b1_w2_3 = w2_3;
    wire signed [7:0] gb_a_b1_w2_4 = w2_4;
    wire signed [7:0] gb_a_b1_w2_5 = w2_5;
    wire signed [7:0] gb_a_b1_w2_6 = w2_6;
    wire signed [7:0] gb_a_b1_w2_7 = w2_7;
    wire signed [15:0] gb_a_b1_b2_0 = b2_0;
    wire signed [15:0] gb_a_b1_b2_1 = b2_1;
    wire signed [15:0] gb_a_b1_b2_2 = b2_2;
    wire signed [15:0] gb_a_b1_b2_3 = b2_3;
    wire signed [15:0] gb_a_b1_b2_4 = b2_4;
    wire signed [15:0] gb_a_b1_b2_5 = b2_5;
    wire signed [15:0] gb_a_b1_b2_6 = b2_6;
    wire signed [15:0] gb_a_b1_b2_7 = b2_7;
    wire signed [7:0] gb_a_b1_gamma0 = gamma0;
    wire signed [7:0] gb_a_b1_gamma1 = gamma1;
    wire signed [7:0] gb_a_b1_gamma2 = gamma2;
    wire signed [7:0] gb_a_b1_gamma3 = gamma3;
    wire signed [7:0] gb_a_b1_gamma4 = gamma4;
    wire signed [7:0] gb_a_b1_gamma5 = gamma5;
    wire signed [7:0] gb_a_b1_gamma6 = gamma6;
    wire signed [7:0] gb_a_b1_gamma7 = gamma7;
    wire signed [7:0] gb_a_b1_beta0 = beta0;
    wire signed [7:0] gb_a_b1_beta1 = beta1;
    wire signed [7:0] gb_a_b1_beta2 = beta2;
    wire signed [7:0] gb_a_b1_beta3 = beta3;
    wire signed [7:0] gb_a_b1_beta4 = beta4;
    wire signed [7:0] gb_a_b1_beta5 = beta5;
    wire signed [7:0] gb_a_b1_beta6 = beta6;
    wire signed [7:0] gb_a_b1_beta7 = beta7;
    wire signed [7:0] gb_a_b2_wq0 = wq0;
    wire signed [7:0] gb_a_b2_wq1 = wq1;
    wire signed [7:0] gb_a_b2_wq2 = wq2;
    wire signed [7:0] gb_a_b2_wq3 = wq3;
    wire signed [7:0] gb_a_b2_wq4 = wq4;
    wire signed [7:0] gb_a_b2_wq5 = wq5;
    wire signed [7:0] gb_a_b2_wq6 = wq6;
    wire signed [7:0] gb_a_b2_wq7 = wq7;
    wire signed [7:0] gb_a_b2_wk0 = wk0;
    wire signed [7:0] gb_a_b2_wk1 = wk1;
    wire signed [7:0] gb_a_b2_wk2 = wk2;
    wire signed [7:0] gb_a_b2_wk3 = wk3;
    wire signed [7:0] gb_a_b2_wk4 = wk4;
    wire signed [7:0] gb_a_b2_wk5 = wk5;
    wire signed [7:0] gb_a_b2_wk6 = wk6;
    wire signed [7:0] gb_a_b2_wk7 = wk7;
    wire signed [7:0] gb_a_b2_wv0 = wv0;
    wire signed [7:0] gb_a_b2_wv1 = wv1;
    wire signed [7:0] gb_a_b2_wv2 = wv2;
    wire signed [7:0] gb_a_b2_wv3 = wv3;
    wire signed [7:0] gb_a_b2_wv4 = wv4;
    wire signed [7:0] gb_a_b2_wv5 = wv5;
    wire signed [7:0] gb_a_b2_wv6 = wv6;
    wire signed [7:0] gb_a_b2_wv7 = wv7;
    wire signed [7:0] gb_a_b2_w1_0 = w1_0;
    wire signed [7:0] gb_a_b2_w1_1 = w1_1;
    wire signed [7:0] gb_a_b2_w1_2 = w1_2;
    wire signed [7:0] gb_a_b2_w1_3 = w1_3;
    wire signed [7:0] gb_a_b2_w1_4 = w1_4;
    wire signed [7:0] gb_a_b2_w1_5 = w1_5;
    wire signed [7:0] gb_a_b2_w1_6 = w1_6;
    wire signed [7:0] gb_a_b2_w1_7 = w1_7;
    wire signed [15:0] gb_a_b2_b1_0 = b1_0;
    wire signed [15:0] gb_a_b2_b1_1 = b1_1;
    wire signed [15:0] gb_a_b2_b1_2 = b1_2;
    wire signed [15:0] gb_a_b2_b1_3 = b1_3;
    wire signed [15:0] gb_a_b2_b1_4 = b1_4;
    wire signed [15:0] gb_a_b2_b1_5 = b1_5;
    wire signed [15:0] gb_a_b2_b1_6 = b1_6;
    wire signed [15:0] gb_a_b2_b1_7 = b1_7;
    wire signed [7:0] gb_a_b2_w2_0 = w2_0;
    wire signed [7:0] gb_a_b2_w2_1 = w2_1;
    wire signed [7:0] gb_a_b2_w2_2 = w2_2;
    wire signed [7:0] gb_a_b2_w2_3 = w2_3;
    wire signed [7:0] gb_a_b2_w2_4 = w2_4;
    wire signed [7:0] gb_a_b2_w2_5 = w2_5;
    wire signed [7:0] gb_a_b2_w2_6 = w2_6;
    wire signed [7:0] gb_a_b2_w2_7 = w2_7;
    wire signed [15:0] gb_a_b2_b2_0 = b2_0;
    wire signed [15:0] gb_a_b2_b2_1 = b2_1;
    wire signed [15:0] gb_a_b2_b2_2 = b2_2;
    wire signed [15:0] gb_a_b2_b2_3 = b2_3;
    wire signed [15:0] gb_a_b2_b2_4 = b2_4;
    wire signed [15:0] gb_a_b2_b2_5 = b2_5;
    wire signed [15:0] gb_a_b2_b2_6 = b2_6;
    wire signed [15:0] gb_a_b2_b2_7 = b2_7;
    wire signed [7:0] gb_a_b2_gamma0 = gamma0;
    wire signed [7:0] gb_a_b2_gamma1 = gamma1;
    wire signed [7:0] gb_a_b2_gamma2 = gamma2;
    wire signed [7:0] gb_a_b2_gamma3 = gamma3;
    wire signed [7:0] gb_a_b2_gamma4 = gamma4;
    wire signed [7:0] gb_a_b2_gamma5 = gamma5;
    wire signed [7:0] gb_a_b2_gamma6 = gamma6;
    wire signed [7:0] gb_a_b2_gamma7 = gamma7;
    wire signed [7:0] gb_a_b2_beta0 = beta0;
    wire signed [7:0] gb_a_b2_beta1 = beta1;
    wire signed [7:0] gb_a_b2_beta2 = beta2;
    wire signed [7:0] gb_a_b2_beta3 = beta3;
    wire signed [7:0] gb_a_b2_beta4 = beta4;
    wire signed [7:0] gb_a_b2_beta5 = beta5;
    wire signed [7:0] gb_a_b2_beta6 = beta6;
    wire signed [7:0] gb_a_b2_beta7 = beta7;
    wire signed [7:0] gb_b_b1_wq0 = wq0;
    wire signed [7:0] gb_b_b1_wq1 = wq1;
    wire signed [7:0] gb_b_b1_wq2 = wq2;
    wire signed [7:0] gb_b_b1_wq3 = wq3;
    wire signed [7:0] gb_b_b1_wq4 = wq4;
    wire signed [7:0] gb_b_b1_wq5 = wq5;
    wire signed [7:0] gb_b_b1_wq6 = wq6;
    wire signed [7:0] gb_b_b1_wq7 = wq7;
    wire signed [7:0] gb_b_b1_wk0 = wk0;
    wire signed [7:0] gb_b_b1_wk1 = wk1;
    wire signed [7:0] gb_b_b1_wk2 = wk2;
    wire signed [7:0] gb_b_b1_wk3 = wk3;
    wire signed [7:0] gb_b_b1_wk4 = wk4;
    wire signed [7:0] gb_b_b1_wk5 = wk5;
    wire signed [7:0] gb_b_b1_wk6 = wk6;
    wire signed [7:0] gb_b_b1_wk7 = wk7;
    wire signed [7:0] gb_b_b1_wv0 = wv0;
    wire signed [7:0] gb_b_b1_wv1 = wv1;
    wire signed [7:0] gb_b_b1_wv2 = wv2;
    wire signed [7:0] gb_b_b1_wv3 = wv3;
    wire signed [7:0] gb_b_b1_wv4 = wv4;
    wire signed [7:0] gb_b_b1_wv5 = wv5;
    wire signed [7:0] gb_b_b1_wv6 = wv6;
    wire signed [7:0] gb_b_b1_wv7 = wv7;
    wire signed [7:0] gb_b_b1_w1_0 = w1_0;
    wire signed [7:0] gb_b_b1_w1_1 = w1_1;
    wire signed [7:0] gb_b_b1_w1_2 = w1_2;
    wire signed [7:0] gb_b_b1_w1_3 = w1_3;
    wire signed [7:0] gb_b_b1_w1_4 = w1_4;
    wire signed [7:0] gb_b_b1_w1_5 = w1_5;
    wire signed [7:0] gb_b_b1_w1_6 = w1_6;
    wire signed [7:0] gb_b_b1_w1_7 = w1_7;
    wire signed [15:0] gb_b_b1_b1_0 = b1_0;
    wire signed [15:0] gb_b_b1_b1_1 = b1_1;
    wire signed [15:0] gb_b_b1_b1_2 = b1_2;
    wire signed [15:0] gb_b_b1_b1_3 = b1_3;
    wire signed [15:0] gb_b_b1_b1_4 = b1_4;
    wire signed [15:0] gb_b_b1_b1_5 = b1_5;
    wire signed [15:0] gb_b_b1_b1_6 = b1_6;
    wire signed [15:0] gb_b_b1_b1_7 = b1_7;
    wire signed [7:0] gb_b_b1_w2_0 = w2_0;
    wire signed [7:0] gb_b_b1_w2_1 = w2_1;
    wire signed [7:0] gb_b_b1_w2_2 = w2_2;
    wire signed [7:0] gb_b_b1_w2_3 = w2_3;
    wire signed [7:0] gb_b_b1_w2_4 = w2_4;
    wire signed [7:0] gb_b_b1_w2_5 = w2_5;
    wire signed [7:0] gb_b_b1_w2_6 = w2_6;
    wire signed [7:0] gb_b_b1_w2_7 = w2_7;
    wire signed [15:0] gb_b_b1_b2_0 = b2_0;
    wire signed [15:0] gb_b_b1_b2_1 = b2_1;
    wire signed [15:0] gb_b_b1_b2_2 = b2_2;
    wire signed [15:0] gb_b_b1_b2_3 = b2_3;
    wire signed [15:0] gb_b_b1_b2_4 = b2_4;
    wire signed [15:0] gb_b_b1_b2_5 = b2_5;
    wire signed [15:0] gb_b_b1_b2_6 = b2_6;
    wire signed [15:0] gb_b_b1_b2_7 = b2_7;
    wire signed [7:0] gb_b_b1_gamma0 = gamma0;
    wire signed [7:0] gb_b_b1_gamma1 = gamma1;
    wire signed [7:0] gb_b_b1_gamma2 = gamma2;
    wire signed [7:0] gb_b_b1_gamma3 = gamma3;
    wire signed [7:0] gb_b_b1_gamma4 = gamma4;
    wire signed [7:0] gb_b_b1_gamma5 = gamma5;
    wire signed [7:0] gb_b_b1_gamma6 = gamma6;
    wire signed [7:0] gb_b_b1_gamma7 = gamma7;
    wire signed [7:0] gb_b_b1_beta0 = beta0;
    wire signed [7:0] gb_b_b1_beta1 = beta1;
    wire signed [7:0] gb_b_b1_beta2 = beta2;
    wire signed [7:0] gb_b_b1_beta3 = beta3;
    wire signed [7:0] gb_b_b1_beta4 = beta4;
    wire signed [7:0] gb_b_b1_beta5 = beta5;
    wire signed [7:0] gb_b_b1_beta6 = beta6;
    wire signed [7:0] gb_b_b1_beta7 = beta7;
    wire signed [7:0] gb_b_b2_wq0 = wq0;
    wire signed [7:0] gb_b_b2_wq1 = wq1;
    wire signed [7:0] gb_b_b2_wq2 = wq2;
    wire signed [7:0] gb_b_b2_wq3 = wq3;
    wire signed [7:0] gb_b_b2_wq4 = wq4;
    wire signed [7:0] gb_b_b2_wq5 = wq5;
    wire signed [7:0] gb_b_b2_wq6 = wq6;
    wire signed [7:0] gb_b_b2_wq7 = wq7;
    wire signed [7:0] gb_b_b2_wk0 = wk0;
    wire signed [7:0] gb_b_b2_wk1 = wk1;
    wire signed [7:0] gb_b_b2_wk2 = wk2;
    wire signed [7:0] gb_b_b2_wk3 = wk3;
    wire signed [7:0] gb_b_b2_wk4 = wk4;
    wire signed [7:0] gb_b_b2_wk5 = wk5;
    wire signed [7:0] gb_b_b2_wk6 = wk6;
    wire signed [7:0] gb_b_b2_wk7 = wk7;
    wire signed [7:0] gb_b_b2_wv0 = wv0;
    wire signed [7:0] gb_b_b2_wv1 = wv1;
    wire signed [7:0] gb_b_b2_wv2 = wv2;
    wire signed [7:0] gb_b_b2_wv3 = wv3;
    wire signed [7:0] gb_b_b2_wv4 = wv4;
    wire signed [7:0] gb_b_b2_wv5 = wv5;
    wire signed [7:0] gb_b_b2_wv6 = wv6;
    wire signed [7:0] gb_b_b2_wv7 = wv7;
    wire signed [7:0] gb_b_b2_w1_0 = w1_0;
    wire signed [7:0] gb_b_b2_w1_1 = w1_1;
    wire signed [7:0] gb_b_b2_w1_2 = w1_2;
    wire signed [7:0] gb_b_b2_w1_3 = w1_3;
    wire signed [7:0] gb_b_b2_w1_4 = w1_4;
    wire signed [7:0] gb_b_b2_w1_5 = w1_5;
    wire signed [7:0] gb_b_b2_w1_6 = w1_6;
    wire signed [7:0] gb_b_b2_w1_7 = w1_7;
    wire signed [15:0] gb_b_b2_b1_0 = b1_0;
    wire signed [15:0] gb_b_b2_b1_1 = b1_1;
    wire signed [15:0] gb_b_b2_b1_2 = b1_2;
    wire signed [15:0] gb_b_b2_b1_3 = b1_3;
    wire signed [15:0] gb_b_b2_b1_4 = b1_4;
    wire signed [15:0] gb_b_b2_b1_5 = b1_5;
    wire signed [15:0] gb_b_b2_b1_6 = b1_6;
    wire signed [15:0] gb_b_b2_b1_7 = b1_7;
    wire signed [7:0] gb_b_b2_w2_0 = w2_0;
    wire signed [7:0] gb_b_b2_w2_1 = w2_1;
    wire signed [7:0] gb_b_b2_w2_2 = w2_2;
    wire signed [7:0] gb_b_b2_w2_3 = w2_3;
    wire signed [7:0] gb_b_b2_w2_4 = w2_4;
    wire signed [7:0] gb_b_b2_w2_5 = w2_5;
    wire signed [7:0] gb_b_b2_w2_6 = w2_6;
    wire signed [7:0] gb_b_b2_w2_7 = w2_7;
    wire signed [15:0] gb_b_b2_b2_0 = b2_0;
    wire signed [15:0] gb_b_b2_b2_1 = b2_1;
    wire signed [15:0] gb_b_b2_b2_2 = b2_2;
    wire signed [15:0] gb_b_b2_b2_3 = b2_3;
    wire signed [15:0] gb_b_b2_b2_4 = b2_4;
    wire signed [15:0] gb_b_b2_b2_5 = b2_5;
    wire signed [15:0] gb_b_b2_b2_6 = b2_6;
    wire signed [15:0] gb_b_b2_b2_7 = b2_7;
    wire signed [7:0] gb_b_b2_gamma0 = gamma0;
    wire signed [7:0] gb_b_b2_gamma1 = gamma1;
    wire signed [7:0] gb_b_b2_gamma2 = gamma2;
    wire signed [7:0] gb_b_b2_gamma3 = gamma3;
    wire signed [7:0] gb_b_b2_gamma4 = gamma4;
    wire signed [7:0] gb_b_b2_gamma5 = gamma5;
    wire signed [7:0] gb_b_b2_gamma6 = gamma6;
    wire signed [7:0] gb_b_b2_gamma7 = gamma7;
    wire signed [7:0] gb_b_b2_beta0 = beta0;
    wire signed [7:0] gb_b_b2_beta1 = beta1;
    wire signed [7:0] gb_b_b2_beta2 = beta2;
    wire signed [7:0] gb_b_b2_beta3 = beta3;
    wire signed [7:0] gb_b_b2_beta4 = beta4;
    wire signed [7:0] gb_b_b2_beta5 = beta5;
    wire signed [7:0] gb_b_b2_beta6 = beta6;
    wire signed [7:0] gb_b_b2_beta7 = beta7;
    wire signed [7:0] gc_a_b1_wq0 = wq0;
    wire signed [7:0] gc_a_b1_wq1 = wq1;
    wire signed [7:0] gc_a_b1_wq2 = wq2;
    wire signed [7:0] gc_a_b1_wq3 = wq3;
    wire signed [7:0] gc_a_b1_wq4 = wq4;
    wire signed [7:0] gc_a_b1_wq5 = wq5;
    wire signed [7:0] gc_a_b1_wq6 = wq6;
    wire signed [7:0] gc_a_b1_wq7 = wq7;
    wire signed [7:0] gc_a_b1_wk0 = wk0;
    wire signed [7:0] gc_a_b1_wk1 = wk1;
    wire signed [7:0] gc_a_b1_wk2 = wk2;
    wire signed [7:0] gc_a_b1_wk3 = wk3;
    wire signed [7:0] gc_a_b1_wk4 = wk4;
    wire signed [7:0] gc_a_b1_wk5 = wk5;
    wire signed [7:0] gc_a_b1_wk6 = wk6;
    wire signed [7:0] gc_a_b1_wk7 = wk7;
    wire signed [7:0] gc_a_b1_wv0 = wv0;
    wire signed [7:0] gc_a_b1_wv1 = wv1;
    wire signed [7:0] gc_a_b1_wv2 = wv2;
    wire signed [7:0] gc_a_b1_wv3 = wv3;
    wire signed [7:0] gc_a_b1_wv4 = wv4;
    wire signed [7:0] gc_a_b1_wv5 = wv5;
    wire signed [7:0] gc_a_b1_wv6 = wv6;
    wire signed [7:0] gc_a_b1_wv7 = wv7;
    wire signed [7:0] gc_a_b1_w1_0 = w1_0;
    wire signed [7:0] gc_a_b1_w1_1 = w1_1;
    wire signed [7:0] gc_a_b1_w1_2 = w1_2;
    wire signed [7:0] gc_a_b1_w1_3 = w1_3;
    wire signed [7:0] gc_a_b1_w1_4 = w1_4;
    wire signed [7:0] gc_a_b1_w1_5 = w1_5;
    wire signed [7:0] gc_a_b1_w1_6 = w1_6;
    wire signed [7:0] gc_a_b1_w1_7 = w1_7;
    wire signed [15:0] gc_a_b1_b1_0 = b1_0;
    wire signed [15:0] gc_a_b1_b1_1 = b1_1;
    wire signed [15:0] gc_a_b1_b1_2 = b1_2;
    wire signed [15:0] gc_a_b1_b1_3 = b1_3;
    wire signed [15:0] gc_a_b1_b1_4 = b1_4;
    wire signed [15:0] gc_a_b1_b1_5 = b1_5;
    wire signed [15:0] gc_a_b1_b1_6 = b1_6;
    wire signed [15:0] gc_a_b1_b1_7 = b1_7;
    wire signed [7:0] gc_a_b1_w2_0 = w2_0;
    wire signed [7:0] gc_a_b1_w2_1 = w2_1;
    wire signed [7:0] gc_a_b1_w2_2 = w2_2;
    wire signed [7:0] gc_a_b1_w2_3 = w2_3;
    wire signed [7:0] gc_a_b1_w2_4 = w2_4;
    wire signed [7:0] gc_a_b1_w2_5 = w2_5;
    wire signed [7:0] gc_a_b1_w2_6 = w2_6;
    wire signed [7:0] gc_a_b1_w2_7 = w2_7;
    wire signed [15:0] gc_a_b1_b2_0 = b2_0;
    wire signed [15:0] gc_a_b1_b2_1 = b2_1;
    wire signed [15:0] gc_a_b1_b2_2 = b2_2;
    wire signed [15:0] gc_a_b1_b2_3 = b2_3;
    wire signed [15:0] gc_a_b1_b2_4 = b2_4;
    wire signed [15:0] gc_a_b1_b2_5 = b2_5;
    wire signed [15:0] gc_a_b1_b2_6 = b2_6;
    wire signed [15:0] gc_a_b1_b2_7 = b2_7;
    wire signed [7:0] gc_a_b1_gamma0 = gamma0;
    wire signed [7:0] gc_a_b1_gamma1 = gamma1;
    wire signed [7:0] gc_a_b1_gamma2 = gamma2;
    wire signed [7:0] gc_a_b1_gamma3 = gamma3;
    wire signed [7:0] gc_a_b1_gamma4 = gamma4;
    wire signed [7:0] gc_a_b1_gamma5 = gamma5;
    wire signed [7:0] gc_a_b1_gamma6 = gamma6;
    wire signed [7:0] gc_a_b1_gamma7 = gamma7;
    wire signed [7:0] gc_a_b1_beta0 = beta0;
    wire signed [7:0] gc_a_b1_beta1 = beta1;
    wire signed [7:0] gc_a_b1_beta2 = beta2;
    wire signed [7:0] gc_a_b1_beta3 = beta3;
    wire signed [7:0] gc_a_b1_beta4 = beta4;
    wire signed [7:0] gc_a_b1_beta5 = beta5;
    wire signed [7:0] gc_a_b1_beta6 = beta6;
    wire signed [7:0] gc_a_b1_beta7 = beta7;
    wire signed [7:0] gc_a_b2_wq0 = wq0;
    wire signed [7:0] gc_a_b2_wq1 = wq1;
    wire signed [7:0] gc_a_b2_wq2 = wq2;
    wire signed [7:0] gc_a_b2_wq3 = wq3;
    wire signed [7:0] gc_a_b2_wq4 = wq4;
    wire signed [7:0] gc_a_b2_wq5 = wq5;
    wire signed [7:0] gc_a_b2_wq6 = wq6;
    wire signed [7:0] gc_a_b2_wq7 = wq7;
    wire signed [7:0] gc_a_b2_wk0 = wk0;
    wire signed [7:0] gc_a_b2_wk1 = wk1;
    wire signed [7:0] gc_a_b2_wk2 = wk2;
    wire signed [7:0] gc_a_b2_wk3 = wk3;
    wire signed [7:0] gc_a_b2_wk4 = wk4;
    wire signed [7:0] gc_a_b2_wk5 = wk5;
    wire signed [7:0] gc_a_b2_wk6 = wk6;
    wire signed [7:0] gc_a_b2_wk7 = wk7;
    wire signed [7:0] gc_a_b2_wv0 = wv0;
    wire signed [7:0] gc_a_b2_wv1 = wv1;
    wire signed [7:0] gc_a_b2_wv2 = wv2;
    wire signed [7:0] gc_a_b2_wv3 = wv3;
    wire signed [7:0] gc_a_b2_wv4 = wv4;
    wire signed [7:0] gc_a_b2_wv5 = wv5;
    wire signed [7:0] gc_a_b2_wv6 = wv6;
    wire signed [7:0] gc_a_b2_wv7 = wv7;
    wire signed [7:0] gc_a_b2_w1_0 = w1_0;
    wire signed [7:0] gc_a_b2_w1_1 = w1_1;
    wire signed [7:0] gc_a_b2_w1_2 = w1_2;
    wire signed [7:0] gc_a_b2_w1_3 = w1_3;
    wire signed [7:0] gc_a_b2_w1_4 = w1_4;
    wire signed [7:0] gc_a_b2_w1_5 = w1_5;
    wire signed [7:0] gc_a_b2_w1_6 = w1_6;
    wire signed [7:0] gc_a_b2_w1_7 = w1_7;
    wire signed [15:0] gc_a_b2_b1_0 = b1_0;
    wire signed [15:0] gc_a_b2_b1_1 = b1_1;
    wire signed [15:0] gc_a_b2_b1_2 = b1_2;
    wire signed [15:0] gc_a_b2_b1_3 = b1_3;
    wire signed [15:0] gc_a_b2_b1_4 = b1_4;
    wire signed [15:0] gc_a_b2_b1_5 = b1_5;
    wire signed [15:0] gc_a_b2_b1_6 = b1_6;
    wire signed [15:0] gc_a_b2_b1_7 = b1_7;
    wire signed [7:0] gc_a_b2_w2_0 = w2_0;
    wire signed [7:0] gc_a_b2_w2_1 = w2_1;
    wire signed [7:0] gc_a_b2_w2_2 = w2_2;
    wire signed [7:0] gc_a_b2_w2_3 = w2_3;
    wire signed [7:0] gc_a_b2_w2_4 = w2_4;
    wire signed [7:0] gc_a_b2_w2_5 = w2_5;
    wire signed [7:0] gc_a_b2_w2_6 = w2_6;
    wire signed [7:0] gc_a_b2_w2_7 = w2_7;
    wire signed [15:0] gc_a_b2_b2_0 = b2_0;
    wire signed [15:0] gc_a_b2_b2_1 = b2_1;
    wire signed [15:0] gc_a_b2_b2_2 = b2_2;
    wire signed [15:0] gc_a_b2_b2_3 = b2_3;
    wire signed [15:0] gc_a_b2_b2_4 = b2_4;
    wire signed [15:0] gc_a_b2_b2_5 = b2_5;
    wire signed [15:0] gc_a_b2_b2_6 = b2_6;
    wire signed [15:0] gc_a_b2_b2_7 = b2_7;
    wire signed [7:0] gc_a_b2_gamma0 = gamma0;
    wire signed [7:0] gc_a_b2_gamma1 = gamma1;
    wire signed [7:0] gc_a_b2_gamma2 = gamma2;
    wire signed [7:0] gc_a_b2_gamma3 = gamma3;
    wire signed [7:0] gc_a_b2_gamma4 = gamma4;
    wire signed [7:0] gc_a_b2_gamma5 = gamma5;
    wire signed [7:0] gc_a_b2_gamma6 = gamma6;
    wire signed [7:0] gc_a_b2_gamma7 = gamma7;
    wire signed [7:0] gc_a_b2_beta0 = beta0;
    wire signed [7:0] gc_a_b2_beta1 = beta1;
    wire signed [7:0] gc_a_b2_beta2 = beta2;
    wire signed [7:0] gc_a_b2_beta3 = beta3;
    wire signed [7:0] gc_a_b2_beta4 = beta4;
    wire signed [7:0] gc_a_b2_beta5 = beta5;
    wire signed [7:0] gc_a_b2_beta6 = beta6;
    wire signed [7:0] gc_a_b2_beta7 = beta7;
    wire signed [7:0] gc_b_b1_wq0 = wq0;
    wire signed [7:0] gc_b_b1_wq1 = wq1;
    wire signed [7:0] gc_b_b1_wq2 = wq2;
    wire signed [7:0] gc_b_b1_wq3 = wq3;
    wire signed [7:0] gc_b_b1_wq4 = wq4;
    wire signed [7:0] gc_b_b1_wq5 = wq5;
    wire signed [7:0] gc_b_b1_wq6 = wq6;
    wire signed [7:0] gc_b_b1_wq7 = wq7;
    wire signed [7:0] gc_b_b1_wk0 = wk0;
    wire signed [7:0] gc_b_b1_wk1 = wk1;
    wire signed [7:0] gc_b_b1_wk2 = wk2;
    wire signed [7:0] gc_b_b1_wk3 = wk3;
    wire signed [7:0] gc_b_b1_wk4 = wk4;
    wire signed [7:0] gc_b_b1_wk5 = wk5;
    wire signed [7:0] gc_b_b1_wk6 = wk6;
    wire signed [7:0] gc_b_b1_wk7 = wk7;
    wire signed [7:0] gc_b_b1_wv0 = wv0;
    wire signed [7:0] gc_b_b1_wv1 = wv1;
    wire signed [7:0] gc_b_b1_wv2 = wv2;
    wire signed [7:0] gc_b_b1_wv3 = wv3;
    wire signed [7:0] gc_b_b1_wv4 = wv4;
    wire signed [7:0] gc_b_b1_wv5 = wv5;
    wire signed [7:0] gc_b_b1_wv6 = wv6;
    wire signed [7:0] gc_b_b1_wv7 = wv7;
    wire signed [7:0] gc_b_b1_w1_0 = w1_0;
    wire signed [7:0] gc_b_b1_w1_1 = w1_1;
    wire signed [7:0] gc_b_b1_w1_2 = w1_2;
    wire signed [7:0] gc_b_b1_w1_3 = w1_3;
    wire signed [7:0] gc_b_b1_w1_4 = w1_4;
    wire signed [7:0] gc_b_b1_w1_5 = w1_5;
    wire signed [7:0] gc_b_b1_w1_6 = w1_6;
    wire signed [7:0] gc_b_b1_w1_7 = w1_7;
    wire signed [15:0] gc_b_b1_b1_0 = b1_0;
    wire signed [15:0] gc_b_b1_b1_1 = b1_1;
    wire signed [15:0] gc_b_b1_b1_2 = b1_2;
    wire signed [15:0] gc_b_b1_b1_3 = b1_3;
    wire signed [15:0] gc_b_b1_b1_4 = b1_4;
    wire signed [15:0] gc_b_b1_b1_5 = b1_5;
    wire signed [15:0] gc_b_b1_b1_6 = b1_6;
    wire signed [15:0] gc_b_b1_b1_7 = b1_7;
    wire signed [7:0] gc_b_b1_w2_0 = w2_0;
    wire signed [7:0] gc_b_b1_w2_1 = w2_1;
    wire signed [7:0] gc_b_b1_w2_2 = w2_2;
    wire signed [7:0] gc_b_b1_w2_3 = w2_3;
    wire signed [7:0] gc_b_b1_w2_4 = w2_4;
    wire signed [7:0] gc_b_b1_w2_5 = w2_5;
    wire signed [7:0] gc_b_b1_w2_6 = w2_6;
    wire signed [7:0] gc_b_b1_w2_7 = w2_7;
    wire signed [15:0] gc_b_b1_b2_0 = b2_0;
    wire signed [15:0] gc_b_b1_b2_1 = b2_1;
    wire signed [15:0] gc_b_b1_b2_2 = b2_2;
    wire signed [15:0] gc_b_b1_b2_3 = b2_3;
    wire signed [15:0] gc_b_b1_b2_4 = b2_4;
    wire signed [15:0] gc_b_b1_b2_5 = b2_5;
    wire signed [15:0] gc_b_b1_b2_6 = b2_6;
    wire signed [15:0] gc_b_b1_b2_7 = b2_7;
    wire signed [7:0] gc_b_b1_gamma0 = gamma0;
    wire signed [7:0] gc_b_b1_gamma1 = gamma1;
    wire signed [7:0] gc_b_b1_gamma2 = gamma2;
    wire signed [7:0] gc_b_b1_gamma3 = gamma3;
    wire signed [7:0] gc_b_b1_gamma4 = gamma4;
    wire signed [7:0] gc_b_b1_gamma5 = gamma5;
    wire signed [7:0] gc_b_b1_gamma6 = gamma6;
    wire signed [7:0] gc_b_b1_gamma7 = gamma7;
    wire signed [7:0] gc_b_b1_beta0 = beta0;
    wire signed [7:0] gc_b_b1_beta1 = beta1;
    wire signed [7:0] gc_b_b1_beta2 = beta2;
    wire signed [7:0] gc_b_b1_beta3 = beta3;
    wire signed [7:0] gc_b_b1_beta4 = beta4;
    wire signed [7:0] gc_b_b1_beta5 = beta5;
    wire signed [7:0] gc_b_b1_beta6 = beta6;
    wire signed [7:0] gc_b_b1_beta7 = beta7;
    wire signed [7:0] gc_b_b2_wq0 = wq0;
    wire signed [7:0] gc_b_b2_wq1 = wq1;
    wire signed [7:0] gc_b_b2_wq2 = wq2;
    wire signed [7:0] gc_b_b2_wq3 = wq3;
    wire signed [7:0] gc_b_b2_wq4 = wq4;
    wire signed [7:0] gc_b_b2_wq5 = wq5;
    wire signed [7:0] gc_b_b2_wq6 = wq6;
    wire signed [7:0] gc_b_b2_wq7 = wq7;
    wire signed [7:0] gc_b_b2_wk0 = wk0;
    wire signed [7:0] gc_b_b2_wk1 = wk1;
    wire signed [7:0] gc_b_b2_wk2 = wk2;
    wire signed [7:0] gc_b_b2_wk3 = wk3;
    wire signed [7:0] gc_b_b2_wk4 = wk4;
    wire signed [7:0] gc_b_b2_wk5 = wk5;
    wire signed [7:0] gc_b_b2_wk6 = wk6;
    wire signed [7:0] gc_b_b2_wk7 = wk7;
    wire signed [7:0] gc_b_b2_wv0 = wv0;
    wire signed [7:0] gc_b_b2_wv1 = wv1;
    wire signed [7:0] gc_b_b2_wv2 = wv2;
    wire signed [7:0] gc_b_b2_wv3 = wv3;
    wire signed [7:0] gc_b_b2_wv4 = wv4;
    wire signed [7:0] gc_b_b2_wv5 = wv5;
    wire signed [7:0] gc_b_b2_wv6 = wv6;
    wire signed [7:0] gc_b_b2_wv7 = wv7;
    wire signed [7:0] gc_b_b2_w1_0 = w1_0;
    wire signed [7:0] gc_b_b2_w1_1 = w1_1;
    wire signed [7:0] gc_b_b2_w1_2 = w1_2;
    wire signed [7:0] gc_b_b2_w1_3 = w1_3;
    wire signed [7:0] gc_b_b2_w1_4 = w1_4;
    wire signed [7:0] gc_b_b2_w1_5 = w1_5;
    wire signed [7:0] gc_b_b2_w1_6 = w1_6;
    wire signed [7:0] gc_b_b2_w1_7 = w1_7;
    wire signed [15:0] gc_b_b2_b1_0 = b1_0;
    wire signed [15:0] gc_b_b2_b1_1 = b1_1;
    wire signed [15:0] gc_b_b2_b1_2 = b1_2;
    wire signed [15:0] gc_b_b2_b1_3 = b1_3;
    wire signed [15:0] gc_b_b2_b1_4 = b1_4;
    wire signed [15:0] gc_b_b2_b1_5 = b1_5;
    wire signed [15:0] gc_b_b2_b1_6 = b1_6;
    wire signed [15:0] gc_b_b2_b1_7 = b1_7;
    wire signed [7:0] gc_b_b2_w2_0 = w2_0;
    wire signed [7:0] gc_b_b2_w2_1 = w2_1;
    wire signed [7:0] gc_b_b2_w2_2 = w2_2;
    wire signed [7:0] gc_b_b2_w2_3 = w2_3;
    wire signed [7:0] gc_b_b2_w2_4 = w2_4;
    wire signed [7:0] gc_b_b2_w2_5 = w2_5;
    wire signed [7:0] gc_b_b2_w2_6 = w2_6;
    wire signed [7:0] gc_b_b2_w2_7 = w2_7;
    wire signed [15:0] gc_b_b2_b2_0 = b2_0;
    wire signed [15:0] gc_b_b2_b2_1 = b2_1;
    wire signed [15:0] gc_b_b2_b2_2 = b2_2;
    wire signed [15:0] gc_b_b2_b2_3 = b2_3;
    wire signed [15:0] gc_b_b2_b2_4 = b2_4;
    wire signed [15:0] gc_b_b2_b2_5 = b2_5;
    wire signed [15:0] gc_b_b2_b2_6 = b2_6;
    wire signed [15:0] gc_b_b2_b2_7 = b2_7;
    wire signed [7:0] gc_b_b2_gamma0 = gamma0;
    wire signed [7:0] gc_b_b2_gamma1 = gamma1;
    wire signed [7:0] gc_b_b2_gamma2 = gamma2;
    wire signed [7:0] gc_b_b2_gamma3 = gamma3;
    wire signed [7:0] gc_b_b2_gamma4 = gamma4;
    wire signed [7:0] gc_b_b2_gamma5 = gamma5;
    wire signed [7:0] gc_b_b2_gamma6 = gamma6;
    wire signed [7:0] gc_b_b2_gamma7 = gamma7;
    wire signed [7:0] gc_b_b2_beta0 = beta0;
    wire signed [7:0] gc_b_b2_beta1 = beta1;
    wire signed [7:0] gc_b_b2_beta2 = beta2;
    wire signed [7:0] gc_b_b2_beta3 = beta3;
    wire signed [7:0] gc_b_b2_beta4 = beta4;
    wire signed [7:0] gc_b_b2_beta5 = beta5;
    wire signed [7:0] gc_b_b2_beta6 = beta6;
    wire signed [7:0] gc_b_b2_beta7 = beta7;
    wire signed [15:0] out0,out1,out2,out3,out4,out5,out6,out7;
    wire blocks4_done, blocks8_done, done;
    reg  last_4, last_8, last_done;

    transformer_gpt2 gpt2 (
        .clk(clk),.reset(reset),.start(start),
        .x0(x0),
        .x1(x1),
        .x2(x2),
        .x3(x3),
        .x4(x4),
        .x5(x5),
        .x6(x6),
        .x7(x7),
        .ga_a_b1_wq0(ga_a_b1_wq0),
        .ga_a_b1_wq1(ga_a_b1_wq1),
        .ga_a_b1_wq2(ga_a_b1_wq2),
        .ga_a_b1_wq3(ga_a_b1_wq3),
        .ga_a_b1_wq4(ga_a_b1_wq4),
        .ga_a_b1_wq5(ga_a_b1_wq5),
        .ga_a_b1_wq6(ga_a_b1_wq6),
        .ga_a_b1_wq7(ga_a_b1_wq7),
        .ga_a_b1_wk0(ga_a_b1_wk0),
        .ga_a_b1_wk1(ga_a_b1_wk1),
        .ga_a_b1_wk2(ga_a_b1_wk2),
        .ga_a_b1_wk3(ga_a_b1_wk3),
        .ga_a_b1_wk4(ga_a_b1_wk4),
        .ga_a_b1_wk5(ga_a_b1_wk5),
        .ga_a_b1_wk6(ga_a_b1_wk6),
        .ga_a_b1_wk7(ga_a_b1_wk7),
        .ga_a_b1_wv0(ga_a_b1_wv0),
        .ga_a_b1_wv1(ga_a_b1_wv1),
        .ga_a_b1_wv2(ga_a_b1_wv2),
        .ga_a_b1_wv3(ga_a_b1_wv3),
        .ga_a_b1_wv4(ga_a_b1_wv4),
        .ga_a_b1_wv5(ga_a_b1_wv5),
        .ga_a_b1_wv6(ga_a_b1_wv6),
        .ga_a_b1_wv7(ga_a_b1_wv7),
        .ga_a_b1_w1_0(ga_a_b1_w1_0),
        .ga_a_b1_w1_1(ga_a_b1_w1_1),
        .ga_a_b1_w1_2(ga_a_b1_w1_2),
        .ga_a_b1_w1_3(ga_a_b1_w1_3),
        .ga_a_b1_w1_4(ga_a_b1_w1_4),
        .ga_a_b1_w1_5(ga_a_b1_w1_5),
        .ga_a_b1_w1_6(ga_a_b1_w1_6),
        .ga_a_b1_w1_7(ga_a_b1_w1_7),
        .ga_a_b1_b1_0(ga_a_b1_b1_0),
        .ga_a_b1_b1_1(ga_a_b1_b1_1),
        .ga_a_b1_b1_2(ga_a_b1_b1_2),
        .ga_a_b1_b1_3(ga_a_b1_b1_3),
        .ga_a_b1_b1_4(ga_a_b1_b1_4),
        .ga_a_b1_b1_5(ga_a_b1_b1_5),
        .ga_a_b1_b1_6(ga_a_b1_b1_6),
        .ga_a_b1_b1_7(ga_a_b1_b1_7),
        .ga_a_b1_w2_0(ga_a_b1_w2_0),
        .ga_a_b1_w2_1(ga_a_b1_w2_1),
        .ga_a_b1_w2_2(ga_a_b1_w2_2),
        .ga_a_b1_w2_3(ga_a_b1_w2_3),
        .ga_a_b1_w2_4(ga_a_b1_w2_4),
        .ga_a_b1_w2_5(ga_a_b1_w2_5),
        .ga_a_b1_w2_6(ga_a_b1_w2_6),
        .ga_a_b1_w2_7(ga_a_b1_w2_7),
        .ga_a_b1_b2_0(ga_a_b1_b2_0),
        .ga_a_b1_b2_1(ga_a_b1_b2_1),
        .ga_a_b1_b2_2(ga_a_b1_b2_2),
        .ga_a_b1_b2_3(ga_a_b1_b2_3),
        .ga_a_b1_b2_4(ga_a_b1_b2_4),
        .ga_a_b1_b2_5(ga_a_b1_b2_5),
        .ga_a_b1_b2_6(ga_a_b1_b2_6),
        .ga_a_b1_b2_7(ga_a_b1_b2_7),
        .ga_a_b1_gamma0(ga_a_b1_gamma0),
        .ga_a_b1_gamma1(ga_a_b1_gamma1),
        .ga_a_b1_gamma2(ga_a_b1_gamma2),
        .ga_a_b1_gamma3(ga_a_b1_gamma3),
        .ga_a_b1_gamma4(ga_a_b1_gamma4),
        .ga_a_b1_gamma5(ga_a_b1_gamma5),
        .ga_a_b1_gamma6(ga_a_b1_gamma6),
        .ga_a_b1_gamma7(ga_a_b1_gamma7),
        .ga_a_b1_beta0(ga_a_b1_beta0),
        .ga_a_b1_beta1(ga_a_b1_beta1),
        .ga_a_b1_beta2(ga_a_b1_beta2),
        .ga_a_b1_beta3(ga_a_b1_beta3),
        .ga_a_b1_beta4(ga_a_b1_beta4),
        .ga_a_b1_beta5(ga_a_b1_beta5),
        .ga_a_b1_beta6(ga_a_b1_beta6),
        .ga_a_b1_beta7(ga_a_b1_beta7),
        .ga_a_b2_wq0(ga_a_b2_wq0),
        .ga_a_b2_wq1(ga_a_b2_wq1),
        .ga_a_b2_wq2(ga_a_b2_wq2),
        .ga_a_b2_wq3(ga_a_b2_wq3),
        .ga_a_b2_wq4(ga_a_b2_wq4),
        .ga_a_b2_wq5(ga_a_b2_wq5),
        .ga_a_b2_wq6(ga_a_b2_wq6),
        .ga_a_b2_wq7(ga_a_b2_wq7),
        .ga_a_b2_wk0(ga_a_b2_wk0),
        .ga_a_b2_wk1(ga_a_b2_wk1),
        .ga_a_b2_wk2(ga_a_b2_wk2),
        .ga_a_b2_wk3(ga_a_b2_wk3),
        .ga_a_b2_wk4(ga_a_b2_wk4),
        .ga_a_b2_wk5(ga_a_b2_wk5),
        .ga_a_b2_wk6(ga_a_b2_wk6),
        .ga_a_b2_wk7(ga_a_b2_wk7),
        .ga_a_b2_wv0(ga_a_b2_wv0),
        .ga_a_b2_wv1(ga_a_b2_wv1),
        .ga_a_b2_wv2(ga_a_b2_wv2),
        .ga_a_b2_wv3(ga_a_b2_wv3),
        .ga_a_b2_wv4(ga_a_b2_wv4),
        .ga_a_b2_wv5(ga_a_b2_wv5),
        .ga_a_b2_wv6(ga_a_b2_wv6),
        .ga_a_b2_wv7(ga_a_b2_wv7),
        .ga_a_b2_w1_0(ga_a_b2_w1_0),
        .ga_a_b2_w1_1(ga_a_b2_w1_1),
        .ga_a_b2_w1_2(ga_a_b2_w1_2),
        .ga_a_b2_w1_3(ga_a_b2_w1_3),
        .ga_a_b2_w1_4(ga_a_b2_w1_4),
        .ga_a_b2_w1_5(ga_a_b2_w1_5),
        .ga_a_b2_w1_6(ga_a_b2_w1_6),
        .ga_a_b2_w1_7(ga_a_b2_w1_7),
        .ga_a_b2_b1_0(ga_a_b2_b1_0),
        .ga_a_b2_b1_1(ga_a_b2_b1_1),
        .ga_a_b2_b1_2(ga_a_b2_b1_2),
        .ga_a_b2_b1_3(ga_a_b2_b1_3),
        .ga_a_b2_b1_4(ga_a_b2_b1_4),
        .ga_a_b2_b1_5(ga_a_b2_b1_5),
        .ga_a_b2_b1_6(ga_a_b2_b1_6),
        .ga_a_b2_b1_7(ga_a_b2_b1_7),
        .ga_a_b2_w2_0(ga_a_b2_w2_0),
        .ga_a_b2_w2_1(ga_a_b2_w2_1),
        .ga_a_b2_w2_2(ga_a_b2_w2_2),
        .ga_a_b2_w2_3(ga_a_b2_w2_3),
        .ga_a_b2_w2_4(ga_a_b2_w2_4),
        .ga_a_b2_w2_5(ga_a_b2_w2_5),
        .ga_a_b2_w2_6(ga_a_b2_w2_6),
        .ga_a_b2_w2_7(ga_a_b2_w2_7),
        .ga_a_b2_b2_0(ga_a_b2_b2_0),
        .ga_a_b2_b2_1(ga_a_b2_b2_1),
        .ga_a_b2_b2_2(ga_a_b2_b2_2),
        .ga_a_b2_b2_3(ga_a_b2_b2_3),
        .ga_a_b2_b2_4(ga_a_b2_b2_4),
        .ga_a_b2_b2_5(ga_a_b2_b2_5),
        .ga_a_b2_b2_6(ga_a_b2_b2_6),
        .ga_a_b2_b2_7(ga_a_b2_b2_7),
        .ga_a_b2_gamma0(ga_a_b2_gamma0),
        .ga_a_b2_gamma1(ga_a_b2_gamma1),
        .ga_a_b2_gamma2(ga_a_b2_gamma2),
        .ga_a_b2_gamma3(ga_a_b2_gamma3),
        .ga_a_b2_gamma4(ga_a_b2_gamma4),
        .ga_a_b2_gamma5(ga_a_b2_gamma5),
        .ga_a_b2_gamma6(ga_a_b2_gamma6),
        .ga_a_b2_gamma7(ga_a_b2_gamma7),
        .ga_a_b2_beta0(ga_a_b2_beta0),
        .ga_a_b2_beta1(ga_a_b2_beta1),
        .ga_a_b2_beta2(ga_a_b2_beta2),
        .ga_a_b2_beta3(ga_a_b2_beta3),
        .ga_a_b2_beta4(ga_a_b2_beta4),
        .ga_a_b2_beta5(ga_a_b2_beta5),
        .ga_a_b2_beta6(ga_a_b2_beta6),
        .ga_a_b2_beta7(ga_a_b2_beta7),
        .ga_b_b1_wq0(ga_b_b1_wq0),
        .ga_b_b1_wq1(ga_b_b1_wq1),
        .ga_b_b1_wq2(ga_b_b1_wq2),
        .ga_b_b1_wq3(ga_b_b1_wq3),
        .ga_b_b1_wq4(ga_b_b1_wq4),
        .ga_b_b1_wq5(ga_b_b1_wq5),
        .ga_b_b1_wq6(ga_b_b1_wq6),
        .ga_b_b1_wq7(ga_b_b1_wq7),
        .ga_b_b1_wk0(ga_b_b1_wk0),
        .ga_b_b1_wk1(ga_b_b1_wk1),
        .ga_b_b1_wk2(ga_b_b1_wk2),
        .ga_b_b1_wk3(ga_b_b1_wk3),
        .ga_b_b1_wk4(ga_b_b1_wk4),
        .ga_b_b1_wk5(ga_b_b1_wk5),
        .ga_b_b1_wk6(ga_b_b1_wk6),
        .ga_b_b1_wk7(ga_b_b1_wk7),
        .ga_b_b1_wv0(ga_b_b1_wv0),
        .ga_b_b1_wv1(ga_b_b1_wv1),
        .ga_b_b1_wv2(ga_b_b1_wv2),
        .ga_b_b1_wv3(ga_b_b1_wv3),
        .ga_b_b1_wv4(ga_b_b1_wv4),
        .ga_b_b1_wv5(ga_b_b1_wv5),
        .ga_b_b1_wv6(ga_b_b1_wv6),
        .ga_b_b1_wv7(ga_b_b1_wv7),
        .ga_b_b1_w1_0(ga_b_b1_w1_0),
        .ga_b_b1_w1_1(ga_b_b1_w1_1),
        .ga_b_b1_w1_2(ga_b_b1_w1_2),
        .ga_b_b1_w1_3(ga_b_b1_w1_3),
        .ga_b_b1_w1_4(ga_b_b1_w1_4),
        .ga_b_b1_w1_5(ga_b_b1_w1_5),
        .ga_b_b1_w1_6(ga_b_b1_w1_6),
        .ga_b_b1_w1_7(ga_b_b1_w1_7),
        .ga_b_b1_b1_0(ga_b_b1_b1_0),
        .ga_b_b1_b1_1(ga_b_b1_b1_1),
        .ga_b_b1_b1_2(ga_b_b1_b1_2),
        .ga_b_b1_b1_3(ga_b_b1_b1_3),
        .ga_b_b1_b1_4(ga_b_b1_b1_4),
        .ga_b_b1_b1_5(ga_b_b1_b1_5),
        .ga_b_b1_b1_6(ga_b_b1_b1_6),
        .ga_b_b1_b1_7(ga_b_b1_b1_7),
        .ga_b_b1_w2_0(ga_b_b1_w2_0),
        .ga_b_b1_w2_1(ga_b_b1_w2_1),
        .ga_b_b1_w2_2(ga_b_b1_w2_2),
        .ga_b_b1_w2_3(ga_b_b1_w2_3),
        .ga_b_b1_w2_4(ga_b_b1_w2_4),
        .ga_b_b1_w2_5(ga_b_b1_w2_5),
        .ga_b_b1_w2_6(ga_b_b1_w2_6),
        .ga_b_b1_w2_7(ga_b_b1_w2_7),
        .ga_b_b1_b2_0(ga_b_b1_b2_0),
        .ga_b_b1_b2_1(ga_b_b1_b2_1),
        .ga_b_b1_b2_2(ga_b_b1_b2_2),
        .ga_b_b1_b2_3(ga_b_b1_b2_3),
        .ga_b_b1_b2_4(ga_b_b1_b2_4),
        .ga_b_b1_b2_5(ga_b_b1_b2_5),
        .ga_b_b1_b2_6(ga_b_b1_b2_6),
        .ga_b_b1_b2_7(ga_b_b1_b2_7),
        .ga_b_b1_gamma0(ga_b_b1_gamma0),
        .ga_b_b1_gamma1(ga_b_b1_gamma1),
        .ga_b_b1_gamma2(ga_b_b1_gamma2),
        .ga_b_b1_gamma3(ga_b_b1_gamma3),
        .ga_b_b1_gamma4(ga_b_b1_gamma4),
        .ga_b_b1_gamma5(ga_b_b1_gamma5),
        .ga_b_b1_gamma6(ga_b_b1_gamma6),
        .ga_b_b1_gamma7(ga_b_b1_gamma7),
        .ga_b_b1_beta0(ga_b_b1_beta0),
        .ga_b_b1_beta1(ga_b_b1_beta1),
        .ga_b_b1_beta2(ga_b_b1_beta2),
        .ga_b_b1_beta3(ga_b_b1_beta3),
        .ga_b_b1_beta4(ga_b_b1_beta4),
        .ga_b_b1_beta5(ga_b_b1_beta5),
        .ga_b_b1_beta6(ga_b_b1_beta6),
        .ga_b_b1_beta7(ga_b_b1_beta7),
        .ga_b_b2_wq0(ga_b_b2_wq0),
        .ga_b_b2_wq1(ga_b_b2_wq1),
        .ga_b_b2_wq2(ga_b_b2_wq2),
        .ga_b_b2_wq3(ga_b_b2_wq3),
        .ga_b_b2_wq4(ga_b_b2_wq4),
        .ga_b_b2_wq5(ga_b_b2_wq5),
        .ga_b_b2_wq6(ga_b_b2_wq6),
        .ga_b_b2_wq7(ga_b_b2_wq7),
        .ga_b_b2_wk0(ga_b_b2_wk0),
        .ga_b_b2_wk1(ga_b_b2_wk1),
        .ga_b_b2_wk2(ga_b_b2_wk2),
        .ga_b_b2_wk3(ga_b_b2_wk3),
        .ga_b_b2_wk4(ga_b_b2_wk4),
        .ga_b_b2_wk5(ga_b_b2_wk5),
        .ga_b_b2_wk6(ga_b_b2_wk6),
        .ga_b_b2_wk7(ga_b_b2_wk7),
        .ga_b_b2_wv0(ga_b_b2_wv0),
        .ga_b_b2_wv1(ga_b_b2_wv1),
        .ga_b_b2_wv2(ga_b_b2_wv2),
        .ga_b_b2_wv3(ga_b_b2_wv3),
        .ga_b_b2_wv4(ga_b_b2_wv4),
        .ga_b_b2_wv5(ga_b_b2_wv5),
        .ga_b_b2_wv6(ga_b_b2_wv6),
        .ga_b_b2_wv7(ga_b_b2_wv7),
        .ga_b_b2_w1_0(ga_b_b2_w1_0),
        .ga_b_b2_w1_1(ga_b_b2_w1_1),
        .ga_b_b2_w1_2(ga_b_b2_w1_2),
        .ga_b_b2_w1_3(ga_b_b2_w1_3),
        .ga_b_b2_w1_4(ga_b_b2_w1_4),
        .ga_b_b2_w1_5(ga_b_b2_w1_5),
        .ga_b_b2_w1_6(ga_b_b2_w1_6),
        .ga_b_b2_w1_7(ga_b_b2_w1_7),
        .ga_b_b2_b1_0(ga_b_b2_b1_0),
        .ga_b_b2_b1_1(ga_b_b2_b1_1),
        .ga_b_b2_b1_2(ga_b_b2_b1_2),
        .ga_b_b2_b1_3(ga_b_b2_b1_3),
        .ga_b_b2_b1_4(ga_b_b2_b1_4),
        .ga_b_b2_b1_5(ga_b_b2_b1_5),
        .ga_b_b2_b1_6(ga_b_b2_b1_6),
        .ga_b_b2_b1_7(ga_b_b2_b1_7),
        .ga_b_b2_w2_0(ga_b_b2_w2_0),
        .ga_b_b2_w2_1(ga_b_b2_w2_1),
        .ga_b_b2_w2_2(ga_b_b2_w2_2),
        .ga_b_b2_w2_3(ga_b_b2_w2_3),
        .ga_b_b2_w2_4(ga_b_b2_w2_4),
        .ga_b_b2_w2_5(ga_b_b2_w2_5),
        .ga_b_b2_w2_6(ga_b_b2_w2_6),
        .ga_b_b2_w2_7(ga_b_b2_w2_7),
        .ga_b_b2_b2_0(ga_b_b2_b2_0),
        .ga_b_b2_b2_1(ga_b_b2_b2_1),
        .ga_b_b2_b2_2(ga_b_b2_b2_2),
        .ga_b_b2_b2_3(ga_b_b2_b2_3),
        .ga_b_b2_b2_4(ga_b_b2_b2_4),
        .ga_b_b2_b2_5(ga_b_b2_b2_5),
        .ga_b_b2_b2_6(ga_b_b2_b2_6),
        .ga_b_b2_b2_7(ga_b_b2_b2_7),
        .ga_b_b2_gamma0(ga_b_b2_gamma0),
        .ga_b_b2_gamma1(ga_b_b2_gamma1),
        .ga_b_b2_gamma2(ga_b_b2_gamma2),
        .ga_b_b2_gamma3(ga_b_b2_gamma3),
        .ga_b_b2_gamma4(ga_b_b2_gamma4),
        .ga_b_b2_gamma5(ga_b_b2_gamma5),
        .ga_b_b2_gamma6(ga_b_b2_gamma6),
        .ga_b_b2_gamma7(ga_b_b2_gamma7),
        .ga_b_b2_beta0(ga_b_b2_beta0),
        .ga_b_b2_beta1(ga_b_b2_beta1),
        .ga_b_b2_beta2(ga_b_b2_beta2),
        .ga_b_b2_beta3(ga_b_b2_beta3),
        .ga_b_b2_beta4(ga_b_b2_beta4),
        .ga_b_b2_beta5(ga_b_b2_beta5),
        .ga_b_b2_beta6(ga_b_b2_beta6),
        .ga_b_b2_beta7(ga_b_b2_beta7),
        .gb_a_b1_wq0(gb_a_b1_wq0),
        .gb_a_b1_wq1(gb_a_b1_wq1),
        .gb_a_b1_wq2(gb_a_b1_wq2),
        .gb_a_b1_wq3(gb_a_b1_wq3),
        .gb_a_b1_wq4(gb_a_b1_wq4),
        .gb_a_b1_wq5(gb_a_b1_wq5),
        .gb_a_b1_wq6(gb_a_b1_wq6),
        .gb_a_b1_wq7(gb_a_b1_wq7),
        .gb_a_b1_wk0(gb_a_b1_wk0),
        .gb_a_b1_wk1(gb_a_b1_wk1),
        .gb_a_b1_wk2(gb_a_b1_wk2),
        .gb_a_b1_wk3(gb_a_b1_wk3),
        .gb_a_b1_wk4(gb_a_b1_wk4),
        .gb_a_b1_wk5(gb_a_b1_wk5),
        .gb_a_b1_wk6(gb_a_b1_wk6),
        .gb_a_b1_wk7(gb_a_b1_wk7),
        .gb_a_b1_wv0(gb_a_b1_wv0),
        .gb_a_b1_wv1(gb_a_b1_wv1),
        .gb_a_b1_wv2(gb_a_b1_wv2),
        .gb_a_b1_wv3(gb_a_b1_wv3),
        .gb_a_b1_wv4(gb_a_b1_wv4),
        .gb_a_b1_wv5(gb_a_b1_wv5),
        .gb_a_b1_wv6(gb_a_b1_wv6),
        .gb_a_b1_wv7(gb_a_b1_wv7),
        .gb_a_b1_w1_0(gb_a_b1_w1_0),
        .gb_a_b1_w1_1(gb_a_b1_w1_1),
        .gb_a_b1_w1_2(gb_a_b1_w1_2),
        .gb_a_b1_w1_3(gb_a_b1_w1_3),
        .gb_a_b1_w1_4(gb_a_b1_w1_4),
        .gb_a_b1_w1_5(gb_a_b1_w1_5),
        .gb_a_b1_w1_6(gb_a_b1_w1_6),
        .gb_a_b1_w1_7(gb_a_b1_w1_7),
        .gb_a_b1_b1_0(gb_a_b1_b1_0),
        .gb_a_b1_b1_1(gb_a_b1_b1_1),
        .gb_a_b1_b1_2(gb_a_b1_b1_2),
        .gb_a_b1_b1_3(gb_a_b1_b1_3),
        .gb_a_b1_b1_4(gb_a_b1_b1_4),
        .gb_a_b1_b1_5(gb_a_b1_b1_5),
        .gb_a_b1_b1_6(gb_a_b1_b1_6),
        .gb_a_b1_b1_7(gb_a_b1_b1_7),
        .gb_a_b1_w2_0(gb_a_b1_w2_0),
        .gb_a_b1_w2_1(gb_a_b1_w2_1),
        .gb_a_b1_w2_2(gb_a_b1_w2_2),
        .gb_a_b1_w2_3(gb_a_b1_w2_3),
        .gb_a_b1_w2_4(gb_a_b1_w2_4),
        .gb_a_b1_w2_5(gb_a_b1_w2_5),
        .gb_a_b1_w2_6(gb_a_b1_w2_6),
        .gb_a_b1_w2_7(gb_a_b1_w2_7),
        .gb_a_b1_b2_0(gb_a_b1_b2_0),
        .gb_a_b1_b2_1(gb_a_b1_b2_1),
        .gb_a_b1_b2_2(gb_a_b1_b2_2),
        .gb_a_b1_b2_3(gb_a_b1_b2_3),
        .gb_a_b1_b2_4(gb_a_b1_b2_4),
        .gb_a_b1_b2_5(gb_a_b1_b2_5),
        .gb_a_b1_b2_6(gb_a_b1_b2_6),
        .gb_a_b1_b2_7(gb_a_b1_b2_7),
        .gb_a_b1_gamma0(gb_a_b1_gamma0),
        .gb_a_b1_gamma1(gb_a_b1_gamma1),
        .gb_a_b1_gamma2(gb_a_b1_gamma2),
        .gb_a_b1_gamma3(gb_a_b1_gamma3),
        .gb_a_b1_gamma4(gb_a_b1_gamma4),
        .gb_a_b1_gamma5(gb_a_b1_gamma5),
        .gb_a_b1_gamma6(gb_a_b1_gamma6),
        .gb_a_b1_gamma7(gb_a_b1_gamma7),
        .gb_a_b1_beta0(gb_a_b1_beta0),
        .gb_a_b1_beta1(gb_a_b1_beta1),
        .gb_a_b1_beta2(gb_a_b1_beta2),
        .gb_a_b1_beta3(gb_a_b1_beta3),
        .gb_a_b1_beta4(gb_a_b1_beta4),
        .gb_a_b1_beta5(gb_a_b1_beta5),
        .gb_a_b1_beta6(gb_a_b1_beta6),
        .gb_a_b1_beta7(gb_a_b1_beta7),
        .gb_a_b2_wq0(gb_a_b2_wq0),
        .gb_a_b2_wq1(gb_a_b2_wq1),
        .gb_a_b2_wq2(gb_a_b2_wq2),
        .gb_a_b2_wq3(gb_a_b2_wq3),
        .gb_a_b2_wq4(gb_a_b2_wq4),
        .gb_a_b2_wq5(gb_a_b2_wq5),
        .gb_a_b2_wq6(gb_a_b2_wq6),
        .gb_a_b2_wq7(gb_a_b2_wq7),
        .gb_a_b2_wk0(gb_a_b2_wk0),
        .gb_a_b2_wk1(gb_a_b2_wk1),
        .gb_a_b2_wk2(gb_a_b2_wk2),
        .gb_a_b2_wk3(gb_a_b2_wk3),
        .gb_a_b2_wk4(gb_a_b2_wk4),
        .gb_a_b2_wk5(gb_a_b2_wk5),
        .gb_a_b2_wk6(gb_a_b2_wk6),
        .gb_a_b2_wk7(gb_a_b2_wk7),
        .gb_a_b2_wv0(gb_a_b2_wv0),
        .gb_a_b2_wv1(gb_a_b2_wv1),
        .gb_a_b2_wv2(gb_a_b2_wv2),
        .gb_a_b2_wv3(gb_a_b2_wv3),
        .gb_a_b2_wv4(gb_a_b2_wv4),
        .gb_a_b2_wv5(gb_a_b2_wv5),
        .gb_a_b2_wv6(gb_a_b2_wv6),
        .gb_a_b2_wv7(gb_a_b2_wv7),
        .gb_a_b2_w1_0(gb_a_b2_w1_0),
        .gb_a_b2_w1_1(gb_a_b2_w1_1),
        .gb_a_b2_w1_2(gb_a_b2_w1_2),
        .gb_a_b2_w1_3(gb_a_b2_w1_3),
        .gb_a_b2_w1_4(gb_a_b2_w1_4),
        .gb_a_b2_w1_5(gb_a_b2_w1_5),
        .gb_a_b2_w1_6(gb_a_b2_w1_6),
        .gb_a_b2_w1_7(gb_a_b2_w1_7),
        .gb_a_b2_b1_0(gb_a_b2_b1_0),
        .gb_a_b2_b1_1(gb_a_b2_b1_1),
        .gb_a_b2_b1_2(gb_a_b2_b1_2),
        .gb_a_b2_b1_3(gb_a_b2_b1_3),
        .gb_a_b2_b1_4(gb_a_b2_b1_4),
        .gb_a_b2_b1_5(gb_a_b2_b1_5),
        .gb_a_b2_b1_6(gb_a_b2_b1_6),
        .gb_a_b2_b1_7(gb_a_b2_b1_7),
        .gb_a_b2_w2_0(gb_a_b2_w2_0),
        .gb_a_b2_w2_1(gb_a_b2_w2_1),
        .gb_a_b2_w2_2(gb_a_b2_w2_2),
        .gb_a_b2_w2_3(gb_a_b2_w2_3),
        .gb_a_b2_w2_4(gb_a_b2_w2_4),
        .gb_a_b2_w2_5(gb_a_b2_w2_5),
        .gb_a_b2_w2_6(gb_a_b2_w2_6),
        .gb_a_b2_w2_7(gb_a_b2_w2_7),
        .gb_a_b2_b2_0(gb_a_b2_b2_0),
        .gb_a_b2_b2_1(gb_a_b2_b2_1),
        .gb_a_b2_b2_2(gb_a_b2_b2_2),
        .gb_a_b2_b2_3(gb_a_b2_b2_3),
        .gb_a_b2_b2_4(gb_a_b2_b2_4),
        .gb_a_b2_b2_5(gb_a_b2_b2_5),
        .gb_a_b2_b2_6(gb_a_b2_b2_6),
        .gb_a_b2_b2_7(gb_a_b2_b2_7),
        .gb_a_b2_gamma0(gb_a_b2_gamma0),
        .gb_a_b2_gamma1(gb_a_b2_gamma1),
        .gb_a_b2_gamma2(gb_a_b2_gamma2),
        .gb_a_b2_gamma3(gb_a_b2_gamma3),
        .gb_a_b2_gamma4(gb_a_b2_gamma4),
        .gb_a_b2_gamma5(gb_a_b2_gamma5),
        .gb_a_b2_gamma6(gb_a_b2_gamma6),
        .gb_a_b2_gamma7(gb_a_b2_gamma7),
        .gb_a_b2_beta0(gb_a_b2_beta0),
        .gb_a_b2_beta1(gb_a_b2_beta1),
        .gb_a_b2_beta2(gb_a_b2_beta2),
        .gb_a_b2_beta3(gb_a_b2_beta3),
        .gb_a_b2_beta4(gb_a_b2_beta4),
        .gb_a_b2_beta5(gb_a_b2_beta5),
        .gb_a_b2_beta6(gb_a_b2_beta6),
        .gb_a_b2_beta7(gb_a_b2_beta7),
        .gb_b_b1_wq0(gb_b_b1_wq0),
        .gb_b_b1_wq1(gb_b_b1_wq1),
        .gb_b_b1_wq2(gb_b_b1_wq2),
        .gb_b_b1_wq3(gb_b_b1_wq3),
        .gb_b_b1_wq4(gb_b_b1_wq4),
        .gb_b_b1_wq5(gb_b_b1_wq5),
        .gb_b_b1_wq6(gb_b_b1_wq6),
        .gb_b_b1_wq7(gb_b_b1_wq7),
        .gb_b_b1_wk0(gb_b_b1_wk0),
        .gb_b_b1_wk1(gb_b_b1_wk1),
        .gb_b_b1_wk2(gb_b_b1_wk2),
        .gb_b_b1_wk3(gb_b_b1_wk3),
        .gb_b_b1_wk4(gb_b_b1_wk4),
        .gb_b_b1_wk5(gb_b_b1_wk5),
        .gb_b_b1_wk6(gb_b_b1_wk6),
        .gb_b_b1_wk7(gb_b_b1_wk7),
        .gb_b_b1_wv0(gb_b_b1_wv0),
        .gb_b_b1_wv1(gb_b_b1_wv1),
        .gb_b_b1_wv2(gb_b_b1_wv2),
        .gb_b_b1_wv3(gb_b_b1_wv3),
        .gb_b_b1_wv4(gb_b_b1_wv4),
        .gb_b_b1_wv5(gb_b_b1_wv5),
        .gb_b_b1_wv6(gb_b_b1_wv6),
        .gb_b_b1_wv7(gb_b_b1_wv7),
        .gb_b_b1_w1_0(gb_b_b1_w1_0),
        .gb_b_b1_w1_1(gb_b_b1_w1_1),
        .gb_b_b1_w1_2(gb_b_b1_w1_2),
        .gb_b_b1_w1_3(gb_b_b1_w1_3),
        .gb_b_b1_w1_4(gb_b_b1_w1_4),
        .gb_b_b1_w1_5(gb_b_b1_w1_5),
        .gb_b_b1_w1_6(gb_b_b1_w1_6),
        .gb_b_b1_w1_7(gb_b_b1_w1_7),
        .gb_b_b1_b1_0(gb_b_b1_b1_0),
        .gb_b_b1_b1_1(gb_b_b1_b1_1),
        .gb_b_b1_b1_2(gb_b_b1_b1_2),
        .gb_b_b1_b1_3(gb_b_b1_b1_3),
        .gb_b_b1_b1_4(gb_b_b1_b1_4),
        .gb_b_b1_b1_5(gb_b_b1_b1_5),
        .gb_b_b1_b1_6(gb_b_b1_b1_6),
        .gb_b_b1_b1_7(gb_b_b1_b1_7),
        .gb_b_b1_w2_0(gb_b_b1_w2_0),
        .gb_b_b1_w2_1(gb_b_b1_w2_1),
        .gb_b_b1_w2_2(gb_b_b1_w2_2),
        .gb_b_b1_w2_3(gb_b_b1_w2_3),
        .gb_b_b1_w2_4(gb_b_b1_w2_4),
        .gb_b_b1_w2_5(gb_b_b1_w2_5),
        .gb_b_b1_w2_6(gb_b_b1_w2_6),
        .gb_b_b1_w2_7(gb_b_b1_w2_7),
        .gb_b_b1_b2_0(gb_b_b1_b2_0),
        .gb_b_b1_b2_1(gb_b_b1_b2_1),
        .gb_b_b1_b2_2(gb_b_b1_b2_2),
        .gb_b_b1_b2_3(gb_b_b1_b2_3),
        .gb_b_b1_b2_4(gb_b_b1_b2_4),
        .gb_b_b1_b2_5(gb_b_b1_b2_5),
        .gb_b_b1_b2_6(gb_b_b1_b2_6),
        .gb_b_b1_b2_7(gb_b_b1_b2_7),
        .gb_b_b1_gamma0(gb_b_b1_gamma0),
        .gb_b_b1_gamma1(gb_b_b1_gamma1),
        .gb_b_b1_gamma2(gb_b_b1_gamma2),
        .gb_b_b1_gamma3(gb_b_b1_gamma3),
        .gb_b_b1_gamma4(gb_b_b1_gamma4),
        .gb_b_b1_gamma5(gb_b_b1_gamma5),
        .gb_b_b1_gamma6(gb_b_b1_gamma6),
        .gb_b_b1_gamma7(gb_b_b1_gamma7),
        .gb_b_b1_beta0(gb_b_b1_beta0),
        .gb_b_b1_beta1(gb_b_b1_beta1),
        .gb_b_b1_beta2(gb_b_b1_beta2),
        .gb_b_b1_beta3(gb_b_b1_beta3),
        .gb_b_b1_beta4(gb_b_b1_beta4),
        .gb_b_b1_beta5(gb_b_b1_beta5),
        .gb_b_b1_beta6(gb_b_b1_beta6),
        .gb_b_b1_beta7(gb_b_b1_beta7),
        .gb_b_b2_wq0(gb_b_b2_wq0),
        .gb_b_b2_wq1(gb_b_b2_wq1),
        .gb_b_b2_wq2(gb_b_b2_wq2),
        .gb_b_b2_wq3(gb_b_b2_wq3),
        .gb_b_b2_wq4(gb_b_b2_wq4),
        .gb_b_b2_wq5(gb_b_b2_wq5),
        .gb_b_b2_wq6(gb_b_b2_wq6),
        .gb_b_b2_wq7(gb_b_b2_wq7),
        .gb_b_b2_wk0(gb_b_b2_wk0),
        .gb_b_b2_wk1(gb_b_b2_wk1),
        .gb_b_b2_wk2(gb_b_b2_wk2),
        .gb_b_b2_wk3(gb_b_b2_wk3),
        .gb_b_b2_wk4(gb_b_b2_wk4),
        .gb_b_b2_wk5(gb_b_b2_wk5),
        .gb_b_b2_wk6(gb_b_b2_wk6),
        .gb_b_b2_wk7(gb_b_b2_wk7),
        .gb_b_b2_wv0(gb_b_b2_wv0),
        .gb_b_b2_wv1(gb_b_b2_wv1),
        .gb_b_b2_wv2(gb_b_b2_wv2),
        .gb_b_b2_wv3(gb_b_b2_wv3),
        .gb_b_b2_wv4(gb_b_b2_wv4),
        .gb_b_b2_wv5(gb_b_b2_wv5),
        .gb_b_b2_wv6(gb_b_b2_wv6),
        .gb_b_b2_wv7(gb_b_b2_wv7),
        .gb_b_b2_w1_0(gb_b_b2_w1_0),
        .gb_b_b2_w1_1(gb_b_b2_w1_1),
        .gb_b_b2_w1_2(gb_b_b2_w1_2),
        .gb_b_b2_w1_3(gb_b_b2_w1_3),
        .gb_b_b2_w1_4(gb_b_b2_w1_4),
        .gb_b_b2_w1_5(gb_b_b2_w1_5),
        .gb_b_b2_w1_6(gb_b_b2_w1_6),
        .gb_b_b2_w1_7(gb_b_b2_w1_7),
        .gb_b_b2_b1_0(gb_b_b2_b1_0),
        .gb_b_b2_b1_1(gb_b_b2_b1_1),
        .gb_b_b2_b1_2(gb_b_b2_b1_2),
        .gb_b_b2_b1_3(gb_b_b2_b1_3),
        .gb_b_b2_b1_4(gb_b_b2_b1_4),
        .gb_b_b2_b1_5(gb_b_b2_b1_5),
        .gb_b_b2_b1_6(gb_b_b2_b1_6),
        .gb_b_b2_b1_7(gb_b_b2_b1_7),
        .gb_b_b2_w2_0(gb_b_b2_w2_0),
        .gb_b_b2_w2_1(gb_b_b2_w2_1),
        .gb_b_b2_w2_2(gb_b_b2_w2_2),
        .gb_b_b2_w2_3(gb_b_b2_w2_3),
        .gb_b_b2_w2_4(gb_b_b2_w2_4),
        .gb_b_b2_w2_5(gb_b_b2_w2_5),
        .gb_b_b2_w2_6(gb_b_b2_w2_6),
        .gb_b_b2_w2_7(gb_b_b2_w2_7),
        .gb_b_b2_b2_0(gb_b_b2_b2_0),
        .gb_b_b2_b2_1(gb_b_b2_b2_1),
        .gb_b_b2_b2_2(gb_b_b2_b2_2),
        .gb_b_b2_b2_3(gb_b_b2_b2_3),
        .gb_b_b2_b2_4(gb_b_b2_b2_4),
        .gb_b_b2_b2_5(gb_b_b2_b2_5),
        .gb_b_b2_b2_6(gb_b_b2_b2_6),
        .gb_b_b2_b2_7(gb_b_b2_b2_7),
        .gb_b_b2_gamma0(gb_b_b2_gamma0),
        .gb_b_b2_gamma1(gb_b_b2_gamma1),
        .gb_b_b2_gamma2(gb_b_b2_gamma2),
        .gb_b_b2_gamma3(gb_b_b2_gamma3),
        .gb_b_b2_gamma4(gb_b_b2_gamma4),
        .gb_b_b2_gamma5(gb_b_b2_gamma5),
        .gb_b_b2_gamma6(gb_b_b2_gamma6),
        .gb_b_b2_gamma7(gb_b_b2_gamma7),
        .gb_b_b2_beta0(gb_b_b2_beta0),
        .gb_b_b2_beta1(gb_b_b2_beta1),
        .gb_b_b2_beta2(gb_b_b2_beta2),
        .gb_b_b2_beta3(gb_b_b2_beta3),
        .gb_b_b2_beta4(gb_b_b2_beta4),
        .gb_b_b2_beta5(gb_b_b2_beta5),
        .gb_b_b2_beta6(gb_b_b2_beta6),
        .gb_b_b2_beta7(gb_b_b2_beta7),
        .gc_a_b1_wq0(gc_a_b1_wq0),
        .gc_a_b1_wq1(gc_a_b1_wq1),
        .gc_a_b1_wq2(gc_a_b1_wq2),
        .gc_a_b1_wq3(gc_a_b1_wq3),
        .gc_a_b1_wq4(gc_a_b1_wq4),
        .gc_a_b1_wq5(gc_a_b1_wq5),
        .gc_a_b1_wq6(gc_a_b1_wq6),
        .gc_a_b1_wq7(gc_a_b1_wq7),
        .gc_a_b1_wk0(gc_a_b1_wk0),
        .gc_a_b1_wk1(gc_a_b1_wk1),
        .gc_a_b1_wk2(gc_a_b1_wk2),
        .gc_a_b1_wk3(gc_a_b1_wk3),
        .gc_a_b1_wk4(gc_a_b1_wk4),
        .gc_a_b1_wk5(gc_a_b1_wk5),
        .gc_a_b1_wk6(gc_a_b1_wk6),
        .gc_a_b1_wk7(gc_a_b1_wk7),
        .gc_a_b1_wv0(gc_a_b1_wv0),
        .gc_a_b1_wv1(gc_a_b1_wv1),
        .gc_a_b1_wv2(gc_a_b1_wv2),
        .gc_a_b1_wv3(gc_a_b1_wv3),
        .gc_a_b1_wv4(gc_a_b1_wv4),
        .gc_a_b1_wv5(gc_a_b1_wv5),
        .gc_a_b1_wv6(gc_a_b1_wv6),
        .gc_a_b1_wv7(gc_a_b1_wv7),
        .gc_a_b1_w1_0(gc_a_b1_w1_0),
        .gc_a_b1_w1_1(gc_a_b1_w1_1),
        .gc_a_b1_w1_2(gc_a_b1_w1_2),
        .gc_a_b1_w1_3(gc_a_b1_w1_3),
        .gc_a_b1_w1_4(gc_a_b1_w1_4),
        .gc_a_b1_w1_5(gc_a_b1_w1_5),
        .gc_a_b1_w1_6(gc_a_b1_w1_6),
        .gc_a_b1_w1_7(gc_a_b1_w1_7),
        .gc_a_b1_b1_0(gc_a_b1_b1_0),
        .gc_a_b1_b1_1(gc_a_b1_b1_1),
        .gc_a_b1_b1_2(gc_a_b1_b1_2),
        .gc_a_b1_b1_3(gc_a_b1_b1_3),
        .gc_a_b1_b1_4(gc_a_b1_b1_4),
        .gc_a_b1_b1_5(gc_a_b1_b1_5),
        .gc_a_b1_b1_6(gc_a_b1_b1_6),
        .gc_a_b1_b1_7(gc_a_b1_b1_7),
        .gc_a_b1_w2_0(gc_a_b1_w2_0),
        .gc_a_b1_w2_1(gc_a_b1_w2_1),
        .gc_a_b1_w2_2(gc_a_b1_w2_2),
        .gc_a_b1_w2_3(gc_a_b1_w2_3),
        .gc_a_b1_w2_4(gc_a_b1_w2_4),
        .gc_a_b1_w2_5(gc_a_b1_w2_5),
        .gc_a_b1_w2_6(gc_a_b1_w2_6),
        .gc_a_b1_w2_7(gc_a_b1_w2_7),
        .gc_a_b1_b2_0(gc_a_b1_b2_0),
        .gc_a_b1_b2_1(gc_a_b1_b2_1),
        .gc_a_b1_b2_2(gc_a_b1_b2_2),
        .gc_a_b1_b2_3(gc_a_b1_b2_3),
        .gc_a_b1_b2_4(gc_a_b1_b2_4),
        .gc_a_b1_b2_5(gc_a_b1_b2_5),
        .gc_a_b1_b2_6(gc_a_b1_b2_6),
        .gc_a_b1_b2_7(gc_a_b1_b2_7),
        .gc_a_b1_gamma0(gc_a_b1_gamma0),
        .gc_a_b1_gamma1(gc_a_b1_gamma1),
        .gc_a_b1_gamma2(gc_a_b1_gamma2),
        .gc_a_b1_gamma3(gc_a_b1_gamma3),
        .gc_a_b1_gamma4(gc_a_b1_gamma4),
        .gc_a_b1_gamma5(gc_a_b1_gamma5),
        .gc_a_b1_gamma6(gc_a_b1_gamma6),
        .gc_a_b1_gamma7(gc_a_b1_gamma7),
        .gc_a_b1_beta0(gc_a_b1_beta0),
        .gc_a_b1_beta1(gc_a_b1_beta1),
        .gc_a_b1_beta2(gc_a_b1_beta2),
        .gc_a_b1_beta3(gc_a_b1_beta3),
        .gc_a_b1_beta4(gc_a_b1_beta4),
        .gc_a_b1_beta5(gc_a_b1_beta5),
        .gc_a_b1_beta6(gc_a_b1_beta6),
        .gc_a_b1_beta7(gc_a_b1_beta7),
        .gc_a_b2_wq0(gc_a_b2_wq0),
        .gc_a_b2_wq1(gc_a_b2_wq1),
        .gc_a_b2_wq2(gc_a_b2_wq2),
        .gc_a_b2_wq3(gc_a_b2_wq3),
        .gc_a_b2_wq4(gc_a_b2_wq4),
        .gc_a_b2_wq5(gc_a_b2_wq5),
        .gc_a_b2_wq6(gc_a_b2_wq6),
        .gc_a_b2_wq7(gc_a_b2_wq7),
        .gc_a_b2_wk0(gc_a_b2_wk0),
        .gc_a_b2_wk1(gc_a_b2_wk1),
        .gc_a_b2_wk2(gc_a_b2_wk2),
        .gc_a_b2_wk3(gc_a_b2_wk3),
        .gc_a_b2_wk4(gc_a_b2_wk4),
        .gc_a_b2_wk5(gc_a_b2_wk5),
        .gc_a_b2_wk6(gc_a_b2_wk6),
        .gc_a_b2_wk7(gc_a_b2_wk7),
        .gc_a_b2_wv0(gc_a_b2_wv0),
        .gc_a_b2_wv1(gc_a_b2_wv1),
        .gc_a_b2_wv2(gc_a_b2_wv2),
        .gc_a_b2_wv3(gc_a_b2_wv3),
        .gc_a_b2_wv4(gc_a_b2_wv4),
        .gc_a_b2_wv5(gc_a_b2_wv5),
        .gc_a_b2_wv6(gc_a_b2_wv6),
        .gc_a_b2_wv7(gc_a_b2_wv7),
        .gc_a_b2_w1_0(gc_a_b2_w1_0),
        .gc_a_b2_w1_1(gc_a_b2_w1_1),
        .gc_a_b2_w1_2(gc_a_b2_w1_2),
        .gc_a_b2_w1_3(gc_a_b2_w1_3),
        .gc_a_b2_w1_4(gc_a_b2_w1_4),
        .gc_a_b2_w1_5(gc_a_b2_w1_5),
        .gc_a_b2_w1_6(gc_a_b2_w1_6),
        .gc_a_b2_w1_7(gc_a_b2_w1_7),
        .gc_a_b2_b1_0(gc_a_b2_b1_0),
        .gc_a_b2_b1_1(gc_a_b2_b1_1),
        .gc_a_b2_b1_2(gc_a_b2_b1_2),
        .gc_a_b2_b1_3(gc_a_b2_b1_3),
        .gc_a_b2_b1_4(gc_a_b2_b1_4),
        .gc_a_b2_b1_5(gc_a_b2_b1_5),
        .gc_a_b2_b1_6(gc_a_b2_b1_6),
        .gc_a_b2_b1_7(gc_a_b2_b1_7),
        .gc_a_b2_w2_0(gc_a_b2_w2_0),
        .gc_a_b2_w2_1(gc_a_b2_w2_1),
        .gc_a_b2_w2_2(gc_a_b2_w2_2),
        .gc_a_b2_w2_3(gc_a_b2_w2_3),
        .gc_a_b2_w2_4(gc_a_b2_w2_4),
        .gc_a_b2_w2_5(gc_a_b2_w2_5),
        .gc_a_b2_w2_6(gc_a_b2_w2_6),
        .gc_a_b2_w2_7(gc_a_b2_w2_7),
        .gc_a_b2_b2_0(gc_a_b2_b2_0),
        .gc_a_b2_b2_1(gc_a_b2_b2_1),
        .gc_a_b2_b2_2(gc_a_b2_b2_2),
        .gc_a_b2_b2_3(gc_a_b2_b2_3),
        .gc_a_b2_b2_4(gc_a_b2_b2_4),
        .gc_a_b2_b2_5(gc_a_b2_b2_5),
        .gc_a_b2_b2_6(gc_a_b2_b2_6),
        .gc_a_b2_b2_7(gc_a_b2_b2_7),
        .gc_a_b2_gamma0(gc_a_b2_gamma0),
        .gc_a_b2_gamma1(gc_a_b2_gamma1),
        .gc_a_b2_gamma2(gc_a_b2_gamma2),
        .gc_a_b2_gamma3(gc_a_b2_gamma3),
        .gc_a_b2_gamma4(gc_a_b2_gamma4),
        .gc_a_b2_gamma5(gc_a_b2_gamma5),
        .gc_a_b2_gamma6(gc_a_b2_gamma6),
        .gc_a_b2_gamma7(gc_a_b2_gamma7),
        .gc_a_b2_beta0(gc_a_b2_beta0),
        .gc_a_b2_beta1(gc_a_b2_beta1),
        .gc_a_b2_beta2(gc_a_b2_beta2),
        .gc_a_b2_beta3(gc_a_b2_beta3),
        .gc_a_b2_beta4(gc_a_b2_beta4),
        .gc_a_b2_beta5(gc_a_b2_beta5),
        .gc_a_b2_beta6(gc_a_b2_beta6),
        .gc_a_b2_beta7(gc_a_b2_beta7),
        .gc_b_b1_wq0(gc_b_b1_wq0),
        .gc_b_b1_wq1(gc_b_b1_wq1),
        .gc_b_b1_wq2(gc_b_b1_wq2),
        .gc_b_b1_wq3(gc_b_b1_wq3),
        .gc_b_b1_wq4(gc_b_b1_wq4),
        .gc_b_b1_wq5(gc_b_b1_wq5),
        .gc_b_b1_wq6(gc_b_b1_wq6),
        .gc_b_b1_wq7(gc_b_b1_wq7),
        .gc_b_b1_wk0(gc_b_b1_wk0),
        .gc_b_b1_wk1(gc_b_b1_wk1),
        .gc_b_b1_wk2(gc_b_b1_wk2),
        .gc_b_b1_wk3(gc_b_b1_wk3),
        .gc_b_b1_wk4(gc_b_b1_wk4),
        .gc_b_b1_wk5(gc_b_b1_wk5),
        .gc_b_b1_wk6(gc_b_b1_wk6),
        .gc_b_b1_wk7(gc_b_b1_wk7),
        .gc_b_b1_wv0(gc_b_b1_wv0),
        .gc_b_b1_wv1(gc_b_b1_wv1),
        .gc_b_b1_wv2(gc_b_b1_wv2),
        .gc_b_b1_wv3(gc_b_b1_wv3),
        .gc_b_b1_wv4(gc_b_b1_wv4),
        .gc_b_b1_wv5(gc_b_b1_wv5),
        .gc_b_b1_wv6(gc_b_b1_wv6),
        .gc_b_b1_wv7(gc_b_b1_wv7),
        .gc_b_b1_w1_0(gc_b_b1_w1_0),
        .gc_b_b1_w1_1(gc_b_b1_w1_1),
        .gc_b_b1_w1_2(gc_b_b1_w1_2),
        .gc_b_b1_w1_3(gc_b_b1_w1_3),
        .gc_b_b1_w1_4(gc_b_b1_w1_4),
        .gc_b_b1_w1_5(gc_b_b1_w1_5),
        .gc_b_b1_w1_6(gc_b_b1_w1_6),
        .gc_b_b1_w1_7(gc_b_b1_w1_7),
        .gc_b_b1_b1_0(gc_b_b1_b1_0),
        .gc_b_b1_b1_1(gc_b_b1_b1_1),
        .gc_b_b1_b1_2(gc_b_b1_b1_2),
        .gc_b_b1_b1_3(gc_b_b1_b1_3),
        .gc_b_b1_b1_4(gc_b_b1_b1_4),
        .gc_b_b1_b1_5(gc_b_b1_b1_5),
        .gc_b_b1_b1_6(gc_b_b1_b1_6),
        .gc_b_b1_b1_7(gc_b_b1_b1_7),
        .gc_b_b1_w2_0(gc_b_b1_w2_0),
        .gc_b_b1_w2_1(gc_b_b1_w2_1),
        .gc_b_b1_w2_2(gc_b_b1_w2_2),
        .gc_b_b1_w2_3(gc_b_b1_w2_3),
        .gc_b_b1_w2_4(gc_b_b1_w2_4),
        .gc_b_b1_w2_5(gc_b_b1_w2_5),
        .gc_b_b1_w2_6(gc_b_b1_w2_6),
        .gc_b_b1_w2_7(gc_b_b1_w2_7),
        .gc_b_b1_b2_0(gc_b_b1_b2_0),
        .gc_b_b1_b2_1(gc_b_b1_b2_1),
        .gc_b_b1_b2_2(gc_b_b1_b2_2),
        .gc_b_b1_b2_3(gc_b_b1_b2_3),
        .gc_b_b1_b2_4(gc_b_b1_b2_4),
        .gc_b_b1_b2_5(gc_b_b1_b2_5),
        .gc_b_b1_b2_6(gc_b_b1_b2_6),
        .gc_b_b1_b2_7(gc_b_b1_b2_7),
        .gc_b_b1_gamma0(gc_b_b1_gamma0),
        .gc_b_b1_gamma1(gc_b_b1_gamma1),
        .gc_b_b1_gamma2(gc_b_b1_gamma2),
        .gc_b_b1_gamma3(gc_b_b1_gamma3),
        .gc_b_b1_gamma4(gc_b_b1_gamma4),
        .gc_b_b1_gamma5(gc_b_b1_gamma5),
        .gc_b_b1_gamma6(gc_b_b1_gamma6),
        .gc_b_b1_gamma7(gc_b_b1_gamma7),
        .gc_b_b1_beta0(gc_b_b1_beta0),
        .gc_b_b1_beta1(gc_b_b1_beta1),
        .gc_b_b1_beta2(gc_b_b1_beta2),
        .gc_b_b1_beta3(gc_b_b1_beta3),
        .gc_b_b1_beta4(gc_b_b1_beta4),
        .gc_b_b1_beta5(gc_b_b1_beta5),
        .gc_b_b1_beta6(gc_b_b1_beta6),
        .gc_b_b1_beta7(gc_b_b1_beta7),
        .gc_b_b2_wq0(gc_b_b2_wq0),
        .gc_b_b2_wq1(gc_b_b2_wq1),
        .gc_b_b2_wq2(gc_b_b2_wq2),
        .gc_b_b2_wq3(gc_b_b2_wq3),
        .gc_b_b2_wq4(gc_b_b2_wq4),
        .gc_b_b2_wq5(gc_b_b2_wq5),
        .gc_b_b2_wq6(gc_b_b2_wq6),
        .gc_b_b2_wq7(gc_b_b2_wq7),
        .gc_b_b2_wk0(gc_b_b2_wk0),
        .gc_b_b2_wk1(gc_b_b2_wk1),
        .gc_b_b2_wk2(gc_b_b2_wk2),
        .gc_b_b2_wk3(gc_b_b2_wk3),
        .gc_b_b2_wk4(gc_b_b2_wk4),
        .gc_b_b2_wk5(gc_b_b2_wk5),
        .gc_b_b2_wk6(gc_b_b2_wk6),
        .gc_b_b2_wk7(gc_b_b2_wk7),
        .gc_b_b2_wv0(gc_b_b2_wv0),
        .gc_b_b2_wv1(gc_b_b2_wv1),
        .gc_b_b2_wv2(gc_b_b2_wv2),
        .gc_b_b2_wv3(gc_b_b2_wv3),
        .gc_b_b2_wv4(gc_b_b2_wv4),
        .gc_b_b2_wv5(gc_b_b2_wv5),
        .gc_b_b2_wv6(gc_b_b2_wv6),
        .gc_b_b2_wv7(gc_b_b2_wv7),
        .gc_b_b2_w1_0(gc_b_b2_w1_0),
        .gc_b_b2_w1_1(gc_b_b2_w1_1),
        .gc_b_b2_w1_2(gc_b_b2_w1_2),
        .gc_b_b2_w1_3(gc_b_b2_w1_3),
        .gc_b_b2_w1_4(gc_b_b2_w1_4),
        .gc_b_b2_w1_5(gc_b_b2_w1_5),
        .gc_b_b2_w1_6(gc_b_b2_w1_6),
        .gc_b_b2_w1_7(gc_b_b2_w1_7),
        .gc_b_b2_b1_0(gc_b_b2_b1_0),
        .gc_b_b2_b1_1(gc_b_b2_b1_1),
        .gc_b_b2_b1_2(gc_b_b2_b1_2),
        .gc_b_b2_b1_3(gc_b_b2_b1_3),
        .gc_b_b2_b1_4(gc_b_b2_b1_4),
        .gc_b_b2_b1_5(gc_b_b2_b1_5),
        .gc_b_b2_b1_6(gc_b_b2_b1_6),
        .gc_b_b2_b1_7(gc_b_b2_b1_7),
        .gc_b_b2_w2_0(gc_b_b2_w2_0),
        .gc_b_b2_w2_1(gc_b_b2_w2_1),
        .gc_b_b2_w2_2(gc_b_b2_w2_2),
        .gc_b_b2_w2_3(gc_b_b2_w2_3),
        .gc_b_b2_w2_4(gc_b_b2_w2_4),
        .gc_b_b2_w2_5(gc_b_b2_w2_5),
        .gc_b_b2_w2_6(gc_b_b2_w2_6),
        .gc_b_b2_w2_7(gc_b_b2_w2_7),
        .gc_b_b2_b2_0(gc_b_b2_b2_0),
        .gc_b_b2_b2_1(gc_b_b2_b2_1),
        .gc_b_b2_b2_2(gc_b_b2_b2_2),
        .gc_b_b2_b2_3(gc_b_b2_b2_3),
        .gc_b_b2_b2_4(gc_b_b2_b2_4),
        .gc_b_b2_b2_5(gc_b_b2_b2_5),
        .gc_b_b2_b2_6(gc_b_b2_b2_6),
        .gc_b_b2_b2_7(gc_b_b2_b2_7),
        .gc_b_b2_gamma0(gc_b_b2_gamma0),
        .gc_b_b2_gamma1(gc_b_b2_gamma1),
        .gc_b_b2_gamma2(gc_b_b2_gamma2),
        .gc_b_b2_gamma3(gc_b_b2_gamma3),
        .gc_b_b2_gamma4(gc_b_b2_gamma4),
        .gc_b_b2_gamma5(gc_b_b2_gamma5),
        .gc_b_b2_gamma6(gc_b_b2_gamma6),
        .gc_b_b2_gamma7(gc_b_b2_gamma7),
        .gc_b_b2_beta0(gc_b_b2_beta0),
        .gc_b_b2_beta1(gc_b_b2_beta1),
        .gc_b_b2_beta2(gc_b_b2_beta2),
        .gc_b_b2_beta3(gc_b_b2_beta3),
        .gc_b_b2_beta4(gc_b_b2_beta4),
        .gc_b_b2_beta5(gc_b_b2_beta5),
        .gc_b_b2_beta6(gc_b_b2_beta6),
        .gc_b_b2_beta7(gc_b_b2_beta7),
        .out0(out0),
        .out1(out1),
        .out2(out2),
        .out3(out3),
        .out4(out4),
        .out5(out5),
        .out6(out6),
        .out7(out7),
        .blocks4_done(blocks4_done),
        .blocks8_done(blocks8_done),
        .done(done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (blocks4_done  && !last_4)    $display("  Blocks 1-4  done");
        if (blocks8_done  && !last_8)    $display("  Blocks 5-8  done");
        if (done && !last_done) begin
            $display("  Blocks 9-12 done");
            $display("");
            $display("══════════════════════════════════════════");
            $display("HYPERION GPT-2 — 12 transformer blocks");
            $display("══════════════════════════════════════════");
            $display("");
            $display("Input:  [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",x0,x1,x2,x3,x4,x5,x6,x7);
            $display("Output: [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",out0,out1,out2,out3,out4,out5,out6,out7);
            $display("");
            $display("12 transformer blocks complete.");
            $display("This is the GPT-2 small architecture.");
            $display("Built at age 12.");
            $display("");
            $display("══════════════════════════════════════════");
            $display("Hyperion GPT-2 complete!");
            $display("══════════════════════════════════════════");
            $finish;
        end
        last_4 <= blocks4_done; last_8 <= blocks8_done; last_done <= done;
    end

    initial begin
        clk=0; reset=1; start=0;
        last_4=0; last_8=0; last_done=0;
        x0=10;x1=20;x2=30;x3=40;x4=50;x5=60;x6=70;x7=80;
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
        $display("Hyperion GPT-2 — 12 transformer blocks");
        $display("Input: [10,20,30,40,50,60,70,80]");
        $display("");
        #60000;
        $display("Timeout"); $finish;
    end
endmodule