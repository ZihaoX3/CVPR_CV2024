% 读取图像
image = imread("DSCF3342.JPG");

% 转换为灰度图像
grayImage = rgb2gray(image);

% 边缘检测
edges = edge(grayImage, 'Canny');

% 执行霍夫变换
[H, theta, rho] = hough(edges);

% 找到霍夫变换中的峰值
peaks = houghpeaks(H, 5, 'threshold', ceil(0.3*max(H(:))));

% 根据峰值和霍夫变换提取直线
lines = houghlines(edges, theta, rho, peaks, 'FillGap', 5, 'MinLength', 7);

% 显示原始图像
figure, imshow(image), hold on

% 绘制直线
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % 绘制直线的起点和终点
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end

% 假设我们选择前两条直线来计算消失点
% 这只是一个简化的示例，实际应用中你可能需要更复杂的逻辑来选择直线
if length(lines) >= 2
    line1 = lines(1);
    line2 = lines(2);
    % 计算两直线的交点作为消失点
    vp = cross([line1.point1, 1], [line1.point2, 1]);
    vp = vp / vp(3);
    vp2 = cross([line2.point1, 1], [line2.point2, 1]);
    vp2 = vp2 / vp2(3);
    % 绘制消失点
    plot(vp(1), vp(2), 'r*', 'LineWidth', 2, 'MarkerSize', 10);
    plot(vp2(1), vp2(2), 'r*', 'LineWidth', 2, 'MarkerSize', 10);
end

hold off;
