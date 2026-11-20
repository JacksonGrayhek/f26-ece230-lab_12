// Implement one-hot state machine
module onehot (
    input w,
    input clk,
    output [4:0] state,
    input reset,
    output z
);

wire [4:0] next;

assign z = state[2] | state[4];
assign next[0] = 0;
assign next[1] = ~w & (state[0] | state[3] | state[4]);
assign next[2] = (~w & state[2]) | (state[1] & ~w);
assign next[3] = w & (state[0] | state[1] | state[2]);
assign next[4] = (w & state[4]) | (w & state[3]);

dff A (
    .Default(1'b1),
    .D(next[0]),
    .clk(clk),
    .reset(reset),
    .Q(state[0])
);

dff B (
    .Default(1'b0),
    .D(next[1]),
    .clk(clk),
    .reset(reset),
    .Q(state[1])
);

dff C (
    .Default(1'b0),
    .D(next[2]),
    .clk(clk),
    .reset(reset),
    .Q(state[2])
);

dff D (
    .Default(1'b0),
    .D(next[3]),
    .clk(clk),
    .reset(reset),
    .Q(state[3])
);

dff E (
    .Default(1'b0),
    .D(next[4]),
    .clk(clk),
    .reset(reset),
    .Q(state[4])
);

endmodule
