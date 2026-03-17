// HYPERION OUTPUT PROJECTION
// Final layer: hidden state → token probabilities
// input:  8-dim hidden vector
// output: 16 logits (one per token in vocabulary)
// then softmax converts logits to probabilities
module output_projection (
    input  clk, input reset,
    input  signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7,
    output signed [15:0] logit0,logit1,logit2,logit3,
    output signed [15:0] logit4,logit5,logit6,logit7,
    output signed [15:0] logit8,logit9,logit10,logit11,
    output signed [15:0] logit12,logit13,logit14,logit15
);
    assign logit0 = (x0*$signed(8'sd19)+x1*$signed(8'sd16)+x2*$signed(-8'sd7)+x3*$signed(-8'sd10)+x4*$signed(-8'sd3)+x5*$signed(-8'sd1)+x6*$signed(-8'sd15)+x7*$signed(-8'sd21)) >>> 6;
    assign logit1 = (x0*$signed(8'sd0)+x1*$signed(8'sd17)+x2*$signed(-8'sd21)+x3*$signed(8'sd30)+x4*$signed(-8'sd7)+x5*$signed(8'sd21)+x6*$signed(-8'sd5)+x7*$signed(8'sd15)) >>> 6;
    assign logit2 = (x0*$signed(8'sd17)+x1*$signed(-8'sd5)+x2*$signed(-8'sd13)+x3*$signed(8'sd27)+x4*$signed(-8'sd10)+x5*$signed(8'sd11)+x6*$signed(-8'sd22)+x7*$signed(-8'sd21)) >>> 6;
    assign logit3 = (x0*$signed(8'sd28)+x1*$signed(8'sd8)+x2*$signed(8'sd19)+x3*$signed(-8'sd27)+x4*$signed(8'sd2)+x5*$signed(-8'sd32)+x6*$signed(8'sd22)+x7*$signed(-8'sd6)) >>> 6;
    assign logit4 = (x0*$signed(8'sd14)+x1*$signed(-8'sd22)+x2*$signed(8'sd27)+x3*$signed(-8'sd7)+x4*$signed(8'sd27)+x5*$signed(-8'sd26)+x6*$signed(8'sd13)+x7*$signed(-8'sd16)) >>> 6;
    assign logit5 = (x0*$signed(-8'sd5)+x1*$signed(-8'sd12)+x2*$signed(8'sd24)+x3*$signed(-8'sd10)+x4*$signed(-8'sd10)+x5*$signed(-8'sd28)+x6*$signed(-8'sd18)+x7*$signed(-8'sd30)) >>> 6;
    assign logit6 = (x0*$signed(-8'sd11)+x1*$signed(8'sd28)+x2*$signed(8'sd21)+x3*$signed(-8'sd22)+x4*$signed(8'sd22)+x5*$signed(-8'sd21)+x6*$signed(-8'sd14)+x7*$signed(8'sd7)) >>> 6;
    assign logit7 = (x0*$signed(-8'sd32)+x1*$signed(8'sd16)+x2*$signed(8'sd10)+x3*$signed(-8'sd15)+x4*$signed(8'sd19)+x5*$signed(-8'sd7)+x6*$signed(-8'sd25)+x7*$signed(-8'sd5)) >>> 6;
    assign logit8 = (x0*$signed(8'sd24)+x1*$signed(8'sd0)+x2*$signed(8'sd19)+x3*$signed(-8'sd16)+x4*$signed(8'sd13)+x5*$signed(8'sd28)+x6*$signed(-8'sd25)+x7*$signed(-8'sd16)) >>> 6;
    assign logit9 = (x0*$signed(-8'sd13)+x1*$signed(8'sd20)+x2*$signed(-8'sd17)+x3*$signed(-8'sd20)+x4*$signed(-8'sd17)+x5*$signed(-8'sd14)+x6*$signed(8'sd5)+x7*$signed(-8'sd10)) >>> 6;
    assign logit10 = (x0*$signed(-8'sd10)+x1*$signed(8'sd20)+x2*$signed(-8'sd14)+x3*$signed(-8'sd6)+x4*$signed(8'sd8)+x5*$signed(8'sd31)+x6*$signed(-8'sd3)+x7*$signed(8'sd0)) >>> 6;
    assign logit11 = (x0*$signed(-8'sd17)+x1*$signed(8'sd14)+x2*$signed(-8'sd9)+x3*$signed(-8'sd23)+x4*$signed(8'sd4)+x5*$signed(-8'sd31)+x6*$signed(-8'sd26)+x7*$signed(8'sd11)) >>> 6;
    assign logit12 = (x0*$signed(-8'sd5)+x1*$signed(8'sd16)+x2*$signed(8'sd19)+x3*$signed(8'sd11)+x4*$signed(8'sd19)+x5*$signed(8'sd17)+x6*$signed(8'sd21)+x7*$signed(8'sd15)) >>> 6;
    assign logit13 = (x0*$signed(-8'sd21)+x1*$signed(-8'sd9)+x2*$signed(-8'sd28)+x3*$signed(8'sd15)+x4*$signed(8'sd19)+x5*$signed(8'sd24)+x6*$signed(-8'sd3)+x7*$signed(8'sd7)) >>> 6;
    assign logit14 = (x0*$signed(-8'sd4)+x1*$signed(8'sd7)+x2*$signed(-8'sd19)+x3*$signed(8'sd8)+x4*$signed(-8'sd5)+x5*$signed(-8'sd1)+x6*$signed(8'sd17)+x7*$signed(8'sd5)) >>> 6;
    assign logit15 = (x0*$signed(8'sd24)+x1*$signed(-8'sd22)+x2*$signed(8'sd24)+x3*$signed(8'sd21)+x4*$signed(8'sd0)+x5*$signed(-8'sd24)+x6*$signed(8'sd5)+x7*$signed(8'sd9)) >>> 6;
endmodule