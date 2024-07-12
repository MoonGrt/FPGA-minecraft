`timescale 1ns / 1ps
`include "constants.vh"

module ppl_entry (
    input clk_ppl, rst, enable,
    input signed [31:0] p_pos_x, p_pos_y, p_pos_z,
    input signed [31:0] p_angle_x, p_angle_y,
    output is_preparing, is_eof,
    output [1:0] towards_h,
    input next_pixel_pplout,
    input [DISP_RAM_ADDR_RADIX-1:0] pixel_addr_pplout,
    input [31:0] to_color_acc_pplout,
    input [2:0] to_block_p_pplout,
    input [1:0] to_dir_pplout,
    input [2:0] to_hit_p_pplout,
    input [2:0] start_p_pplout,
    input [2:0] end_p_pplout,
    input to_is_behind_pplout,
    output idle,
    output [DISP_RAM_ADDR_RADIX-1:0] pixel_addr,
    output [31:0] color_acc,
    output [1:0] from_dir,
    output [2:0] block_p,
    output [2:0] hit_p,
    output [2:0] start_p,
    output [2:0] end_p,
    output is_behind
);

parameter PREPARE_CYCLES = 4;

reg [2:0] state, state_next;
reg [2:0] prepare_cnt, prepare_cnt_next;
wire is_eof_i, is_preparing_i;
wire [31:0] fragment_uv_x, fragment_uv_y;

wire [31:0] p_angle_x, p_angle_y;
wire [31:0] vp_origin_x,vp_origin_y, vp_origin_z;
wire [31:0] vp_u_x, vp_u_y, vp_u_z;
wire [31:0] vp_v_x, vp_v_y, vp_v_z;
wire [31:0] vp_target_x, vp_target_y, vp_target_z;
wire [31:0] towards_h_x, towards_h_y;



// State Machine
always @(posedge clk_ppl or posedge rst) begin
    if (rst) begin
        state <= 3'b000; // BEFORE_PREPARE
        prepare_cnt <= 3'b000;
    end else begin
        state <= state_next;
        prepare_cnt <= prepare_cnt_next;
    end
end

assign is_eof_i = (pixel_addr_pplout == EOF_ADDR) & next_pixel_pplout;
assign is_eof = is_eof_i;

assign is_preparing_i = (state != 3'b010); // RUNNING
assign is_preparing = is_preparing_i;

always @(state or prepare_cnt or is_eof_i) begin
    state_next = state;
    prepare_cnt_next = prepare_cnt;
    case (state)
        3'b000: // BEFORE_PREPARE
            if (prepare_cnt == PREPARE_CYCLES - 1) begin
                state_next = 3'b010; // RUNNING
                prepare_cnt_next = 3'b000;
            end else begin
                state_next = 3'b001; // PREPARING
                prepare_cnt_next = prepare_cnt + 1;
            end
        3'b001: // PREPARING
            begin
            if (prepare_cnt == PREPARE_CYCLES - 1) begin
                state_next = 3'b010; // RUNNING
            end
            prepare_cnt_next = prepare_cnt + 1;
            end
        3'b010: // RUNNING
            begin
            if (is_eof_i) begin
                state_next = 3'b000; // BEFORE_PREPARE
            end
            prepare_cnt_next = 3'b000;
            end
        default:
            ;// do nothing
    endcase
end

// Viewport
viewport_scanner vp_scan (
    .clk_ppl(clk_ppl),
    .rst(rst),
    .enable(next_pixel_pplout & ~is_preparing_i),
    .fragment_uv_x(fragment_uv_x),
    .fragment_uv_y(fragment_uv_y)
);

viewport_params vp_param (
    .p_pos_x        (p_pos_x    ), 
    .p_pos_y        (p_pos_y    ), 
    .p_pos_z        (p_pos_z    ),
    .p_angle_x      (p_angle_x  ), 
    .p_angle_y      (p_angle_y  ),
    .vp_origin_x    (vp_origin_x),
    .vp_origin_y    (vp_origin_y), 
    .vp_origin_z    (vp_origin_z),
    .vp_u_x         (vp_u_x     ), 
    .vp_u_y         (vp_u_y     ), 
    .vp_u_z         (vp_u_z     ),
    .vp_v_x         (vp_v_x     ), 
    .vp_v_y         (vp_v_y     ), 
    .vp_v_z         (vp_v_z     ),
    .towards_h_x    (towards_h_x), 
    .towards_h_y    (towards_h_y)
);

assign vp_target_x = vp_origin_x + vp_u_x * fragment_uv_x * LOOKAT_REL_FAC / ANGLE_RADIUS - vp_v_x * fragment_uv_y * LOOKAT_REL_FAC / ANGLE_RADIUS;
assign vp_target_y = vp_origin_y + vp_u_y * fragment_uv_x * LOOKAT_REL_FAC / ANGLE_RADIUS - vp_v_y * fragment_uv_y * LOOKAT_REL_FAC / ANGLE_RADIUS;
assign vp_target_z = vp_origin_z + vp_u_z * fragment_uv_x * LOOKAT_REL_FAC / ANGLE_RADIUS - vp_v_z * fragment_uv_y * LOOKAT_REL_FAC / ANGLE_RADIUS;

// Output Multiplexer
assign idle = 1'b0;
assign pixel_addr = next_pixel_pplout ? fragment_uv_y * H_REAL + fragment_uv_x : pixel_addr_pplout;
assign color_acc = next_pixel_pplout ? 0 : to_color_acc_pplout;
assign from_dir = next_pixel_pplout ? 2'b0 : to_dir_pplout;
//assign block_p = next_pixel_pplout ? p_pos / TEXTURE_RES : to_block_p_pplout;
//assign hit_p = next_pixel_pplout ? p_pos : to_hit_p_pplout;
//assign start_p = next_pixel_pplout ? p_pos : start_p_pplout;
//assign end_p = next_pixel_pplout ? vp_target : end_p_pplout;
assign is_behind = next_pixel_pplout ? 1'b0 : to_is_behind_pplout;

endmodule
