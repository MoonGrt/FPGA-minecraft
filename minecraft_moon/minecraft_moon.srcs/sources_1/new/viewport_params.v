`timescale 1ns / 1ps
`include "constants.vh"

module viewport_params (
    input signed [31:0] p_pos_x, p_pos_y, p_pos_z,
    input signed [31:0] p_angle_x, p_angle_y,
    output reg signed [31:0] vp_origin_x,vp_origin_y, vp_origin_z,
    output reg signed [31:0] vp_u_x, vp_u_y, vp_u_z,
    output reg signed [31:0] vp_v_x, vp_v_y, vp_v_z,
    output reg signed [31:0] towards_h_x, towards_h_y
);

angle_relative angle_relatives (
    .angle_x        (angle_x       ),
    .angle_y        (angle_y       ),
    .lookat_rel_x   (lookat_rel_x  ),  
    .lookat_rel_y   (lookat_rel_y  ),  
    .lookat_rel_z   (lookat_rel_z  ),  
    .lookat_h_rel_x (lookat_h_rel_x),
    .lookat_h_rel_y (lookat_h_rel_y) 
);

always @(*) begin
    vp_u_x = lookat_h_rel_y;
    vp_u_y = -lookat_h_rel_x;
    vp_u_z = 0;

    vp_v_x = (vp_u_y * lookat_rel_z) - (vp_u_z * lookat_rel_y) / ANGLE_RADIUS; // cross product
    vp_v_y = (vp_u_z * lookat_rel_x) - (vp_u_x * lookat_rel_z) / ANGLE_RADIUS; // cross product
    vp_v_z = (vp_u_x * lookat_rel_y) - (vp_u_y * lookat_rel_x) / ANGLE_RADIUS; // cross product

    vp_origin_x = p_pos_x + (lookat_rel_x - vp_u_x * H_REAL / 2 / ANGLE_RADIUS 
                    + vp_v_x * V_REAL / 2 / ANGLE_RADIUS) * LOOKAT_REL_FAC;
    vp_origin_y = p_pos_y + (lookat_rel_y - vp_u_y * H_REAL / 2 / ANGLE_RADIUS 
                    + vp_v_y * V_REAL / 2 / ANGLE_RADIUS) * LOOKAT_REL_FAC;
    vp_origin_z = p_pos_z + (lookat_rel_z - vp_u_z * H_REAL / 2 / ANGLE_RADIUS 
                    + vp_v_z * V_REAL / 2 / ANGLE_RADIUS) * LOOKAT_REL_FAC;

    towards_h_x = lookat_h_rel_x;
    towards_h_y = lookat_h_rel_y;
end

endmodule
