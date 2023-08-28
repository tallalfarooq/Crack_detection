clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 25;

%===============================================================================
% Get the name of the first image the user wants to use.
baseFileName = 'analysis.jpg';
folder = fileparts(which(baseFileName)); % Determine where demo folder is (works with all versions).
fullFileName = fullfile(folder, baseFileName);

% Check if file exists.
if ~exist(fullFileName, 'file')
  % The file doesn't exist -- didn't find it there in that folder.
  % Check the entire search path (other folders) for the file by stripping off the folder.
  fullFileNameOnSearchPath = baseFileName; % No path this time.
  if ~exist(fullFileNameOnSearchPath, 'file')
    % Still didn't find it.  Alert user.
    errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end

%=======================================================================================
% Read in demo image.
rgbImage = imread(fullFileName);
% Get the dimensions of the image.
[rows, columns, numberOfColorChannels] = size(rgbImage);
% Display the original image.
subplot(2, 2, 1);
imshow(rgbImage, []);
axis on;
caption = sprintf('Original Color Image, %s', baseFileName);
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');

% Set up figure properties:
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0.05 1 0.95]);
% Get rid of tool bar and pulldown menus that are along top of figure.
% set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')

drawnow;
hp = impixelinfo(); % Set up status line to see values when you mouse over the image.

[rows, columns, numberOfColorChannels] = size(rgbImage)
if numberOfColorChannels > 1
  % It's not really gray scale like we expected - it's color.
  % Use weighted sum of ALL channels to create a gray scale image.
%   grayImage = rgb2gray(rgbImage);
  % ALTERNATE METHOD: Convert it to gray scale by taking only the green channel,
  % which in a typical snapshot will be the least noisy channel.
  grayImage = rgbImage(:, :, 1); % Take red channel.
end

% Display the image.
subplot(2, 2, 2);
imshow(grayImage, []);
axis on;
caption = sprintf('Gray Image');
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
hp = impixelinfo();
drawnow;

% Display the histogram of the image.
subplot(2, 2, 3);
histogram(grayImage, 256);
caption = sprintf('Histogram of Gray Image');
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
grid on;
drawnow;

%=======================================================================================
binaryImage = grayImage < 150;
% Keep only the largest blob.
binaryImage = bwareafilt(binaryImage, 1);
% Display the masked image.
subplot(2, 2, 3);
imshow(binaryImage, []);
axis on;
caption = sprintf('Binary Image');
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
hp = impixelinfo();
drawnow;

% Get the bounding box of the blob.
props = regionprops(binaryImage, 'BoundingBox');
boundingBox = [props.BoundingBox]

% Display the original image.
subplot(2, 2, 4);
imshow(rgbImage, []);
axis on;
caption = sprintf('Original Color Image, %s', baseFileName);
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
% Plot the bounding box over it.
hold on;
rectangle('Position', boundingBox, 'LineWidth', 2, 'EdgeColor', 'r')