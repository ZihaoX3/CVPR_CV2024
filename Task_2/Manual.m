% Load the two images
image1 = imread('HG_1.jpg'); % Replace 'image1.jpg' with your actual image file
image2 = imread('HG_2.jpg'); % Replace 'image2.jpg' with your actual image file

% Open cpselect tool to manually select correspondences
% You can close the cpselect window once you are done selecting points
[inputPoints, basePoints] = cpselect(image1, image2, 'Wait', true);

% Optionally, you can visualize the selected points on each image
figure; imshow(image1); hold on; plot(inputPoints(:,1), inputPoints(:,2), 'yx');
title('Selected Points on Image 1');

figure; imshow(image2); hold on; plot(basePoints(:,1), basePoints(:,2), 'yx');
title('Selected Points on Image 2');

% Save the points to a file or proceed with further processing
% For example, to save the points, you can use:
save('correspondingPoints.mat', 'inputPoints', 'basePoints');
