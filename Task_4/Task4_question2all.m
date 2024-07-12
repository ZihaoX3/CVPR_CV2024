image1 = imread('CVPR_CV_CW_2024\database\FD_with\FD_with_2.jpg'); 
image2 = imread('CVPR_CV_CW_2024\database\FD_with\FD_with_4.jpg'); 
% load
Task4_manual_correspond = load("Task4_manual_correspond.mat");
inputPoints = Task4_manual_correspond.inputPoints;
basePoints = Task4_manual_correspond.basePoints;

% Estimate the fundamental matrix using the manually selected points
% Reduce the DistanceThreshold or increase the NumTrials
[fundamentalMatrix, inliersIndex, status] = estimateFundamentalMatrix(inputPoints, basePoints, ...
    'Method', 'RANSAC', ...
    'NumTrials', 3000, ... % Increase the number of trials
    'DistanceThreshold', 0.001); % Increase the distance threshold slightly


% Check if the estimation was successful
if status == 0
    % Display the estimated fundamental matrix
    disp('Estimated Fundamental Matrix:');
    disp(fundamentalMatrix);

    % Extract inlier matches
    inlierInputPoints = inputPoints(inliersIndex, :);
    inlierBasePoints = basePoints(inliersIndex, :);

    % Visualize the inlier matches
    figure;
    showMatchedFeatures(image1, image2, inlierInputPoints, inlierBasePoints, 'montage');
    title('Inlier Matches');

    % Compute and plot epipolar lines in both images
    figure;
    subplot(1,2,1);
    imshow(image1);
    title('Epipolar Lines in First Image');
    epilines1 = epipolarLine(fundamentalMatrix', inlierBasePoints);
    points = lineToBorderPoints(epilines1, size(image1));
    line(points(:, [1,3])', points(:, [2,4])');

    subplot(1,2,2);
    imshow(image2);
    title('Epipolar Lines in Second Image');
    epilines2 = epipolarLine(fundamentalMatrix, inlierInputPoints);
    points = lineToBorderPoints(epilines2, size(image2));
    line(points(:, [1,3])', points(:, [2,4])');

    % Optionally, plot the points on top of the lines
    hold on;
    plot(inlierBasePoints(:,1), inlierBasePoints(:,2), 'go')
    hold off;

    % For the second image
    subplot(1,2,2);
    hold on;
    plot(inlierInputPoints(:,1), inlierInputPoints(:,2), 'go')
    hold off;

else
    disp('Fundamental matrix estimation was unsuccessful.');
end


% part 2.b
%epipole
[U,S,V] = svd(fundamentalMatrix);

% The epipole in the first image (e') is the right singular vector corresponding to the smallest singular value
epipoleFirstImage = V(:,end); 

% The epipole in the second image (e) is the left singular vector corresponding to the smallest singular value
epipoleSecondImage = U(:,end);

% Normalize the epipoles to convert them to inhomogeneous coordinates (make their third component 1)
epipoleFirstImage = epipoleFirstImage / epipoleFirstImage(3);
epipoleSecondImage = epipoleSecondImage / epipoleSecondImage(3);

% Display the epipoles
disp('Epipole in the first image:');
disp(epipoleFirstImage');

disp('Epipole in the second image:');
disp(epipoleSecondImage');
% Assuming image1 and image2 are already loaded
figure; imshow(image1); hold on;
plot(epipoleFirstImage(1), epipoleFirstImage(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
title('Epipole in the First Image');
hold off;

figure; imshow(image2); hold on;
plot(epipoleSecondImage(1), epipoleSecondImage(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
title('Epipole in the Second Image');
hold off;

