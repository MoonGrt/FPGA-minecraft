`timescale 1ns / 1ps
`include "constants.vh"

module angle_to_coord (
    input  wire [31:0] angle,
    output wire [31:0] coord_x,
    output wire [31:0] coord_y
);

integer ang;

reg [31:0] x_mapped, y_mapped;
reg x_inverse, y_inverse, xy_inverse;
wire [31:0] coord_rev_x, coord_rev_y;

assign coord_rev_x = (xy_inverse == 1'b0) ? x_mapped : y_mapped;
assign coord_rev_y = (xy_inverse == 1'b0) ? y_mapped : x_mapped;

assign coord_x = (x_inverse == 1'b0) ? coord_rev_x : -coord_rev_x;
assign coord_y = (y_inverse == 1'b0) ? coord_rev_y : -coord_rev_y;

always @(angle) begin
    ang = angle % ANGLE_MODULO;
    x_inverse = 1'b0;
    y_inverse = 1'b0;
    xy_inverse = 1'b0;
    if (ang > ANGLE_HALF) begin
        ang = ANGLE_MODULO - ang;
        y_inverse = 1'b1;
    end
    if (ang > ANGLE_QUARTER) begin
        ang = ANGLE_HALF - ang;
        x_inverse = 1'b1;
    end
    if (ang > ANGLE_EIGHTH) begin
        ang = ANGLE_QUARTER - ang;
        xy_inverse = 1'b1;
    end
    y_mapped = ang;
end

always @(y_mapped) begin
    case (y_mapped)
        8'd0, 8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8, 8'd9, 8'd10, 8'd11, 8'd12, 8'd13: x_mapped = 8'd225;
        8'd14, 8'd15, 8'd16, 8'd17, 8'd18, 8'd19, 8'd20, 8'd21, 8'd22, 8'd23, 8'd24: x_mapped = 8'd224;
        8'd25, 8'd26, 8'd27, 8'd28, 8'd29, 8'd30, 8'd31, 8'd32, 8'd33: x_mapped = 8'd223;
        8'd34, 8'd35, 8'd36, 8'd37, 8'd38: x_mapped = 8'd222;
        8'd39, 8'd40, 8'd41, 8'd42, 8'd43, 8'd44: x_mapped = 8'd221;
        8'd45, 8'd46, 8'd47, 8'd48: x_mapped = 8'd220;
        8'd49, 8'd50, 8'd51, 8'd52, 8'd53: x_mapped = 8'd219;
        8'd54, 8'd55, 8'd56, 8'd57: x_mapped = 8'd218;
        8'd58, 8'd59, 8'd60: x_mapped = 8'd217;
        8'd61, 8'd62, 8'd63, 8'd64: x_mapped = 8'd216;
        8'd65, 8'd66, 8'd67: x_mapped = 8'd215;
        8'd68, 8'd69, 8'd70: x_mapped = 8'd214;
        8'd71, 8'd72, 8'd73: x_mapped = 8'd213;
        8'd74, 8'd75, 8'd76: x_mapped = 8'd212;
        8'd77, 8'd78: x_mapped = 8'd211;
        8'd79, 8'd80, 8'd81: x_mapped = 8'd210;
        8'd82, 8'd83, 8'd84: x_mapped = 8'd209;
        8'd85, 8'd86: x_mapped = 8'd208;
        8'd87, 8'd88: x_mapped = 8'd207;
        8'd89, 8'd90, 8'd91: x_mapped = 8'd206;
        8'd92, 8'd93: x_mapped = 8'd205;
        8'd94, 8'd95: x_mapped = 8'd204;
        8'd96, 8'd97: x_mapped = 8'd203;
        8'd98, 8'd99: x_mapped = 8'd202;
        8'd100, 8'd101: x_mapped = 8'd201;
        8'd102, 8'd103: x_mapped = 8'd200;
        8'd104, 8'd105: x_mapped = 8'd199;
        8'd106, 8'd107: x_mapped = 8'd198;
        8'd108: x_mapped = 8'd197;
        8'd109, 8'd110: x_mapped = 8'd196;
        8'd111, 8'd112: x_mapped = 8'd195;
        8'd113, 8'd114: x_mapped = 8'd194;
        8'd115: x_mapped = 8'd193;
        8'd116, 8'd117: x_mapped = 8'd192;
        8'd118, 8'd119: x_mapped = 8'd191;
        8'd120: x_mapped = 8'd190;
        8'd121, 8'd122: x_mapped = 8'd189;
        8'd123: x_mapped = 8'd188;
        8'd124, 8'd125: x_mapped = 8'd187;
        8'd126: x_mapped = 8'd186;
        8'd127, 8'd128: x_mapped = 8'd185;
        8'd129: x_mapped = 8'd184;
        8'd130: x_mapped = 8'd183;
        8'd131, 8'd132: x_mapped = 8'd182;
        8'd133: x_mapped = 8'd181;
        8'd134: x_mapped = 8'd180;
        8'd135, 8'd136: x_mapped = 8'd179;
        8'd137: x_mapped = 8'd178;
        8'd138: x_mapped = 8'd177;
        8'd139, 8'd140: x_mapped = 8'd176;
        8'd141: x_mapped = 8'd175;
        8'd142: x_mapped = 8'd174;
        8'd143: x_mapped = 8'd173;
        8'd144: x_mapped = 8'd172;
        8'd145, 8'd146: x_mapped = 8'd171;
        8'd147: x_mapped = 8'd170;
        8'd148: x_mapped = 8'd169;
        8'd149: x_mapped = 8'd168;
        8'd150: x_mapped = 8'd167;
        8'd151: x_mapped = 8'd166;
        8'd152: x_mapped = 8'd165;
        8'd153: x_mapped = 8'd164;
        8'd154: x_mapped = 8'd163;
        8'd155: x_mapped = 8'd162;
        8'd156: x_mapped = 8'd161;
        8'd157: x_mapped = 8'd160;
        8'd158: x_mapped = 8'd159;
        default: begin
            x_mapped = x_mapped; // Default case if none of the above conditions are met
        end
    endcase
end

//always @(y_mapped) begin
//    case (y_mapped)
//        8'd0, 8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8, 8'd9, 8'd10, 8'd11, 8'd12, 8'd13, 8'd14: x_mapped = 8'd225;
//        8'd15, 8'd16, 8'd17, 8'd18, 8'd19, 8'd20, 8'd21, 8'd22, 8'd23, 8'd24, 8'd25: x_mapped = 8'd224;
//        8'd26, 8'd27, 8'd28, 8'd29, 8'd30, 8'd31, 8'd32, 8'd33: x_mapped = 8'd223;
//        8'd34, 8'd35, 8'd36, 8'd37, 8'd38, 8'd39: x_mapped = 8'd222;
//        8'd40, 8'd41, 8'd42, 8'd43, 8'd44: x_mapped = 8'd221;
//        8'd45, 8'd46, 8'd47, 8'd48, 8'd49: x_mapped = 8'd220;
//        8'd50, 8'd51, 8'd52, 8'd53: x_mapped = 8'd219;
//        8'd54, 8'd55, 8'd56, 8'd57: x_mapped = 8'd218;
//        8'd58, 8'd59, 8'd60, 8'd61: x_mapped = 8'd217;
//        8'd62, 8'd63, 8'd64: x_mapped = 8'd216;
//        8'd65, 8'd66, 8'd67: x_mapped = 8'd215;
//        8'd68, 8'd69, 8'd70, 8'd71: x_mapped = 8'd214;
//        8'd72, 8'd73: x_mapped = 8'd213;
//        8'd74, 8'd75, 8'd76: x_mapped = 8'd212;
//        8'd77, 8'd78, 8'd79: x_mapped = 8'd211;
//        8'd80, 8'd81, 8'd82: x_mapped = 8'd210;
//        8'd83, 8'd84: x_mapped = 8'd209;
//        8'd85, 8'd86: x_mapped = 8'd208;
//        8'd87, 8'd88, 8'd89: x_mapped = 8'd207;
//        8'd90, 8'd91: x_mapped = 8'd206;
//        8'd92, 8'd93: x_mapped = 8'd205;
//        8'd94, 8'd95: x_mapped = 8'd204;
//        8'd96, 8'd97, 8'd98: x_mapped = 8'd203;
//        8'd99, 8'd100: x_mapped = 8'd202;
//        8'd101, 8'd102: x_mapped = 8'd201;
//        8'd103, 8'd104: x_mapped = 8'd200;
//        8'd105: x_mapped = 8'd199;
//        8'd106, 8'd107: x_mapped = 8'd198;
//        8'd108, 8'd109: x_mapped = 8'd197;
//        8'd110, 8'd111: x_mapped = 8'd196;
//        8'd112, 8'd113: x_mapped = 8'd195;
//        8'd114: x_mapped = 8'd194;
//        8'd115, 8'd116: x_mapped = 8'd193;
//        8'd117, 8'd118: x_mapped = 8'd192;
//        8'd119: x_mapped = 8'd191;
//        8'd120, 8'd121: x_mapped = 8'd190;
//        8'd122: x_mapped = 8'd189;
//        8'd123, 8'd124: x_mapped = 8'd188;
//        8'd125: x_mapped = 8'd187;
//        8'd126, 8'd127: x_mapped = 8'd186;
//        8'd128: x_mapped = 8'd185;
//        8'd129, 8'd130: x_mapped = 8'd184;
//        8'd131: x_mapped = 8'd183;
//        8'd132: x_mapped = 8'd182;
//        8'd133, 8'd134: x_mapped = 8'd181;
//        8'd135: x_mapped = 8'd180;
//        8'd136: x_mapped = 8'd179;
//        8'd137, 8'd138: x_mapped = 8'd178;
//        8'd139: x_mapped = 8'd177;
//        8'd140: x_mapped = 8'd176;
//        8'd141, 8'd142: x_mapped = 8'd175;
//        8'd143: x_mapped = 8'd174;
//        8'd144: x_mapped = 8'd173;
//        8'd145: x_mapped = 8'd172;
//        8'd146: x_mapped = 8'd171;
//        8'd147: x_mapped = 8'd170;
//        8'd148, 8'd149: x_mapped = 8'd169;
//        8'd150: x_mapped = 8'd168;
//        8'd151: x_mapped = 8'd167;
//        8'd152: x_mapped = 8'd166;
//        8'd153: x_mapped = 8'd165;
//        8'd154: x_mapped = 8'd164;
//        8'd155: x_mapped = 8'd163;
//        8'd156: x_mapped = 8'd162;
//        8'd157: x_mapped = 8'd161;
//        8'd158: x_mapped = 8'd160;
//        8'd159: x_mapped = 8'd159;
//        default: begin
//            x_mapped = x_mapped; // Default case if none of the above conditions are met
//        end
//    endcase
//end

endmodule
