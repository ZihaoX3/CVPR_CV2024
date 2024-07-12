% Assuming 'cameraParams' is the result of camera calibration
I = imread("CVPR_CV_CW_2024\database\FD_without\FD_without_1.jpg"); % Load an image affected by distortion

% Undistort the image
I_undistorted = undistortImage(I, cameraParams);

% Display the original and undistorted images side by side
fig = figure;
subplot(1,2,1); imshow(I); title('Original Image');
subplot(1,2,2); imshow(I_undistorted); title('Undistorted Image');

set(fig, 'Position', [100, 100, 1200, 600]); % [left bottom width height]