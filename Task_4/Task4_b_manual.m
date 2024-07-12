% Load the two images
image1 = imread('CVPR_CV_CW_2024\database\FD_with\FD_with_2.jpg');
image2 = imread('CVPR_CV_CW_2024\database\FD_with\FD_with_4.jpg'); 

[inputPoints, basePoints] = cpselect(image1, image2, 'Wait', true);

save('Task4_manual_correspond.mat', 'inputPoints', 'basePoints');