load('CVPR_CV_CW_2024\Task_2\Task2_manual_correspond.mat');
% Convert inputPoints to homogeneous coordinates
inputPointsHom_SURF = [inputPoints, ones(size(inputPoints,1), 1)]';

% Project using homography matrix from SURF
projectedPointsHom_SURF = tform_SURF.T * inputPointsHom_SURF;

% Convert back to Cartesian coordinates
projectedPoints_SURF = projectedPointsHom_SURF(1:2,:) ./ projectedPointsHom_SURF(3,:);

% Reshape for comparison
projectedPoints_SURF = projectedPoints_SURF';

% Convert inputPoints to homogeneous coordinates
inputPointsHom_Harris = [inputPoints, ones(size(inputPoints,1), 1)]';

% Project using homography matrix from Harris
projectedPointsHom_Harris = tform_Harris.T * inputPointsHom_Harris;

% Convert back to Cartesian coordinates
projectedPoints_Harris = projectedPointsHom_Harris(1:2,:) ./ projectedPointsHom_Harris(3,:);

% Reshape for comparison
projectedPoints_Harris = projectedPoints_Harris';


% Calculate the Mean Squared Error for SURF
mse_SURF = mean(sum((basePoints - projectedPoints_SURF).^2, 2));
fprintf('Mean Squared Error (SURF): %f\n', mse_SURF);


% Calculate the Mean Squared Error for Harris
mse_Harris = mean(sum((basePoints - projectedPoints_Harris).^2, 2));
fprintf('Mean Squared Error (Harris): %f\n', mse_Harris);

