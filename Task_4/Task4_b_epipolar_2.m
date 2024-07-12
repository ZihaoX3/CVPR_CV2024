
% Check if the fundamental matrix was estimated successfully
if status == 0
    % Convert inlier points from the second image to homogeneous coordinates
    pointsHomogeneous2 = [inlierBasePoints, ones(size(inlierBasePoints, 1), 1)];

    % Compute epipolar lines in the first image for inlier points in the second image
    % This time we use the transpose of the fundamental matrix
    epipolarLinesInImage1 = (fundamentalMatrix' * pointsHomogeneous2')';

    % Display the first image
    figure; imshow(image1); hold on; title('Epipolar Lines in Image 1');

    % Draw the epipolar lines on the first image
    for i = 1:size(epipolarLinesInImage1, 1)
        a = epipolarLinesInImage1(i, 1);
        b = epipolarLinesInImage1(i, 2);
        c = epipolarLinesInImage1(i, 3);

        % Define line parameters
        x = 1:size(image1, 2); % Cover the entire width of the image
        y = (-a*x - c) / b; % Compute y coordinates of the epipolar line

        % Plot the line
        plot(x, y, 'Color', 'yellow', 'LineWidth', 1);
    end

    % Additionally, plot the inlier points on image1
    plot(inlierInputPoints(:,1), inlierInputPoints(:,2), 'go', 'MarkerSize', 5, 'LineWidth', 1.5);

    hold off;
end

