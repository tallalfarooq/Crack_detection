%% initiator 
clc;
clear;
close all;
%% Read the Input Image
InputImage=imread('analysis.jpg');
% Display the Input Image
figure(1)
imshow(InputImage);title('InputImage');

%% Convert the Gray Scale Image to Binary Image
BinaryImage=im2bw(InputImage);
%Display Binary Image
figure(2)
imshow(BinaryImage);
title('Image with Edges and Holes detected')

%% Complement the Binary Image
ComplementImage=imcomplement(BinaryImage);
figure(3)
imshow(ComplementImage);
title('Image with Edges and Holes detected if complimented')

%% Perform morphological operations
%Fill in the holes of a binary image
HolesClearedImage = imfill(ComplementImage,'holes');
%Display Holes Cleared Image
figure(4)
imshow(HolesClearedImage);title('Eoles Cleared Image');
%Apply labels for each binary connected component
%Apply Labels for each  connected components in 2-D binary image
[L,Num] = bwlabel(HolesClearedImage);
%% Calculation of Area marked by yellow line
[r,c] = size(ComplementImage);
num_elements = numel(ComplementImage);
region = 0;
for i = 1:r
    for j = 1:c
        if ComplementImage(i,j) == 1
            region = region + 1;
        end
    end
end
disp('Area covered by the outlined box is ')
area_covered = (region/num_elements)*100
%% Drawing the boundary line
% Calculate boundaries.
figure(5)
BW = imread('analysis4.jpg');
[B,L,N] = bwboundaries(im2bw(BW));
%% Display object boundaries in yellow!
imshow(BW); hold on;
for k=1:length(B),
   boundary = B{k};
   if(k > N)
     plot(boundary(:,2), boundary(:,1), 'y','LineWidth',2);
     title('Outlined Portion having Edges and Boundary')
   end
end
%% Displaying holes and numbered too!
BW = imread('analysis4.jpg');
figure(6)
%Calculate boundaries of regions in the image.
[B,L,N,A] = bwboundaries(im2bw(BW));

%Display the image with the boundaries overlaid. 
%Add the region number next to every boundary (based on the label matrix). 
%Use the zoom tool to read individual labels.
imshow(BW); hold on;
colors=['b' 'g' 'r' 'c' 'm' 'y'];
for k=1:length(B)
  boundary = B{k};
  cidx = mod(k,length(colors))+1;
  plot(boundary(:,2), boundary(:,1),...
       colors(cidx),'LineWidth',2);
   title('Holes detected with random Colours')
end
%%

inp_img=im2uint8(HolesClearedImage);

if(size(size(inp_img),2)>2)
    gray_img=rgb2gray(inp_img);
else
    gray_img=inp_img;
end
[height_val,width_val,w_h_img]=image_height_width ( gray_img );
figure,imshow(w_h_img),title('Height and Width Image');impixelinfo;
msgbox(strcat('The Width and Height Pixel Counts are=',num2str(width_val),':',num2str(height_val)));