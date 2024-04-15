% 常量
TEXTURE_RES = 1;
MAP_SIZE = [5, 5, 5];
LOOKAT_REL_FAC = 0.02;
ANGLE_RADIUS = 225;


% 玩家数据
p_pos = [1.1, 1.2, 1.3];
p_angle = [-60, -120];


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
lookat_rel(1) = coord_h(1) * coord_v(1) / ANGLE_RADIUS;
lookat_rel(2) = coord_h(2) * coord_v(1) / ANGLE_RADIUS;
lookat_rel(3) = coord_v(2);
lookat_h_rel(1) = coord_h(1);
lookat_h_rel(2) = coord_h(2);
vp_u = [lookat_h_rel(2), -lookat_h_rel(1), 0];
vp_v(1) = ((vp_u(2) * lookat_rel(3)) - (vp_u(3) * lookat_rel(2))) / ANGLE_RADIUS;
vp_v(2) = ((vp_u(3) * lookat_rel(1)) - (vp_u(1) * lookat_rel(3))) / ANGLE_RADIUS;
vp_v(3) = ((vp_u(1) * lookat_rel(2)) - (vp_u(2) * lookat_rel(1))) / ANGLE_RADIUS;
vp_origin(1) = p_pos(1) + lookat_rel(1) * LOOKAT_REL_FAC;
vp_origin(2) = p_pos(2) + lookat_rel(2) * LOOKAT_REL_FAC;
vp_origin(3) = p_pos(3) + lookat_rel(3) * LOOKAT_REL_FAC;
% 计算起始点、结束点
start_p = p_pos;
end_p = vp_origin;
% 画出线段
plot3([start_p(1), end_p(1)], [start_p(2), end_p(2)], [start_p(3), end_p(3)], 'k-', 'LineWidth', 2);

% 
block_p = fix(p_pos / TEXTURE_RES);
hit_P = p_pos;
scatter3(block_p(1)*TEXTURE_RES, block_p(2)*TEXTURE_RES, block_p(3)*TEXTURE_RES, 10, 'filled', 'MarkerFaceColor', 'b');
next_block_p = [0, 0, 0];
for i=1:1:3
    if end_p(i) <= start_p(i)
        next_block_p(i) = block_p(i);
    else
        next_block_p(i) = block_p(i) + 1;
    end
end
edge = [next_block_p(1)*TEXTURE_RES, next_block_p(2)*TEXTURE_RES, next_block_p(3)*TEXTURE_RES];
scatter3(edge(1), edge(2), edge(3), 10, 'filled', 'MarkerFaceColor', 'b');

% 
plot3([start_p(1), edge(1)], [start_p(2), start_p(2)], [start_p(3), start_p(3)], 'r', 'LineWidth', 2);
plot3([start_p(1), start_p(1)], [start_p(2), edge(2)], [start_p(3), start_p(3)], 'g', 'LineWidth', 2);
plot3([start_p(1), start_p(1)], [start_p(2), start_p(2)], [start_p(3), edge(3)], 'b', 'LineWidth', 2);

delta = edge - start_p;
delta_t = [0, 0, 0];
for i=1:1:3
    delta_t(i) = delta(i) / lookat_rel(i);
end
next_x = [edge(1), p_pos(2) + lookat_rel(2)*delta_t(1),p_pos(3) + lookat_rel(3)*delta_t(1)];
next_y = [p_pos(1) + lookat_rel(1)*delta_t(2), edge(2),p_pos(3) + lookat_rel(3)*delta_t(2)];
next_z = [p_pos(1) + lookat_rel(1)*delta_t(3), p_pos(2) + lookat_rel(2)*delta_t(3),edge(3)];
scatter3(next_x(1), next_x(2), next_x(3), 10, 'filled', 'MarkerFaceColor', 'b');
scatter3(next_y(1), next_y(2), next_y(3), 10, 'filled', 'MarkerFaceColor', 'b');
scatter3(next_z(1), next_z(2), next_z(3), 10, 'filled', 'MarkerFaceColor', 'b');
plot3([edge(1), next_x(1)], [start_p(2), next_x(2)], [start_p(3), next_x(3)], 'r', 'LineWidth', 2);
plot3([start_p(1), next_y(1)], [edge(2), next_y(2)], [start_p(3), next_y(3)], 'g', 'LineWidth', 2);
plot3([start_p(1), next_z(1)], [start_p(2), next_z(2)], [edge(3), next_z(3)], 'b', 'LineWidth', 2);


hold off;
grid on;
axis equal; % 让坐标轴比例相同

% 设置观察角度
view(45, 30); % 设置为 45 度仰角，30 度方位角

% 获取当前图形窗口的句柄
fig_handle = gcf;
% 设置图形窗口全屏显示
set(fig_handle, 'WindowState', 'maximized');
