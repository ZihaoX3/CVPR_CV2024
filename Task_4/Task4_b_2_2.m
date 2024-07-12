% Compute the SVD of F
[~, ~, V] = svd(fundamentalMatrix);
e2 = V(:,end); % Epipole in the second image is the last column of V
e2 = e2 / e2(3); % Convert to inhomogeneous coordinates (scale such that the third component is 1)

[U, ~, ~] = svd(fundamentalMatrix');
e1 = U(:,end); % Epipole in the first image is the last column of U (from F')
e1 = e1 / e1(3); % Convert to inhomogeneous coordinates

% Compute epipolar lines in the first image for points in the second image
epiLines = epipolarLine(fundamentalMatrix, basePoints);

% Compute the intersection points of the epipolar lines with the image border
linePoints = lineToBorderPoints(epiLines, size(image1));

% Visualize the corresponding points and their epipolar lines in the first image
figure; imshow(image1); hold on;
title('Corresponding Points and Epipolar Lines in Image 1');
plot(inputPoints(:,1), inputPoints(:,2), 'go') % Plot points as green circles
line(linePoints(:, [1,3])', linePoints(:, [2,4])', 'Color', 'r'); % Draw epipolar lines
plot(e2(1), e2(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
