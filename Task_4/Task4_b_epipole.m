% For the first image
[U, ~, V] = svd(fundamentalMatrix);
e2 = V(:, end); % Epipole in the second image is the null space of F
e2 = e2 / e2(3); % Convert to inhomogeneous coordinates

% For the second image
e1 = U(:, end); % Epipole in the first image is the null space of F'
e1 = e1 / e1(3); % Convert to inhomogeneous coordinates

% Display epipoles on the images
figure; imshow(image1); hold on; title('Epipole in Image 1');
plot(e1(1), e1(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);

figure; imshow(image2); hold on; title('Epipole in Image 2');
plot(e2(1), e2(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
