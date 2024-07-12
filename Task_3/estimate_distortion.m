% Specify the images directory and the calibration pattern
imagesDir = fullfile('CVPR_CV_CW_2024/database/FD_without/');
imageFiles = fullfile(imagesDir, '*.JPG');
images = imageDatastore(imageFiles);

% Specify your calibration pattern options
squareSize = 10; % square size in millimeters

% Detect checkerboard corners
[imagePoints, boardSize] = detectCheckerboardPoints(images.Files);

% Generate world coordinates of the corners
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints);

% Display the camera parameters, including the distortion coefficients
disp(cameraParams.IntrinsicMatrix);
fprintf('Radial distortion coefficients: %f, %f\n', cameraParams.RadialDistortion);
fprintf('Tangential distortion coefficients: %f, %f\n', cameraParams.TangentialDistortion);

% Optionally, use cameraParams to undistort images
I = imread(images.Files{1}); % Reading the first image
I_undistorted = undistortImage(I, cameraParams);

% Display the original and undistorted images
figure; imshow(I); title('Original Image');
figure; imshow(I_undistorted); title('Undistorted Image');
