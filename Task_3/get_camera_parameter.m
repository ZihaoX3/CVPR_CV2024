% Define images for calibration
images = imageDatastore(fullfile('CVPR_CV_CW_2024-new - 副本/database/FD_without/'));

% Detect checkerboard corners
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(images.Files);

% Define world coordinates of checkerboard corners
squareSize = 10; % square size in millimeters
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints);

% Assess the calibration accuracy
figure; showReprojectionErrors(cameraParams);
figure; showExtrinsics(cameraParams);

% Optionally, you can undistort images using the camera parameters
I = imread('path_to_an_image');
I_undistorted = undistortImage(I, cameraParams);

% Visualize the undistorted image
figure; imshow(I_undistorted);
