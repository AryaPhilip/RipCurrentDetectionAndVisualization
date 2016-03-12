function [img, rad]= MaskingFlow(img, rad)

%img_gray = rgb2gray(img);
img_hsv = rgb2hsv(img);

imhist(img_hsv(:,:,1));
close all;

%figure;
%imshow(img);

mask_hsv = img_hsv(:,:,1) >= 0.5000 & img_hsv(:,:,1) < 0.6944;
mask_hsv = ~mask_hsv;
%figure;
%imshow(img_gray);

rIm = img(:,:,1);
gIm = img(:,:,2);
bIm = img(:,:,3);

rIm(mask_hsv) = 0;
gIm(mask_hsv) = 0;
bIm(mask_hsv) = 0;
rad(mask_hsv) = 0;

mask_rad = rad >= 0.1667 & rad < 1;
rad(~mask_rad) = 0;

img(:,:,1) = rIm;
img(:,:,2) = gIm;
img(:,:,3) = bIm;

%figure;
%imshow(output_image)