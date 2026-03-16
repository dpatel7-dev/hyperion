// ─────────────────────────────────────────
// HYPERION WEIGHT UPDATE UNIT
// Implements SGD weight update:
// w_new = w_old - lr * dw
//
// This closes the training loop:
// Forward → Loss → Backward → Update
//
// Same operation as PyTorch optimizer.step()
// Every LLM was trained with this operation
// ─────────────────────────────────────────

module weight_update_unit (
    input  clk,
    input  reset,
    input  enable,

    // learning rate (scaled — lr=0.01 → lr_scaled=1)
    input  [7:0] lr_scaled,

    // current weights
    input  signed [7:0] w0,w1,w2,w3,w4,w5,w6,w7,
    input  signed [7:0] w8,w9,w10,w11,w12,w13,w14,w15,

    // weight gradients from gradient unit
    input  signed [15:0] dw0,dw1,dw2,dw3,dw4,dw5,dw6,dw7,
    input  signed [15:0] dw8,dw9,dw10,dw11,dw12,dw13,dw14,dw15,

    // updated weights
    output signed [7:0] w_new0,w_new1,w_new2,w_new3,
    output signed [7:0] w_new4,w_new5,w_new6,w_new7,
    output signed [7:0] w_new8,w_new9,w_new10,w_new11,
    output signed [7:0] w_new12,w_new13,w_new14,w_new15
);

    // w_new = w_old - lr * dw
    // scale dw down before subtracting to avoid overflow
    wire signed [15:0] update0  = $signed(dw0)  >>> lr_scaled;
    wire signed [15:0] update1  = $signed(dw1)  >>> lr_scaled;
    wire signed [15:0] update2  = $signed(dw2)  >>> lr_scaled;
    wire signed [15:0] update3  = $signed(dw3)  >>> lr_scaled;
    wire signed [15:0] update4  = $signed(dw4)  >>> lr_scaled;
    wire signed [15:0] update5  = $signed(dw5)  >>> lr_scaled;
    wire signed [15:0] update6  = $signed(dw6)  >>> lr_scaled;
    wire signed [15:0] update7  = $signed(dw7)  >>> lr_scaled;
    wire signed [15:0] update8  = $signed(dw8)  >>> lr_scaled;
    wire signed [15:0] update9  = $signed(dw9)  >>> lr_scaled;
    wire signed [15:0] update10 = $signed(dw10) >>> lr_scaled;
    wire signed [15:0] update11 = $signed(dw11) >>> lr_scaled;
    wire signed [15:0] update12 = $signed(dw12) >>> lr_scaled;
    wire signed [15:0] update13 = $signed(dw13) >>> lr_scaled;
    wire signed [15:0] update14 = $signed(dw14) >>> lr_scaled;
    wire signed [15:0] update15 = $signed(dw15) >>> lr_scaled;

    // subtract update from weight and clip to int8
    wire signed [15:0] raw0  = $signed({w0[7],w0[7],w0[7],w0[7],w0[7],w0[7],w0[7],w0[7],w0})  - update0;
    wire signed [15:0] raw1  = $signed({w1[7],w1[7],w1[7],w1[7],w1[7],w1[7],w1[7],w1[7],w1})  - update1;
    wire signed [15:0] raw2  = $signed({w2[7],w2[7],w2[7],w2[7],w2[7],w2[7],w2[7],w2[7],w2})  - update2;
    wire signed [15:0] raw3  = $signed({w3[7],w3[7],w3[7],w3[7],w3[7],w3[7],w3[7],w3[7],w3})  - update3;
    wire signed [15:0] raw4  = $signed({w4[7],w4[7],w4[7],w4[7],w4[7],w4[7],w4[7],w4[7],w4})  - update4;
    wire signed [15:0] raw5  = $signed({w5[7],w5[7],w5[7],w5[7],w5[7],w5[7],w5[7],w5[7],w5})  - update5;
    wire signed [15:0] raw6  = $signed({w6[7],w6[7],w6[7],w6[7],w6[7],w6[7],w6[7],w6[7],w6})  - update6;
    wire signed [15:0] raw7  = $signed({w7[7],w7[7],w7[7],w7[7],w7[7],w7[7],w7[7],w7[7],w7})  - update7;
    wire signed [15:0] raw8  = $signed({w8[7],w8[7],w8[7],w8[7],w8[7],w8[7],w8[7],w8[7],w8})  - update8;
    wire signed [15:0] raw9  = $signed({w9[7],w9[7],w9[7],w9[7],w9[7],w9[7],w9[7],w9[7],w9})  - update9;
    wire signed [15:0] raw10 = $signed({w10[7],w10[7],w10[7],w10[7],w10[7],w10[7],w10[7],w10[7],w10}) - update10;
    wire signed [15:0] raw11 = $signed({w11[7],w11[7],w11[7],w11[7],w11[7],w11[7],w11[7],w11[7],w11}) - update11;
    wire signed [15:0] raw12 = $signed({w12[7],w12[7],w12[7],w12[7],w12[7],w12[7],w12[7],w12[7],w12}) - update12;
    wire signed [15:0] raw13 = $signed({w13[7],w13[7],w13[7],w13[7],w13[7],w13[7],w13[7],w13[7],w13}) - update13;
    wire signed [15:0] raw14 = $signed({w14[7],w14[7],w14[7],w14[7],w14[7],w14[7],w14[7],w14[7],w14}) - update14;
    wire signed [15:0] raw15 = $signed({w15[7],w15[7],w15[7],w15[7],w15[7],w15[7],w15[7],w15[7],w15}) - update15;

    // clip to int8 range [-127, 127]
    assign w_new0  = enable ? (raw0[15]  ? (raw0  < -127 ? -127 : raw0[7:0])  : (raw0  > 127 ? 127 : raw0[7:0]))  : w0;
    assign w_new1  = enable ? (raw1[15]  ? (raw1  < -127 ? -127 : raw1[7:0])  : (raw1  > 127 ? 127 : raw1[7:0]))  : w1;
    assign w_new2  = enable ? (raw2[15]  ? (raw2  < -127 ? -127 : raw2[7:0])  : (raw2  > 127 ? 127 : raw2[7:0]))  : w2;
    assign w_new3  = enable ? (raw3[15]  ? (raw3  < -127 ? -127 : raw3[7:0])  : (raw3  > 127 ? 127 : raw3[7:0]))  : w3;
    assign w_new4  = enable ? (raw4[15]  ? (raw4  < -127 ? -127 : raw4[7:0])  : (raw4  > 127 ? 127 : raw4[7:0]))  : w4;
    assign w_new5  = enable ? (raw5[15]  ? (raw5  < -127 ? -127 : raw5[7:0])  : (raw5  > 127 ? 127 : raw5[7:0]))  : w5;
    assign w_new6  = enable ? (raw6[15]  ? (raw6  < -127 ? -127 : raw6[7:0])  : (raw6  > 127 ? 127 : raw6[7:0]))  : w6;
    assign w_new7  = enable ? (raw7[15]  ? (raw7  < -127 ? -127 : raw7[7:0])  : (raw7  > 127 ? 127 : raw7[7:0]))  : w7;
    assign w_new8  = enable ? (raw8[15]  ? (raw8  < -127 ? -127 : raw8[7:0])  : (raw8  > 127 ? 127 : raw8[7:0]))  : w8;
    assign w_new9  = enable ? (raw9[15]  ? (raw9  < -127 ? -127 : raw9[7:0])  : (raw9  > 127 ? 127 : raw9[7:0]))  : w9;
    assign w_new10 = enable ? (raw10[15] ? (raw10 < -127 ? -127 : raw10[7:0]) : (raw10 > 127 ? 127 : raw10[7:0])) : w10;
    assign w_new11 = enable ? (raw11[15] ? (raw11 < -127 ? -127 : raw11[7:0]) : (raw11 > 127 ? 127 : raw11[7:0])) : w11;
    assign w_new12 = enable ? (raw12[15] ? (raw12 < -127 ? -127 : raw12[7:0]) : (raw12 > 127 ? 127 : raw12[7:0])) : w12;
    assign w_new13 = enable ? (raw13[15] ? (raw13 < -127 ? -127 : raw13[7:0]) : (raw13 > 127 ? 127 : raw13[7:0])) : w13;
    assign w_new14 = enable ? (raw14[15] ? (raw14 < -127 ? -127 : raw14[7:0]) : (raw14 > 127 ? 127 : raw14[7:0])) : w14;
    assign w_new15 = enable ? (raw15[15] ? (raw15 < -127 ? -127 : raw15[7:0]) : (raw15 > 127 ? 127 : raw15[7:0])) : w15;

endmodule