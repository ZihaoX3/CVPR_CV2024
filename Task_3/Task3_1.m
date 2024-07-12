% Images for calibration
images = imageDatastore(fullfile('CVPR_CV_CW_2024/database/FD_without/'));

% Detect checkerboard corners
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(images.Files);

% 输出所有图片的文件名
disp('All image files:');
disp(images.Files);

% 输出被成功用于检测的图片的文件名
disp('Images used for calibration:');
imageFilesUsed = images.Files(imagesUsed);
disp(imageFilesUsed);

% Identify and display the images that were not used
disp('Images NOT used for calibration:');
imageFilesNotUsed = images.Files(~imagesUsed);
disp(imageFilesNotUsed);

% 定义棋盘格世界坐标
squareSize = 15; % square size in millimeters
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, ~ ,estimationErrors] = estimateCameraParameters(imagePoints, worldPoints);

% Assess the calibration accuracy
figure; showReprojectionErrors(cameraParams);
figure; showExtrinsics(cameraParams);

% Display the intrinsic matrix
disp('Intrinsic Matrix:');
disp(cameraParams.IntrinsicMatrix);

% Display extrinsic parameters for each image used in the calibration
numImagesUsed = size(cameraParams.RotationMatrices, 3);
for i = 1:numImagesUsed
    rotationMatrix = cameraParams.RotationMatrices(:,:,i); 
    translationVector = cameraParams.TranslationVectors(i,:); 
    fprintf('Rotation Matrix for image %d:\n', i);
    disp(rotationMatrix);
    fprintf('Translation Vector for image %d:\n', i);
    disp(translationVector);
end


