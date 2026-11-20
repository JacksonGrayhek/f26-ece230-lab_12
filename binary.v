// Implement binary state machine

module binary (
    input w,
    input clk,
    input reset,
    output [2:0] state,
    output z
);

wire [2:0] next;

assign z = ~state[2] & state[1] & ~state[0] | state[2] & ~state[1] & ~state[0];
assign next[0] = ~w & ~state[0] & ~state[1] | ~state[0] & w & ~state[2] | state[0] & ~w & state[1] | w & ~state[2] & ~state[1];
assign next[1] = ~state[0] & state[1] | state[0] & ~state[1] | ~state[0] & w & ~state[2];
assign next[2] = state[0] & w & state[1] | w & state[2];


dff A (
    .Default(1'b0),
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

endmodule
