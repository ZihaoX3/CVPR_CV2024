% Assuming you have already loaded and rectified image1 and image2

% Convert to grayscale as required by the disparity function.
grayImage1 = rgb2gray(rectifiedImage1);
grayImage2 = rgb2gray(rectifiedImage2);

% Stereo camera parameters (ensure these are obtained from stereo calibration)
% Placeholder values are used here; replace them with your actual calibrated parameters.
focalLength = 1; % Example focal length in pixels
baseline = 0.3; % Example baseline in meters (distance between the two camera centers)
principalPoint = [size(grayImage1, 2) / 2, size(grayImage1, 1) / 2]; % Example principal point in pixels (center of the image)

% Calculate the disparity map. You may need to adjust the disparity range based on your observations.
disparityRange = [0, 64]; % Example range, adjust as necessary
disparityMap = disparitySGM(grayImage1, grayImage2, 'DisparityRange', disparityRange, 'UniquenessThreshold', 15);

% Display the disparity map.
figure;
imshow(disparityMap, disparityRange);
title('Disparity Map');
colormap(gca, jet) % Apply the colormap to the current figure
colorbar

% Calculate the depth map only if the disparityMap is not empty and contains valid disparities
if ~isempty(disparityMap) && any(disparityMap(:) > 0)
    % Convert from disparity to depth.
    depthMap = (focalLength * baseline) ./ (disparityMap + 1e-6); % Add a small number to avoid division by zero

    % Replace Inf, NaN, and negative values with a maximum depth value
    maxDepthValue = 10; % Adjust this value based on the maximum expected depth in your scene
    depthMap(isinf(depthMap) | isnan(depthMap) | depthMap < 0) = maxDepthValue;
    
    % Display the depth map
    figure;
    imshow(depthMap, [0 maxDepthValue]);
    title('Depth Map');
    colormap(gca, 'parula'); % Choose a colormap that suits depth visualization
    colorbar
else
    disp('Disparity map is empty or contains no valid disparities.');
end
