I1 = imread('CVPR_CV_CW_2024\database\HG\HG_2.jpg'); 
I2 = imread('CVPR_CV_CW_2024\database\HG\HG_3.jpg'); 
% I1 = imrotate(I1,-90);
% I2 = imrotate(I2,-90);
% Convert images to grayscale
I1_gray = rgb2gray(I1);
I2_gray = rgb2gray(I2);

% Detect SURF features
points1_SURF = detectSURFFeatures(I1_gray);
points2_SURF = detectSURFFeatures(I2_gray);

% Extract features
[features1_SURF, valid_points1_SURF] = extractFeatures(I1_gray, points1_SURF);
[features2_SURF, valid_points2_SURF] = extractFeatures(I2_gray, points2_SURF);

% Match features
indexPairs_SURF = matchFeatures(features1_SURF, features2_SURF);

% Retrieve locations of corresponding points for each image
matchedPoints1_SURF = valid_points1_SURF(indexPairs_SURF(:, 1), :);
matchedPoints2_SURF = valid_points2_SURF(indexPairs_SURF(:, 2), :);

% Visualize matched points
figure; ax = axes;
showMatchedFeatures(I1, I2, matchedPoints1_SURF, matchedPoints2_SURF, 'montage', 'Parent', ax);
title(ax, 'Keypoint Correspondence SURF');
legend(ax, 'Matched points 1', 'Matched points 2');
