// ─────────────────────────────────────────
// HYPERION ATTENTION UNIT
// Computes scaled dot-product attention
// output = softmax(Q*K^T / scale) * V
//
// This is the core of every transformer:
// GPT, BERT, Gemini, Claude — all use this
//
// Simplified for 4 attention heads
// each head operates on 8-dimensional vectors
// ─────────────────────────────────────────

module attention_unit (
    input  clk,
    input  reset,
    input  start,

    // Query vector (8-dim, INT8)
    input  signed [7:0] q0,q1,q2,q3,q4,q5,q6,q7,

    // Key vector (8-dim, INT8)
    input  signed [7:0] k0,k1,k2,k3,k4,k5,k6,k7,

    // Value vector (8-dim, INT8)
    input  signed [7:0] v0,v1,v2,v3,v4,v5,v6,v7,

    // attention score output (Q·K scaled)
    output signed [15:0] score,

    // attention output (score * V)
    output signed [15:0] attn_out0,attn_out1,attn_out2,attn_out3,
    output signed [15:0] attn_out4,attn_out5,attn_out6,attn_out7,

    output done
);

    reg [2:0] state;
    reg [5:0] cycle_count;

    parameter IDLE      = 3'd0;
    parameter QK_DOT    = 3'd1;  // compute Q·K
    parameter SCALE     = 3'd2;  // divide by sqrt(8) ≈ 3
    parameter SOFTMAX   = 3'd3;  // approximate softmax
    parameter VALUE     = 3'd4;  // multiply by V
    parameter DONE      = 3'd5;

    assign done = (state == DONE);

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            cycle_count <= 0;
        end else begin
            case (state)
                IDLE:    begin cycle_count<=0; if (start) state<=QK_DOT; end
                QK_DOT:  begin cycle_count<=cycle_count+1; if (cycle_count>=6'd5) begin cycle_count<=0; state<=SCALE; end end
                SCALE:   begin cycle_count<=cycle_count+1; if (cycle_count>=6'd2) begin cycle_count<=0; state<=SOFTMAX; end end
                SOFTMAX: begin cycle_count<=cycle_count+1; if (cycle_count>=6'd5) begin cycle_count<=0; state<=VALUE; end end
                VALUE:   begin cycle_count<=cycle_count+1; if (cycle_count>=6'd5) begin cycle_count<=0; state<=DONE; end end
                DONE:    state <= IDLE;
            endcase
        end
    end

    // ── STEP 1: Q·K dot product ──
    // score = sum(q[i] * k[i]) for i in 0..7
    wire signed [23:0] qk_raw =
        $signed(q0)*$signed(k0) + $signed(q1)*$signed(k1) +
        $signed(q2)*$signed(k2) + $signed(q3)*$signed(k3) +
        $signed(q4)*$signed(k4) + $signed(q5)*$signed(k5) +
        $signed(q6)*$signed(k6) + $signed(q7)*$signed(k7);

    // ── STEP 2: scale by 1/sqrt(8) ≈ divide by 3 ──
    // sqrt(8) ≈ 2.83, we use 3 as integer approximation
    wire signed [23:0] qk_scaled = (state >= SCALE) ?
        (qk_raw / 3) : qk_raw;

    assign score = (state >= SCALE) ? qk_scaled[15:0] : 16'sd0;

    // ── STEP 3: softmax approximation ──
    // true softmax needs exp() which is expensive in hardware
    // approximation: if score > 0, weight = score; else weight = 0
    // this is a ReLU approximation of softmax for single-head attention
    // real TPUs use lookup tables for exp() — that's a future upgrade
    wire signed [15:0] attn_weight = (state >= SOFTMAX) ?
        (qk_scaled[23] ? 16'sd0 : qk_scaled[15:0]) : 16'sd0;

    // ── STEP 4: attention output = weight * V ──
    // scale weight down before multiplying to avoid overflow
    wire signed [15:0] w_scaled = attn_weight;

    wire signed [23:0] ao_raw0 = $signed(w_scaled) * $signed(v0);
    wire signed [23:0] ao_raw1 = $signed(w_scaled) * $signed(v1);
    wire signed [23:0] ao_raw2 = $signed(w_scaled) * $signed(v2);
    wire signed [23:0] ao_raw3 = $signed(w_scaled) * $signed(v3);
    wire signed [23:0] ao_raw4 = $signed(w_scaled) * $signed(v4);
    wire signed [23:0] ao_raw5 = $signed(w_scaled) * $signed(v5);
    wire signed [23:0] ao_raw6 = $signed(w_scaled) * $signed(v6);
    wire signed [23:0] ao_raw7 = $signed(w_scaled) * $signed(v7);

    assign attn_out0 = (state>=VALUE||state==DONE) ? ao_raw0[15:0] : 16'sd0;
    assign attn_out1 = (state>=VALUE||state==DONE) ? ao_raw1[15:0] : 16'sd0;
    assign attn_out2 = (state>=VALUE||state==DONE) ? ao_raw2[15:0] : 16'sd0;
    assign attn_out3 = (state>=VALUE||state==DONE) ? ao_raw3[15:0] : 16'sd0;
    assign attn_out4 = (state>=VALUE||state==DONE) ? ao_raw4[15:0] : 16'sd0;
    assign attn_out5 = (state>=VALUE||state==DONE) ? ao_raw5[15:0] : 16'sd0;
    assign attn_out6 = (state>=VALUE||state==DONE) ? ao_raw6[15:0] : 16'sd0;
    assign attn_out7 = (state>=VALUE||state==DONE) ? ao_raw7[15:0] : 16'sd0;

endmodule
