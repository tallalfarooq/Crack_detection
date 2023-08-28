I = imread('analysis.jpg');
imshow(I)
BW = im2bw(I);
imshow(BW)
dim = size(BW)
col = round(dim(2)/2)-90;
row = min(find(BW(:,col)))
boundary = bwtraceboundary(BW,[row, col],'N');
imshow(I)
hold on;
plot(boundary(:,2),boundary(:,1),'g','LineWidth',3);
BW_filled = imfill(BW,'holes');
boundaries = bwboundaries(BW_filled);
for k=1:10
   b = boundaries{k};
   plot(b(:,2),b(:,1),'g','LineWidth',3);
end