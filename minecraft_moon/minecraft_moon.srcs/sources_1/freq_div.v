`timescale 1ns / 1ps

module freq_div #(parameter PERIOD = 100000) (
    input clk, rst, en,
    output reg pulse
);

reg [31:0] cnt_reg, cnt_next;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        cnt_reg <= 0;
    end else if (en) begin
        cnt_reg <= cnt_next;
    end
end

always @* begin
    cnt_next = (cnt_reg == PERIOD - 1) ? 0 : cnt_reg + 1;
    pulse = (cnt_reg == PERIOD - 1);
end

endmodule
