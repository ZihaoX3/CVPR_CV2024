I1 = imread('HG_1.jpg'); % Replace 'image1.jpg' with your actual image file
I2 = imread('HG_2.jpg'); % Replace 'image2.jpg' with your actual image file


I1 = imrotate(I1,-90);
I2 = imrotate(I2,-90);

I1_gray = rgb2gray(I1); % Convert to grayscale
I2_gray = rgb2gray(I2); % Convert to grayscale

corners1 = detectHarrisFeatures(I1_gray);
corners2 = detectHarrisFeatures(I2_gray);

[features1, valid_corners1] = extractFeatures(I1_gray, corners1);
[features2, valid_corners2] = extractFeatures(I2_gray, corners2);

indexPairs = matchFeatures(features1, features2);
matchedPoints1 = valid_corners1(indexPairs(:, 1), :);
matchedPoints2 = valid_corners2(indexPairs(:, 2), :);

figure; showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2, 'montage');
title('Matched Harris Corners');
