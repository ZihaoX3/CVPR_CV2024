I1 = imread('CVPR_CV_CW_2024\database\HG\HG_2.jpg'); 
I2 = imread('CVPR_CV_CW_2024\database\HG\HG_3.jpg'); 

% I1 = imrotate(I1,-90);
% I2 = imrotate(I2,-90);

% ------------- SURF -------------- %
% Estimate the transformation matrix.
% It returns a transformation object, tform, and the status of each match.
[tform_SURF, inlierIdx_SURF] = estimateGeometricTransform2D(matchedPoints2_SURF, matchedPoints1_SURF, 'projective');

disp("Homography matrix SURF: ")
disp(tform_SURF.T)

% Extract the inlier matches
inlierMatchedPoints1_SURF = matchedPoints1_SURF(inlierIdx_SURF, :);
inlierMatchedPoints2_SURF = matchedPoints2_SURF(inlierIdx_SURF, :);

% Visualize the matching points.
figure; showMatchedFeatures(I1, I2, inlierMatchedPoints1_SURF, inlierMatchedPoints2_SURF, 'montage');
title('Matched points SURF (inliers only)');

% ------------ Harris ------------- %
% Estimate the transformation matrix.
% It returns a transformation object, tform, and the status of each match.
[tform_Harris, inlierIdx_Harris] = estimateGeometricTransform2D(matchedPoints2_Harris, matchedPoints1_Harris, 'projective');

disp("Homography matrix Harris: ")
disp(tform_Harris.T)

% Extract the inlier matches
inlierMatchedPoints1_Harris = matchedPoints1_Harris(inlierIdx_Harris, :);
inlierMatchedPoints2_Harris = matchedPoints2_Harris(inlierIdx_Harris, :);

% Visualize the matching points.
figure; showMatchedFeatures(I1, I2, inlierMatchedPoints1_Harris, inlierMatchedPoints2_Harris, 'montage');
title('Matched points Harris (inliers only)');