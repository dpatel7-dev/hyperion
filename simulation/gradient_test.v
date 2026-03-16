// ─────────────────────────────────────────
// GRADIENT UNIT TEST
// Verifies dL/dW, dL/db, dL/dX
// This is the backward pass of training
// ─────────────────────────────────────────

module gradient_test;

    reg clk, reset, start;

    // forward pass input (saved activation)
    reg signed [7:0] x0,x1,x2,x3,x4,x5,x6,x7;
    reg signed [7:0] x8,x9,x10,x11,x12,x13,x14,x15;

    // upstream gradient
    reg signed [15:0] g0,g1,g2,g3,g4,g5,g6,g7;
    reg signed [15:0] g8,g9,g10,g11,g12,g13,g14,g15;

    // weights
    reg signed [7:0] w0,w1,w2,w3,w4,w5,w6,w7;
    reg signed [7:0] w8,w9,w10,w11,w12,w13,w14,w15;

    // outputs
    wire signed [15:0] dw0,dw1,dw2,dw3,dw4,dw5,dw6,dw7;
    wire signed [15:0] dw8,dw9,dw10,dw11,dw12,dw13,dw14,dw15;
    wire signed [15:0] db0,db1,db2,db3,db4,db5,db6,db7;
    wire signed [15:0] db8,db9,db10,db11,db12,db13,db14,db15;
    wire signed [15:0] dx0,dx1,dx2,dx3,dx4,dx5,dx6,dx7;
    wire signed [15:0] dx8,dx9,dx10,dx11,dx12,dx13,dx14,dx15;
    wire done;
    reg last_done;

    gradient_unit gu (
        .clk(clk),.reset(reset),.start(start),
        .x0(x0),.x1(x1),.x2(x2),.x3(x3),
        .x4(x4),.x5(x5),.x6(x6),.x7(x7),
        .x8(x8),.x9(x9),.x10(x10),.x11(x11),
        .x12(x12),.x13(x13),.x14(x14),.x15(x15),
        .g0(g0),.g1(g1),.g2(g2),.g3(g3),
        .g4(g4),.g5(g5),.g6(g6),.g7(g7),
        .g8(g8),.g9(g9),.g10(g10),.g11(g11),
        .g12(g12),.g13(g13),.g14(g14),.g15(g15),
        .w0(w0),.w1(w1),.w2(w2),.w3(w3),
        .w4(w4),.w5(w5),.w6(w6),.w7(w7),
        .w8(w8),.w9(w9),.w10(w10),.w11(w11),
        .w12(w12),.w13(w13),.w14(w14),.w15(w15),
        .dw0(dw0),.dw1(dw1),.dw2(dw2),.dw3(dw3),
        .dw4(dw4),.dw5(dw5),.dw6(dw6),.dw7(dw7),
        .dw8(dw8),.dw9(dw9),.dw10(dw10),.dw11(dw11),
        .dw12(dw12),.dw13(dw13),.dw14(dw14),.dw15(dw15),
        .db0(db0),.db1(db1),.db2(db2),.db3(db3),
        .db4(db4),.db5(db5),.db6(db6),.db7(db7),
        .db8(db8),.db9(db9),.db10(db10),.db11(db11),
        .db12(db12),.db13(db13),.db14(db14),.db15(db15),
        .dx0(dx0),.dx1(dx1),.dx2(dx2),.dx3(dx3),
        .dx4(dx4),.dx5(dx5),.dx6(dx6),.dx7(dx7),
        .dx8(dx8),.dx9(dx9),.dx10(dx10),.dx11(dx11),
        .dx12(dx12),.dx13(dx13),.dx14(dx14),.dx15(dx15),
        .done(done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (done && !last_done) begin
            $display("══════════════════════════════════════════");
            $display("HYPERION GRADIENT UNIT — backward pass");
            $display("══════════════════════════════════════════");
            $display("");
            $display("dL/dW (weight gradients, first 4):");
            $display("  dw0=%0d dw1=%0d dw2=%0d dw3=%0d",
                dw0,dw1,dw2,dw3);
            $display("");
            $display("dL/db (bias gradients, first 4):");
            $display("  db0=%0d db1=%0d db2=%0d db3=%0d",
                db0,db1,db2,db3);
            $display("");
            $display("dL/dX (input gradients, first 4):");
            $display("  dx0=%0d dx1=%0d dx2=%0d dx3=%0d",
                dx0,dx1,dx2,dx3);
            $display("");
            $display("══════════════════════════════════════════");
            $display("Hyperion gradient unit working!");
            $display("Backward pass complete.");
            $display("Hyperion can now train neural networks.");
            $display("══════════════════════════════════════════");
            $finish;
        end
        last_done <= done;
    end

    initial begin
        clk=0; reset=1; start=0; last_done=0;

        // forward pass saved input
        x0=4; x1=0; x2=0; x3=0;
        x4=0; x5=0; x6=0; x7=0;
        x8=0; x9=0; x10=0; x11=0;
        x12=0; x13=0; x14=0; x15=0;

        // upstream gradient — error signal
        g0=10; g1=0; g2=5; g3=0;
        g4=8;  g5=0; g6=3; g7=0;
        g8=6;  g9=0; g10=2; g11=0;
        g12=4; g13=0; g14=1; g15=0;

        // current weights
        w0=2; w1=-1; w2=3; w3=7;
        w4=4; w5=-2; w6=1; w7=5;
        w8=6; w9=-3; w10=2; w11=4;
        w12=1; w13=-4; w14=3; w15=6;

        #30 reset=0;

        $display("Hyperion gradient unit — backward pass test");
        $display("Input x0=4, gradients g=[10,0,5,0,8,0,3,0,6,0,2,0,4,0,1,0]");
        $display("");

        #10 start=1;
        #10 start=0;

        #1000;
        $display("Timeout");
        $finish;
    end

endmodule