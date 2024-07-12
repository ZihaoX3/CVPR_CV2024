load('CVPR_CV_CW_2024\Task_2\Task2_manual_correspond.mat');

% Ensure the arrays are the same size by trimming (assuming N is the size you want to keep)
N = min(size(basePoints, 1), size(matchedPoints2_Harris.Location, 1)); % Find the smaller size
basePointsTrimmed = basePoints(1:N, :);
matchedPoints2_HarrisTrimmed = matchedPoints2_Harris.Location(1:N, :);

% Then perform your MSE calculation with the trimmed arrays
differences_Harris = basePointsTrimmed - matchedPoints2_HarrisTrimmed;
mse_Harris = mean(sum(differences_Harris.^2, 2));
fprintf('MSE for Harris: %f\n', mse_Harris);


% Ensure the arrays are the same size by trimming (assuming M is the size you want to keep for SURF)
M = min(size(basePoints, 1), size(matchedPoints2_SURF.Location, 1)); % Find the smaller size
basePointsTrimmed_SURF = basePoints(1:M, :);
matchedPoints2_SURFTrimmed = matchedPoints2_SURF.Location(1:M, :);  % Use M to trim
% Then perform your MSE calculation with the trimmed arrays
differences_SURF = basePointsTrimmed_SURF - matchedPoints2_SURFTrimmed;
mse_SURF = mean(sum(differences_SURF.^2, 2));
fprintf('MSE for SURF: %f\n', mse_SURF);