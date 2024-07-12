
% Load the images (replace with your actual images)
image1 = imread('CVPR_CV_CW_2024\database\FD_with\FD_with_2.jpg');
image2 = imread('CVPR_CV_CW_2024\database\FD_with\FD_with_6.jpg');

% image1 = imrotate(image1,-90);
% image2 = imrotate(image2,-90);
% Extract inlier matches based on RANSAC's output
inlierInputPoints = inputPoints(inliersIndex, :);
inlierBasePoints = basePoints(inliersIndex, :);

% Stereo rectification
[t1, t2] = estimateUncalibratedRectification(fundamentalMatrix, inlierInputPoints, inlierBasePoints, size(image2));
rectifiedImage1 = imwarp(image1, projective2d(t1), 'OutputView', imref2d(size(image1)));
rectifiedImage2 = imwarp(image2, projective2d(t2), 'OutputView', imref2d(size(image2)));

% Pre-allocate for transformed inlier points to ensure dimension consistency
inlierInputPointsRectified = zeros(size(inlierInputPoints));
inlierBasePointsRectified = zeros(size(inlierBasePoints));

% Transform the inlier points to their new positions in the rectified images
[inlierInputPointsRectified(:,1), inlierInputPointsRectified(:,2)] = transformPointsForward(projective2d(t1), inlierInputPoints(:,1), inlierInputPoints(:,2));
[inlierBasePointsRectified(:,1), inlierBasePointsRectified(:,2)] = transformPointsForward(projective2d(t2), inlierBasePoints(:,1), inlierBasePoints(:,2));

% Visualize the rectified images with keypoints and horizontal epipolar lines
fig = figure;

% Display the first rectified image with keypoints and horizontal lines
subplot(1, 2, 1);
imshow(rectifiedImage1); 
title('Rectified Image 1 with KeyPoints and Epipolar Lines');
hold on;
% Plot keypoints and horizontal lines through them
for i = 1:size(inlierInputPointsRectified, 1)
    plot(inlierInputPointsRectified(i,1), inlierInputPointsRectified(i,2), 'go'); % Key points
    line([1, size(rectifiedImage1, 2)], [inlierInputPointsRectified(i,2), inlierInputPointsRectified(i,2)], 'Color', 'yellow'); % Horizontal line
end

% Display the second rectified image with keypoints and horizontal lines
subplot(1, 2, 2);
imshow(rectifiedImage2); 
title('Rectified Image 2 with KeyPoints and Epipolar Lines');
hold on;
% Plot keypoints and horizontal lines through them
for i = 1:size(inlierBasePointsRectified, 1)
    plot(inlierBasePointsRectified(i,1), inlierBasePointsRectified(i,2), 'go'); % Key points
    line([1, size(rectifiedImage2, 2)], [inlierBasePointsRectified(i,2), inlierBasePointsRectified(i,2)], 'Color', 'yellow'); % Horizontal line
end

% Optionally adjust figure size
set(fig, 'Position', [100, 100, 2000, 1000]); % Modify as needed
