`timescale 1ns / 1ps
`include "constants.vh"

module viewport_scanner (
    input clk_ppl,
    input rst,
    input enable,
    output signed [31:0] fragment_uv_x, fragment_uv_y
);

reg [31:0] h_cnt_reg, h_cnt_next;
reg [31:0] v_cnt_reg, v_cnt_next;

always @(posedge clk_ppl or posedge rst) begin
    if (rst) begin
        h_cnt_reg <= 0;
        v_cnt_reg <= 0;
    end else if (enable) begin
        h_cnt_reg <= h_cnt_next;
        v_cnt_reg <= v_cnt_next;
    end
end

always @(posedge clk_ppl) begin
    h_cnt_next <= (h_cnt_reg == (H_REAL - 1)) ? 0 : (h_cnt_reg + 1);
    v_cnt_next <= (h_cnt_reg != (H_REAL - 1)) ? v_cnt_reg :
                  (v_cnt_reg == (V_REAL - 1)) ? 0 :
                  (v_cnt_reg + 1);
end

assign fragment_uv_x = h_cnt_reg;
assign fragment_uv_y = v_cnt_reg;

endmodule
