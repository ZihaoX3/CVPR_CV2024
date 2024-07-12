% Define ranges for experimentation
distanceThresholds = [0.001, 0.01, 0.1]; % Example range of distance thresholds
numTrialsOptions = [1000, 3000, 5000]; % Example range of NumTrials

% Matrix to store results
results = zeros(length(distanceThresholds), length(numTrialsOptions), 2); % For storing [numInliers, numOutliers]

for i = 1:length(distanceThresholds)
    for j = 1:length(numTrialsOptions)
        % Estimate the fundamental matrix with current parameters
        [fundamentalMatrix, inliersIndex, status] = estimateFundamentalMatrix(inputPoints, basePoints, ...
            'Method', 'RANSAC', ...
            'NumTrials', numTrialsOptions(j), ...
            'DistanceThreshold', distanceThresholds(i));
        
        if status == 0
            % Calculate and store the number of inliers and outliers
            numInliers = sum(inliersIndex);
            numOutliers = length(inliersIndex) - numInliers;
            results(i, j, :) = [numInliers, numOutliers];
        end
    end
end
% Create a new figure
figure;
hold on; % Allows multiple plots on the same figure

% Loop through each NumTrials setting
for j = 1:length(numTrialsOptions)
    % Plot the number of inliers for each DistanceThreshold at the current NumTrials setting
    plot(distanceThresholds, results(:, j, 1), '-o', 'DisplayName', sprintf('NumTrials = %d', numTrialsOptions(j)));
end

% Customize the plot
xlabel('Distance Threshold');
ylabel('Number of Inliers');
title('Inliers vs. Distance Threshold for Different NumTrials');
legend show; % Displays the legend with the 'DisplayName' of each plot
hold off;
