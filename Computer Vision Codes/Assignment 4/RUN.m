clc
clear all
close

% Getting the train and test images and converting them into grayscale and
% double
im1=imread('C:\Users\Ganapathy\Desktop\Viki\BW_after.jpg');
im2=imread('C:\Users\Ganapathy\Desktop\Viki\BW_bef.jpg');
% 
im1=imresize(im1,[400 600]);
im2=imresize(im2,[400 600]);

I1=im2double(rgb2gray(im1));
I2=im2double(rgb2gray(im2));

disp('Images Read .... ');

intrinsics
 
 % Performing SIFT on the images and obtaing the keypoints and descriptors
[keypoints1,descriptors1] = sift( I1);
[keypoints2,descriptors2] = sift( I2);
disp('SIFT computed .... ');

% Performing SIFT macthing and displaying the matced the feature points
[matches,~]=matchsift(descriptors1, descriptors2);
plotmatches(im1, im2, keypoints1, keypoints2, matches);
disp('SIFT points matched....')

% Performing RANSAC to obtain the best matched points and its homography
[bestH2to1, bestError, inliers]=ransacH2to1(keypoints1, keypoints2, matches);
disp('RANSAC completed....');

% Obtaing match values from inliers and plotting the best matches
matches_ransac=zeros(2,length(inliers));
 for i=1:length(inliers)
     matches_ransac(1:2,i)=matches(1:2,inliers(i));
 end
 figure;
 plotmatches(im1, im2, keypoints1, keypoints2, matches_ransac);
  
 % Computing the homography of H from image 1 to image 2
H=bestH2to1;
H=inv(H) ;

% Caluclating R and t from K and H
[R,t]=approxRtFromH(K,H);

% overlay the image axes and the outline of the image into the picture
figure;
q4_7

% Projecting and Displaying the Bunny image
displaybunny
disp('Bunny Image projected into test image.....');