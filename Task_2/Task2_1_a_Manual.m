% Load the two images
I1 = imread('CVPR_CV_CW_2024\database\HG\HG_2.jpg'); 
I2 = imread('CVPR_CV_CW_2024\database\HG\HG_3.jpg'); 

% I1 = imrotate(I1, -90);
% I2 = imrotate(I2, -90);

% Cpselect to manually select correspondences
[inputPoints, basePoints] = cpselect(I1, I2, 'Wait', true);

save('Task2_manual_correspond.mat', 'inputPoints', 'basePoints');
