I1 = imread('HG_1.jpg'); % Replace 'image1.jpg' with your actual image file
I2 = imread('HG_2.jpg'); % Replace 'image2.jpg' with your actual image file

I1 = imrotate(I1,-90);
I2 = imrotate(I2,-90);
% Convert images to grayscale
I1_gray = rgb2gray(I1);
I2_gray = rgb2gray(I2);

% Detect SURF features
points1 = detectSURFFeatures(I1_gray);
points2 = detectSURFFeatures(I2_gray);

% Extract features
[features1, valid_points1] = extractFeatures(I1_gray, points1);
[features2, valid_points2] = extractFeatures(I2_gray, points2);

% Match features
indexPairs = matchFeatures(features1, features2);

% Retrieve locations of corresponding points for each image
matchedPoints1 = valid_points1(indexPairs(:, 1), :);
matchedPoints2 = valid_points2(indexPairs(:, 2), :);

% Visualize matched points
figure; ax = axes;
showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2, 'montage', 'Parent', ax);
title(ax, 'Candidate point matches');
legend(ax, 'Matched points 1', 'Matched points 2');
