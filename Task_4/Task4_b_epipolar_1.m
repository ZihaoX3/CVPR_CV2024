% ---------------
image1 = imread('FD_with_1.jpg');
image2 = imread('FD_with_2.jpg'); 

% Assuming the 'fundamentalMatrix' and inlier points are correctly estimated
if status == 0
    % Convert inlier points from the first image to homogeneous coordinates
    pointsHomogeneous = [inlierInputPoints, ones(size(inlierInputPoints, 1), 1)];
    
    % Compute epipolar lines in the second image for inlier points in the first image
    epipolarLines = (fundamentalMatrix * pointsHomogeneous')';
    
    % Display the second image
    figure; imshow(image2); hold on; title('Epipolar Lines in Image 2');
    
    % Draw the epipolar lines on the second image
    for i = 1:size(epipolarLines, 1)
        a = epipolarLines(i, 1);
        b = epipolarLines(i, 2);
        c = epipolarLines(i, 3);
        
        % Define line parameters
        x = 1:size(image2, 2); % Cover the entire width of the image
        y = (-a*x - c) / b; % Compute y coordinates of the epipolar line
        
        % Plot the line
        plot(x, y, 'Color', 'yellow', 'LineWidth', 1);
    end
    
    % Additionally, plot the inlier points on image2
    plot(inlierBasePoints(:,1), inlierBasePoints(:,2), 'go', 'MarkerSize', 5, 'LineWidth', 1.5);
    
    hold off;
end

