% 假设起始点坐标为 (x_start, y_start, z_start)
x_start = 0;
y_start = 0;
z_start = 0;

% 假设水平夹角为 alpha，垂直夹角为 beta
alpha = 30; % 水平夹角，单位为度
beta = 45;  % 垂直夹角，单位为度

% 将角度转换为弧度
alpha_rad = deg2rad(alpha);
beta_rad = deg2rad(beta);

% 假设线段长度为 1
length = 1;

% 计算结束点坐标 (x_end, y_end, z_end)
x_end = x_start + length * cos(alpha_rad) * sin(beta_rad);
y_end = y_start + length * sin(alpha_rad) * sin(beta_rad);
z_end = z_start + length * cos(beta_rad);

% 画出线段
plot3([x_start, x_end], [y_start, y_end], [z_start, z_end], 'b-'); % 'b-' 表示蓝色实线
xlabel('X轴');
ylabel('Y轴');
zlabel('Z轴');
title('画线示例');

% 显示网格
grid on;

% 设置坐标轴比例一致
axis equal;
