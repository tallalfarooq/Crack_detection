clc;
clear all;
close all;
[file,path]=uigetfile({'*.jpg';'*.png';'*.bmp';'*.*'},'Select image');
figure
if(path)
    inp_img=imread([path file]);
    subplot(1,2,1),imshow(inp_img),title('Input Image')
else
    msgbox('select correct image');
end
if(size(size(inp_img),2)>2)
    gray_img=rgb2gray(inp_img);
else
    gray_img=inp_img;
end
subplot(1,2,2),imshow(gray_img),title('Gray Image');
[height_val,width_val,w_h_img]=image_height_width ( gray_img );
figure,imshow(w_h_img),title('Height and Width Image');impixelinfo;
 msgbox(strcat('The Width and Height Pixel Counts are=',num2str(width_val),':',num2str(height_val)));
