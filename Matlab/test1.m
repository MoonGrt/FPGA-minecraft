% 常量
TEXTURE_RES = 16;
MAP_SIZE = [50, 50, 50];
LOOKAT_REL_FAC = 2;
ANGLE_RADIUS = 225;
H_REAL = 320;
V_REAL = 240;


% 玩家数据
p_pos = [470, 470, 280];
p_angle = [30, -120];


% 创建一个三维坐标系
figure;
hold on;
title('Sight Line');

% 画 x 轴
plot3([-TEXTURE_RES*MAP_SIZE(1) TEXTURE_RES*MAP_SIZE(1)], [0 0], [0 0], 'r', 'LineWidth', 2);
text(TEXTURE_RES*MAP_SIZE(1), 0, 0, 'X', 'FontSize', 12);
% 画 y 轴
plot3([0 0], [-TEXTURE_RES*MAP_SIZE(2) TEXTURE_RES*MAP_SIZE(2)], [0 0], 'g', 'LineWidth', 2);
text(0, TEXTURE_RES*MAP_SIZE(2), 0, 'Y', 'FontSize', 12);
% 画 z 轴
plot3([0 0], [0 0], [-TEXTURE_RES*MAP_SIZE(3) TEXTURE_RES*MAP_SIZE(3)], 'b', 'LineWidth', 2);
text(0, 0, TEXTURE_RES*MAP_SIZE(3), 'Z', 'FontSize', 12);


% 屏幕点
fragment_uv = [0, 0];
% 射线计算
coord_h = [round(sqrt(ANGLE_RADIUS^2 - p_angle(1)^2)), p_angle(1)];
coord_v = [round(sqrt(ANGLE_RADIUS^2 - p_angle(2)^2)), p_angle(2)];
lookat_rel(1) = round(coord_h(1) * coord_v(1) / ANGLE_RADIUS);
lookat_rel(2) = round(coord_h(2) * coord_v(1) / ANGLE_RADIUS);
lookat_rel(3) = round(coord_v(2));
lookat_h_rel(1) = round(coord_h(1));
lookat_h_rel(2) = round(coord_h(2));
vp_u = [lookat_h_rel(2), -lookat_h_rel(1), 0];
vp_v(1) = fix(((vp_u(2) * lookat_rel(3)) - (vp_u(3) * lookat_rel(2))) / ANGLE_RADIUS);
vp_v(2) = fix(((vp_u(3) * lookat_rel(1)) - (vp_u(1) * lookat_rel(3))) / ANGLE_RADIUS);
vp_v(3) = fix(((vp_u(1) * lookat_rel(2)) - (vp_u(2) * lookat_rel(1))) / ANGLE_RADIUS);
vp_origin(1) = fix(p_pos(1) + (lookat_rel(1) - vp_u(1) * H_REAL / 2 / ANGLE_RADIUS + vp_v(1) * V_REAL / 2 / ANGLE_RADIUS) * LOOKAT_REL_FAC);
vp_origin(2) = fix(p_pos(2) + (lookat_rel(2) - vp_u(2) * H_REAL / 2 / ANGLE_RADIUS + vp_v(2) * V_REAL / 2 / ANGLE_RADIUS) * LOOKAT_REL_FAC);
vp_origin(3) = fix(p_pos(3) + (lookat_rel(3) - vp_u(3) * H_REAL / 2 / ANGLE_RADIUS + vp_v(3) * V_REAL / 2 / ANGLE_RADIUS) * LOOKAT_REL_FAC);
vp_target(1) = fix(vp_origin(1) + vp_u(1) * fragment_uv(1) * LOOKAT_REL_FAC / ANGLE_RADIUS - vp_v(1) * fragment_uv(2) * LOOKAT_REL_FAC / ANGLE_RADIUS);
vp_target(2) = fix(vp_origin(2) + vp_u(2) * fragment_uv(1) * LOOKAT_REL_FAC / ANGLE_RADIUS - vp_v(2) * fragment_uv(2) * LOOKAT_REL_FAC / ANGLE_RADIUS);
vp_target(3) = fix(vp_origin(3) + vp_u(3) * fragment_uv(1) * LOOKAT_REL_FAC / ANGLE_RADIUS - vp_v(3) * fragment_uv(2) * LOOKAT_REL_FAC / ANGLE_RADIUS);
% 计算起始点、结束点
start_p = p_pos;
end_p = vp_target;
% 画出线段
plot3([start_p(1), end_p(1)], [start_p(2), end_p(2)], [start_p(3), end_p(3)], 'k-', 'LineWidth', 2);

% 
block_p = fix(p_pos / TEXTURE_RES);
hit_P = p_pos;
scatter3(block_p(1)*TEXTURE_RES, block_p(2)*TEXTURE_RES, block_p(3)*TEXTURE_RES, 10, 'filled', 'MarkerFaceColor', 'b');
next_block_p = [0, 0, 0];
for i=1:1:3
    if end_p(i) == start_p(i)
        next_block_p(i) = block_p(i);
    elseif end_p(i) > start_p(i)
        next_block_p(i) = block_p(i) + 1;
    else
        next_block_p(i) = block_p(i) - 1;
    end
end
edge = [next_block_p(1)*TEXTURE_RES, next_block_p(2)*TEXTURE_RES, next_block_p(3)*TEXTURE_RES];
scatter3(edge(1), edge(2), edge(3), 10, 'filled', 'MarkerFaceColor', 'b');
delta = edge - start_p;


hold off;
grid on;
axis equal; % 让坐标轴比例相同

% 设置观察角度
view(45, 30); % 设置为 45 度仰角，30 度方位角

% 获取当前图形窗口的句柄
fig_handle = gcf;
% 设置图形窗口全屏显示
set(fig_handle, 'WindowState', 'maximized');
