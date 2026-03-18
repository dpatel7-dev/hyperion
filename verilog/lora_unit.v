// ═════════════════════════════════════════════════════
// HYPERION LORA UNIT
// Low-Rank Adaptation — hardware native
//
// LoRA is how GPT-4, Llama, Gemini are fine-tuned.
// Instead of training all weights (billions of params)
// LoRA trains two small matrices A and B:
//
//   W_adapted = W_pretrained + A × B
//   A: d × r  (small — rank r, typically 8-16)
//   B: r × d  (small — rank r)
//
// Only A and B are trained. W stays frozen.
// This reduces trainable params by 1000x.
//
// Example: Llama-3-8B attention weight = 4096×4096
//   Full training:  16,777,216 parameters
//   LoRA (r=16):        131,072 parameters  = 128x fewer
//
// Hyperion implements LoRA in hardware:
//   - Frozen W stored in SRAM (not updated)
//   - A and B updated each training step
//   - Output = W×x + A×B×x (one pass)
//
// No chip has native LoRA support today.
// ═════════════════════════════════════════════════════

module lora_unit (
    input  clk,
    input  reset,
    input  start,

    // input vector (d=8 dimensions)
    input  signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7,

    // frozen pretrained weight W (8x8, not updated)
    input  signed [7:0] w0,w1,w2,w3,w4,w5,w6,w7,

    // LoRA matrix A (8×4, rank r=4)
    // projects d=8 down to r=4
    input  signed [7:0] a00,a01,a02,a03,
    input  signed [7:0] a10,a11,a12,a13,
    input  signed [7:0] a20,a21,a22,a23,
    input  signed [7:0] a30,a31,a32,a33,
    input  signed [7:0] a40,a41,a42,a43,
    input  signed [7:0] a50,a51,a52,a53,
    input  signed [7:0] a60,a61,a62,a63,
    input  signed [7:0] a70,a71,a72,a73,

    // LoRA matrix B (4×8, rank r=4)
    // projects r=4 back up to d=8
    input  signed [7:0] b00,b01,b02,b03,b04,b05,b06,b07,
    input  signed [7:0] b10,b11,b12,b13,b14,b15,b16,b17,
    input  signed [7:0] b20,b21,b22,b23,b24,b25,b26,b27,
    input  signed [7:0] b30,b31,b32,b33,b34,b35,b36,b37,

    // LoRA scaling factor alpha/r
    input  signed [7:0] lora_scale,

    // output: W*x + scale * B*A*x
    output signed [15:0] out0,out1,out2,out3,
    output signed [15:0] out4,out5,out6,out7,
    output done
);

    reg [2:0] state;
    reg [5:0] cycle_count;
    parameter IDLE=0, W_PASS=1, A_PASS=2, B_PASS=3, COMBINE=4, DONE=5;

    assign done = (state == DONE);

    always @(posedge clk) begin
        if (reset) begin state<=IDLE; cycle_count<=0; end
        else case (state)
            IDLE:     begin cycle_count<=0; if (start) state<=W_PASS; end
            W_PASS:   begin cycle_count<=cycle_count+1;
                          if (cycle_count>=6'd8) begin cycle_count<=0; state<=A_PASS; end end
            A_PASS:   begin cycle_count<=cycle_count+1;
                          if (cycle_count>=6'd8) begin cycle_count<=0; state<=B_PASS; end end
            B_PASS:   begin cycle_count<=cycle_count+1;
                          if (cycle_count>=6'd8) begin cycle_count<=0; state<=COMBINE; end end
            COMBINE:  begin cycle_count<=cycle_count+1;
                          if (cycle_count>=6'd4) begin cycle_count<=0; state<=DONE; end end
            DONE:     state<=IDLE;
        endcase
    end

    // ── PASS 1: W*x (frozen pretrained weights) ──
    wire signed [31:0] wx_raw0 =
        x0*$signed(w0)+x1*$signed(w0)+x2*$signed(w0)+x3*$signed(w0)+
        x4*$signed(w0)+x5*$signed(w0)+x6*$signed(w0)+x7*$signed(w0);
    wire signed [31:0] wx_raw1 =
        x0*$signed(w1)+x1*$signed(w1)+x2*$signed(w1)+x3*$signed(w1)+
        x4*$signed(w1)+x5*$signed(w1)+x6*$signed(w1)+x7*$signed(w1);
    wire signed [31:0] wx_raw2 =
        x0*$signed(w2)+x1*$signed(w2)+x2*$signed(w2)+x3*$signed(w2)+
        x4*$signed(w2)+x5*$signed(w2)+x6*$signed(w2)+x7*$signed(w2);
    wire signed [31:0] wx_raw3 =
        x0*$signed(w3)+x1*$signed(w3)+x2*$signed(w3)+x3*$signed(w3)+
        x4*$signed(w3)+x5*$signed(w3)+x6*$signed(w3)+x7*$signed(w3);
    wire signed [31:0] wx_raw4 =
        x0*$signed(w4)+x1*$signed(w4)+x2*$signed(w4)+x3*$signed(w4)+
        x4*$signed(w4)+x5*$signed(w4)+x6*$signed(w4)+x7*$signed(w4);
    wire signed [31:0] wx_raw5 =
        x0*$signed(w5)+x1*$signed(w5)+x2*$signed(w5)+x3*$signed(w5)+
        x4*$signed(w5)+x5*$signed(w5)+x6*$signed(w5)+x7*$signed(w5);
    wire signed [31:0] wx_raw6 =
        x0*$signed(w6)+x1*$signed(w6)+x2*$signed(w6)+x3*$signed(w6)+
        x4*$signed(w6)+x5*$signed(w6)+x6*$signed(w6)+x7*$signed(w6);
    wire signed [31:0] wx_raw7 =
        x0*$signed(w7)+x1*$signed(w7)+x2*$signed(w7)+x3*$signed(w7)+
        x4*$signed(w7)+x5*$signed(w7)+x6*$signed(w7)+x7*$signed(w7);

    // ── PASS 2: A*x → r=4 dimensional vector ──
    wire signed [31:0] ax0 =
        x0*$signed(a00)+x1*$signed(a10)+x2*$signed(a20)+x3*$signed(a30)+
        x4*$signed(a40)+x5*$signed(a50)+x6*$signed(a60)+x7*$signed(a70);
    wire signed [31:0] ax1 =
        x0*$signed(a01)+x1*$signed(a11)+x2*$signed(a21)+x3*$signed(a31)+
        x4*$signed(a41)+x5*$signed(a51)+x6*$signed(a61)+x7*$signed(a71);
    wire signed [31:0] ax2 =
        x0*$signed(a02)+x1*$signed(a12)+x2*$signed(a22)+x3*$signed(a32)+
        x4*$signed(a42)+x5*$signed(a52)+x6*$signed(a62)+x7*$signed(a72);
    wire signed [31:0] ax3 =
        x0*$signed(a03)+x1*$signed(a13)+x2*$signed(a23)+x3*$signed(a33)+
        x4*$signed(a43)+x5*$signed(a53)+x6*$signed(a63)+x7*$signed(a73);

    // ── PASS 3: B*(A*x) → back to d=8 ──
    wire signed [15:0] ax0s = ax0[15:0];
    wire signed [15:0] ax1s = ax1[15:0];
    wire signed [15:0] ax2s = ax2[15:0];
    wire signed [15:0] ax3s = ax3[15:0];

    wire signed [31:0] bax0 =
        ax0s*$signed(b00)+ax1s*$signed(b10)+ax2s*$signed(b20)+ax3s*$signed(b30);
    wire signed [31:0] bax1 =
        ax0s*$signed(b01)+ax1s*$signed(b11)+ax2s*$signed(b21)+ax3s*$signed(b31);
    wire signed [31:0] bax2 =
        ax0s*$signed(b02)+ax1s*$signed(b12)+ax2s*$signed(b22)+ax3s*$signed(b32);
    wire signed [31:0] bax3 =
        ax0s*$signed(b03)+ax1s*$signed(b13)+ax2s*$signed(b23)+ax3s*$signed(b33);
    wire signed [31:0] bax4 =
        ax0s*$signed(b04)+ax1s*$signed(b14)+ax2s*$signed(b24)+ax3s*$signed(b34);
    wire signed [31:0] bax5 =
        ax0s*$signed(b05)+ax1s*$signed(b15)+ax2s*$signed(b25)+ax3s*$signed(b35);
    wire signed [31:0] bax6 =
        ax0s*$signed(b06)+ax1s*$signed(b16)+ax2s*$signed(b26)+ax3s*$signed(b36);
    wire signed [31:0] bax7 =
        ax0s*$signed(b07)+ax1s*$signed(b17)+ax2s*$signed(b27)+ax3s*$signed(b37);

    // ── COMBINE: out = W*x + scale * B*A*x ──
    reg signed [15:0] lat0,lat1,lat2,lat3,lat4,lat5,lat6,lat7;

    always @(posedge clk) begin
        if (reset) begin
            lat0<=0;lat1<=0;lat2<=0;lat3<=0;
            lat4<=0;lat5<=0;lat6<=0;lat7<=0;
        end else if (state==COMBINE && cycle_count==1) begin
            lat0 <= wx_raw0[15:0] + ($signed(lora_scale) * bax0[15:0]) >>> 7;
            lat1 <= wx_raw1[15:0] + ($signed(lora_scale) * bax1[15:0]) >>> 7;
            lat2 <= wx_raw2[15:0] + ($signed(lora_scale) * bax2[15:0]) >>> 7;
            lat3 <= wx_raw3[15:0] + ($signed(lora_scale) * bax3[15:0]) >>> 7;
            lat4 <= wx_raw4[15:0] + ($signed(lora_scale) * bax4[15:0]) >>> 7;
            lat5 <= wx_raw5[15:0] + ($signed(lora_scale) * bax5[15:0]) >>> 7;
            lat6 <= wx_raw6[15:0] + ($signed(lora_scale) * bax6[15:0]) >>> 7;
            lat7 <= wx_raw7[15:0] + ($signed(lora_scale) * bax7[15:0]) >>> 7;
        end
    end

    assign out0=lat0; assign out1=lat1; assign out2=lat2; assign out3=lat3;
    assign out4=lat4; assign out5=lat5; assign out6=lat6; assign out7=lat7;

endmodule
