% 步骤 1: 选择第一对平行线
image = imread("DSCF3342.JPG");
figure;
imshow(image);
title('Select two points on the first parallel line and press enter');
[x1, y1] = ginput(2);
hold on;
plot(x1, y1, 'r-', 'LineWidth', 2);
legend('First pair of lines');

% 步骤 2: 选择第二对平行线
title('Select two points on the second parallel line and press enter');
[x2, y2] = ginput(2);
plot(x2, y2, 'g-', 'LineWidth', 2);
legend('First pair of lines', 'Second pair of lines');

% 计算第一组平行线的消失点
line1 = cross([x1(1), y1(1), 1], [x1(2), y1(2), 1]);
line2 = cross([x2(1), y2(1), 1], [x2(2), y2(2), 1]);
vanishingPoint1 = cross(line1, line2);
vanishingPoint1 = vanishingPoint1 / vanishingPoint1(3); % 转换为非齐次坐标

% 显示第一个消失点
plot(vanishingPoint1(1), vanishingPoint1(2), 'yo', 'MarkerSize', 10, 'LineWidth', 2);
legend('First pair of lines', 'Second pair of lines', 'First Vanishing Point');

% 步骤 3: 选择第三对平行线
title('Select two points on the third parallel line and press enter');
[x3, y3] = ginput(2);
plot(x3, y3, 'b-', 'LineWidth', 2);
legend('First pair of lines', 'Second pair of lines', 'First Vanishing Point', 'Third pair of lines');

% 步骤 4: 选择第四对平行线
title('Select two points on the fourth parallel line and press enter');
[x4, y4] = ginput(2);
plot(x4, y4, 'm-', 'LineWidth', 2);
legend('First pair of lines', 'Second pair of lines', 'First Vanishing Point', 'Third pair of lines', 'Fourth pair of lines');

% 计算第二组平行线的消失点
line3 = cross([x3(1), y3(1), 1], [x3(2), y3(2), 1]);
line4 = cross([x4(1), y4(1), 1], [x4(2), y4(2), 1]);
vanishingPoint2 = cross(line3, line4);
vanishingPoint2 = vanishingPoint2 / vanishingPoint2(3); % 转换为非齐次坐标

% 显示第二个消失点
plot(vanishingPoint2(1), vanishingPoint2(2), 'co', 'MarkerSize', 10, 'LineWidth', 2);
legend('First pair of lines', 'Second pair of lines', 'First Vanishing Point', 'Third pair of lines', 'Fourth pair of lines', 'Second Vanishing Point');

% 计算地平线
horizonLine = cross(vanishingPoint1, vanishingPoint2);

% 在图像上绘制地平线
xLimits = xlim(gca); % 获取当前图像x轴的范围
yHorizon = (horizonLine(3) + horizonLine(1) * xLimits) / -horizonLine(2);
plot(xLimits, yHorizon, 'y-', 'LineWidth', 2);
legend('First pair of lines', 'Second pair of lines', 'First Vanishing Point', 'Third pair of lines', 'Fourth pair of lines', 'Second Vanishing Point', 'Horizon Line');
title('Manually Selected Lines, Vanishing Points, and Horizon Line');
hold off;