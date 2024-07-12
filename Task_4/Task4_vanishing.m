% Load the image
image1 = imread('CVPR_CV_CW_2024\database\FD_with\FD_with_2.jpg'); % Modify with your actual image path

% Display the image and manually select points for the first set of parallel lines
figure; imshow(image1); title('Select points along the first set of parallel lines, then press Enter');
[x1, y1] = getpts();

% Display the image again and manually select points for the second set of parallel lines
figure; imshow(image1); title('Select points along the second set of parallel lines, then press Enter');
[x2, y2] = getpts();

% Fit lines to the first set of selected points and compute the first vanishing point
A1 = [x1, y1, ones(size(x1))];
[~, ~, V1] = svd(A1);
line1 = V1(:,end); % The solution is the last column of V
A2 = [x2, y2, ones(size(x2))];
[~, ~, V2] = svd(A2);
line2 = V2(:,end); % The solution is the last column of V
vp1 = cross(line1, line2);
vp1 = vp1 / vp1(3); % Normalize to inhomogeneous coordinates


% second vanishing point
figure; imshow(image1); title('Select points along the first set of parallel lines, then press Enter');
[x3, y3] = getpts();
figure; imshow(image1); title('Select points along the second set of parallel lines, then press Enter');
[x4, y4] = getpts();
A3 = [x3, y3, ones(size(x3))];
[~, ~, V3] = svd(A3);
line3 = V3(:,end);
A4 = [x4, y4, ones(size(x4))];
[~, ~, V4] = svd(A4);
line4 = V4(:,end);
vp2 = cross(line3, line4);
vp2 = vp2 / vp2(3);

horizonLine = cross(vp1, vp2);

% Calculate points on the horizon line for plotting
xLimits = [1, size(image1, 2)]; % Image width
yLimits = [(-horizonLine(3) - horizonLine(1) * xLimits(1)) / horizonLine(2), ...
           (-horizonLine(3) - horizonLine(1) * xLimits(2)) / horizonLine(2)];

% Plot the horizon line on the image
figure; imshow(image1); title('Horizon Line');
hold on; line(xLimits, yLimits, 'Color', 'yellow', 'LineWidth', 2); % Change color or width as needed
hold off;