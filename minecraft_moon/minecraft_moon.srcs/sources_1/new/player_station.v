`timescale 1ns / 1ps
`include "constants.vh"

module player_station (
    input wire clk,
    input wire rst,
    input wire enable,
    input wire left_click,
    input wire right_click,
    input wire [INT_RADIX-1:0] block_p_sel,
    input wire [INT_RADIX-1:0] block_p_inc,
    output reg mani_enable,
    output reg [INT_RADIX-1:0] block_p_target,
    output reg [INT_RADIX-1:0] idx_target,
    input wire last_item_click,
    input wire next_item_click,
    output reg [INT_RADIX-1:0] current_item,
    input wire [INT_RADIX-1:0] move_lr_offset,
    input wire [INT_RADIX-1:0] move_fb_offset,
    input wire [INT_RADIX-1:0] move_ud_offset,
    input wire [INT_RADIX-1:0] angle_lr_offset,
    input wire [INT_RADIX-1:0] angle_ud_offset,
    input wire [INT_RADIX-1:0] towards_h_x,
    input wire [INT_RADIX-1:0] towards_h_y,
    output reg [INT_RADIX-1:0] current_pos_x,
    output reg [INT_RADIX-1:0] current_pos_y,
    output reg [INT_RADIX-1:0] current_pos_z,
    output reg [INT_RADIX-1:0] current_angle_x,
    output reg [INT_RADIX-1:0] current_angle_y
);
    parameter BTN_UPDATE_FREQ = 8;
    parameter CONT_UPDATE_FREQ = 75;

    wire btn_pulse, ctrl_pulse;
    reg [INT_RADIX-1:0] current_item_reg;
    reg [INT_RADIX-1:0] front_vec_x, front_vec_y, front_vec_z;
    reg [INT_RADIX-1:0] right_vec_x, right_vec_y, right_vec_z;
    reg [INT_RADIX-1:0] current_pos_reg_x, current_pos_next_x;
    reg [INT_RADIX-1:0] current_pos_reg_y, current_pos_next_y;
    reg [INT_RADIX-1:0] current_pos_reg_z, current_pos_next_z;
    reg [INT_RADIX-1:0] current_angle_reg_x, current_angle_next_x;
    reg [INT_RADIX-1:0] current_angle_reg_y, current_angle_next_y;

    frequency_divider #(
        .PERIOD(PPL_FREQ / BTN_UPDATE_FREQ)
    ) btn_freq_div (
        .clk(clk),
        .rst(rst),
        .en(enable),
        .pulse(btn_pulse)
    );

    frequency_divider #(
        .PERIOD(PPL_FREQ / CONT_UPDATE_FREQ)
    ) ctrl_freq_div (
        .clk(clk),
        .rst(rst),
        .en(enable),
        .pulse(ctrl_pulse)
    );

    // Manipulation
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mani_enable <= 0;
            block_p_target <= 0;
            idx_target <= 0;
        end else begin
            mani_enable <= btn_pulse & (left_click | right_click);
            block_p_target <= right_click ? block_p_inc : block_p_sel;
            idx_target <= right_click ? current_item : 0;
        end
    end

    // Inventory
    inventory_register inventory_reg (
        .clk(clk),
        .rst(rst),
        .enable(btn_pulse),
        .last_item(last_item_click),
        .next_item(next_item_click),
        .current_item(current_item_reg)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_item_reg <= 0;
        end else begin
            current_item_reg <= inventory_reg.current_item;
        end
    end

    // Movement
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_pos_reg_x <= 470 * 16;
            current_pos_reg_y <= 470 * 16;
            current_pos_reg_z <= 280 * 16;
            current_angle_reg_x <= 30;
            current_angle_reg_y <= -120;
        end else if (ctrl_pulse) begin
            current_pos_reg_x <= current_pos_next_x;
            current_pos_reg_y <= current_pos_next_y;
            current_pos_reg_z <= current_pos_next_z;
            current_angle_reg_x <= current_angle_next_x;
            current_angle_reg_y <= current_angle_next_y;
        end
    end

    always @(posedge clk) begin
        front_vec_x <= towards_h_y;
        front_vec_y <= -towards_h_x;
        front_vec_z <= 0;
        right_vec_x <= towards_h_x;
        right_vec_y <= towards_h_y;
        right_vec_z <= 0;
        current_pos_next_x <= current_pos_x + front_vec_x * move_fb_offset * POS_STEP / PSS_MIDDLE / ANGLE_RADIUS + right_vec_x * move_lr_offset * POS_STEP / PSS_MIDDLE / ANGLE_RADIUS;
        current_pos_next_y <= current_pos_y + front_vec_y * move_fb_offset * POS_STEP / PSS_MIDDLE / ANGLE_RADIUS + right_vec_y * move_lr_offset * POS_STEP / PSS_MIDDLE / ANGLE_RADIUS;
        current_pos_next_z <= current_pos_z + move_ud_offset * POS_STEP / PSS_MIDDLE;
        current_angle_next_x <= current_angle_x - angle_lr_offset * ANGLE_STEP / PSS_MIDDLE;
        current_angle_next_y <= current_angle_y + angle_ud_offset * ANGLE_STEP / PSS_MIDDLE;
    end

    always @(posedge clk) begin
        current_pos_x <= current_pos_reg_x;
        current_pos_y <= current_pos_reg_y;
        current_pos_z <= current_pos_reg_z;
        current_angle_x <= current_angle_reg_x;
        current_angle_y <= current_angle_reg_y;
    end
endmodule