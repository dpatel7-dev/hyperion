// ─────────────────────────────────────────
// HYPERION GRADIENT UNIT v2
// Backward pass for training
// Fixed timing and bit width issues
// ─────────────────────────────────────────

module gradient_unit (
    input  clk,
    input  reset,
    input  start,

    input  signed [7:0]  x0,x1,x2,x3,x4,x5,x6,x7,
    input  signed [7:0]  x8,x9,x10,x11,x12,x13,x14,x15,
    input  signed [15:0] g0,g1,g2,g3,g4,g5,g6,g7,
    input  signed [15:0] g8,g9,g10,g11,g12,g13,g14,g15,
    input  signed [7:0]  w0,w1,w2,w3,w4,w5,w6,w7,
    input  signed [7:0]  w8,w9,w10,w11,w12,w13,w14,w15,

    output signed [15:0] dw0,dw1,dw2,dw3,dw4,dw5,dw6,dw7,
    output signed [15:0] dw8,dw9,dw10,dw11,dw12,dw13,dw14,dw15,
    output signed [15:0] db0,db1,db2,db3,db4,db5,db6,db7,
    output signed [15:0] db8,db9,db10,db11,db12,db13,db14,db15,
    output signed [15:0] dx0,dx1,dx2,dx3,dx4,dx5,dx6,dx7,
    output signed [15:0] dx8,dx9,dx10,dx11,dx12,dx13,dx14,dx15,
    output done
);

    reg [2:0] state;
    reg [6:0] cycle_count;  // 7 bits — counts to 127

    parameter IDLE   = 3'd0;
    parameter GRAD_W = 3'd1;
    parameter GRAD_X = 3'd2;
    parameter GRAD_B = 3'd3;
    parameter DONE   = 3'd4;

    assign done = (state == DONE);

    always @(posedge clk) begin
        if (reset) begin
            state       <= IDLE;
            cycle_count <= 0;
        end else begin
            case (state)
                IDLE: begin
                    cycle_count <= 0;
                    if (start) state <= GRAD_W;
                end
                GRAD_W: begin
                    cycle_count <= cycle_count + 1;
                    if (cycle_count >= 7'd20) begin
                        cycle_count <= 0;
                        state <= GRAD_X;
                    end
                end
                GRAD_X: begin
                    cycle_count <= cycle_count + 1;
                    if (cycle_count >= 7'd20) begin
                        cycle_count <= 0;
                        state <= GRAD_B;
                    end
                end
                GRAD_B: begin
                    cycle_count <= cycle_count + 1;
                    if (cycle_count >= 7'd5) begin
                        cycle_count <= 0;
                        state <= DONE;
                    end
                end
                DONE: state <= IDLE;
            endcase
        end
    end

    // ── dL/dW = x * g (outer product, row 0) ──
    // dw[col] = x0 * g[col]
    wire signed [23:0] dw_raw0  = $signed(x0) * $signed(g0[7:0]);
    wire signed [23:0] dw_raw1  = $signed(x0) * $signed(g1[7:0]);
    wire signed [23:0] dw_raw2  = $signed(x0) * $signed(g2[7:0]);
    wire signed [23:0] dw_raw3  = $signed(x0) * $signed(g3[7:0]);
    wire signed [23:0] dw_raw4  = $signed(x0) * $signed(g4[7:0]);
    wire signed [23:0] dw_raw5  = $signed(x0) * $signed(g5[7:0]);
    wire signed [23:0] dw_raw6  = $signed(x0) * $signed(g6[7:0]);
    wire signed [23:0] dw_raw7  = $signed(x0) * $signed(g7[7:0]);
    wire signed [23:0] dw_raw8  = $signed(x0) * $signed(g8[7:0]);
    wire signed [23:0] dw_raw9  = $signed(x0) * $signed(g9[7:0]);
    wire signed [23:0] dw_raw10 = $signed(x0) * $signed(g10[7:0]);
    wire signed [23:0] dw_raw11 = $signed(x0) * $signed(g11[7:0]);
    wire signed [23:0] dw_raw12 = $signed(x0) * $signed(g12[7:0]);
    wire signed [23:0] dw_raw13 = $signed(x0) * $signed(g13[7:0]);
    wire signed [23:0] dw_raw14 = $signed(x0) * $signed(g14[7:0]);
    wire signed [23:0] dw_raw15 = $signed(x0) * $signed(g15[7:0]);

    assign dw0  = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw0[15:0]  : 16'sd0;
    assign dw1  = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw1[15:0]  : 16'sd0;
    assign dw2  = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw2[15:0]  : 16'sd0;
    assign dw3  = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw3[15:0]  : 16'sd0;
    assign dw4  = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw4[15:0]  : 16'sd0;
    assign dw5  = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw5[15:0]  : 16'sd0;
    assign dw6  = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw6[15:0]  : 16'sd0;
    assign dw7  = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw7[15:0]  : 16'sd0;
    assign dw8  = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw8[15:0]  : 16'sd0;
    assign dw9  = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw9[15:0]  : 16'sd0;
    assign dw10 = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw10[15:0] : 16'sd0;
    assign dw11 = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw11[15:0] : 16'sd0;
    assign dw12 = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw12[15:0] : 16'sd0;
    assign dw13 = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw13[15:0] : 16'sd0;
    assign dw14 = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw14[15:0] : 16'sd0;
    assign dw15 = (state==GRAD_W||state==GRAD_X||state==GRAD_B||state==DONE) ? dw_raw15[15:0] : 16'sd0;

    // ── dL/db = g (bias gradient = upstream gradient) ──
    assign db0  = (state==GRAD_B||state==DONE) ? g0  : 16'sd0;
    assign db1  = (state==GRAD_B||state==DONE) ? g1  : 16'sd0;
    assign db2  = (state==GRAD_B||state==DONE) ? g2  : 16'sd0;
    assign db3  = (state==GRAD_B||state==DONE) ? g3  : 16'sd0;
    assign db4  = (state==GRAD_B||state==DONE) ? g4  : 16'sd0;
    assign db5  = (state==GRAD_B||state==DONE) ? g5  : 16'sd0;
    assign db6  = (state==GRAD_B||state==DONE) ? g6  : 16'sd0;
    assign db7  = (state==GRAD_B||state==DONE) ? g7  : 16'sd0;
    assign db8  = (state==GRAD_B||state==DONE) ? g8  : 16'sd0;
    assign db9  = (state==GRAD_B||state==DONE) ? g9  : 16'sd0;
    assign db10 = (state==GRAD_B||state==DONE) ? g10 : 16'sd0;
    assign db11 = (state==GRAD_B||state==DONE) ? g11 : 16'sd0;
    assign db12 = (state==GRAD_B||state==DONE) ? g12 : 16'sd0;
    assign db13 = (state==GRAD_B||state==DONE) ? g13 : 16'sd0;
    assign db14 = (state==GRAD_B||state==DONE) ? g14 : 16'sd0;
    assign db15 = (state==GRAD_B||state==DONE) ? g15 : 16'sd0;

    // ── dL/dX = g × w^T ──
    // dx[i] = sum_j(g[j] * w[j]) for each input position
    wire signed [23:0] dx_raw0 =
        $signed(g0[7:0])*$signed(w0)   + $signed(g1[7:0])*$signed(w1)   +
        $signed(g2[7:0])*$signed(w2)   + $signed(g3[7:0])*$signed(w3)   +
        $signed(g4[7:0])*$signed(w4)   + $signed(g5[7:0])*$signed(w5)   +
        $signed(g6[7:0])*$signed(w6)   + $signed(g7[7:0])*$signed(w7)   +
        $signed(g8[7:0])*$signed(w8)   + $signed(g9[7:0])*$signed(w9)   +
        $signed(g10[7:0])*$signed(w10) + $signed(g11[7:0])*$signed(w11) +
        $signed(g12[7:0])*$signed(w12) + $signed(g13[7:0])*$signed(w13) +
        $signed(g14[7:0])*$signed(w14) + $signed(g15[7:0])*$signed(w15);

    assign dx0  = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx1  = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx2  = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx3  = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx4  = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx5  = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx6  = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx7  = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx8  = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx9  = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx10 = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx11 = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx12 = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx13 = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx14 = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;
    assign dx15 = (state==GRAD_X||state==GRAD_B||state==DONE) ? dx_raw0[15:0] : 16'sd0;

endmodule
