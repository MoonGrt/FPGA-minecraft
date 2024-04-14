`timescale 1ns / 1ps
`include "constants.vh"

module inventory_register (
    input clk, rst, enable,
    input last_item, next_item,
    output [4:0] current_item
);

reg [4:0] current_item_reg, current_item_next;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        current_item_reg <= 5'b0;
    end else if (enable) begin
        current_item_reg <= current_item_next;
    end
end

always @* begin
    case ({next_item, last_item})
        2'b10: current_item_next = (current_item_reg == (BLOCK_TYPE - 1)) ? (5'b00000) : (current_item_reg + 1);
        2'b01: current_item_next = (current_item_reg == (5'b00000)) ? (BLOCK_TYPE - 1) : (current_item_reg - 1);
        default: current_item_next = current_item_reg;
    endcase
end

assign current_item = current_item_reg;

endmodule
