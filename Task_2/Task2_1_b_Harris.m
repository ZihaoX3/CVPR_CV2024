I1 = imread('CVPR_CV_CW_2024\database\HG\HG_2.jpg'); 
I2 = imread('CVPR_CV_CW_2024\database\HG\HG_3.jpg'); 

% 
% I1 = imrotate(I1,-90);
% I2 = imrotate(I2,-90);

I1_gray = rgb2gray(I1); 
I2_gray = rgb2gray(I2); 
corners1_Harris = detectHarrisFeatures(I1_gray);
corners2_Harris = detectHarrisFeatures(I2_gray);

[features1_Harris, valid_corners1_Harris] = extractFeatures(I1_gray, corners1_Harris);
[features2_Harris, valid_corners2_Harris] = extractFeatures(I2_gray, corners2_Harris);

indexPairs_Harris = matchFeatures(features1_Harris, features2_Harris);
matchedPoints1_Harris = valid_corners1_Harris(indexPairs_Harris(:, 1), :);
matchedPoints2_Harris = valid_corners2_Harris(indexPairs_Harris(:, 2), :);

figure; ax = axes;
showMatchedFeatures(I1, I2, matchedPoints1_Harris, matchedPoints2_Harris, 'montage', 'Parent', ax);
title(ax, 'Keypoint Correspondence Harris');
legend(ax, 'Matched points 1', 'Matched points 2');

