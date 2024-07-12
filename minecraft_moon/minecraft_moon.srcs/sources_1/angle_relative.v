`timescale 1ns / 1ps
`include "constants.vh"

module angle_relative (
    input signed [31:0] angle_x,
    input signed [31:0] angle_y,
    output reg signed [31:0] lookat_rel_x,
    output reg signed [31:0] lookat_rel_y,
    output reg signed [31:0] lookat_rel_z,
    output reg signed [31:0] lookat_h_rel_x,
    output reg signed [31:0] lookat_h_rel_y
);

// Internal signals
reg signed [31:0] coord_h [1:2];
reg signed [31:0] coord_v [1:2];

// Instantiate angle_to_coord module
angle_to_coord ac_cvt_h (
    .angle(angle_x),
    .coord_x(coord_h[1]),
    .coord_y(coord_h[2])
);

angle_to_coord ac_cvt_v (
    .angle(angle_y),
    .coord_x(coord_v[1]),
    .coord_y(coord_v[2])
);

// Calculate lookat_rel and lookat_h_rel
always @(*) begin
    lookat_rel_x = coord_h[1] * coord_v[1] / ANGLE_RADIUS;
    lookat_rel_y = coord_h[2] * coord_v[1] / ANGLE_RADIUS;
    lookat_rel_z = coord_v[2];
    lookat_h_rel_x = coord_h[1];
    lookat_h_rel_y = coord_h[2];
end

endmodule
