image1 = imread('analysis.jpg'); %Reads the image from location
I = rgb2gray(image1); % changes RGB input image into grayscale for edge detection
subplot(2,2,1);
image(image1); %Displays image
subplot(2,2,2);
image(I);
BW = edge(I); %detects edges in the grayscale image (only in gray scale)
[r1,c1] = find(BW);
subplot(2,2,3);
spy(BW);
x2 = max(r1);
x1 = min(r1);
X = x2 - x1
y2 = max(c1);
y1 = min(c1);
Y = y2 - y1
subplot(2,2,4);
imshow(BW);
