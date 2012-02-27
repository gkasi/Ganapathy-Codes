clc
clear all
% close all
figure
im=imread('objets\objet2.jpg');
[points,cornerness] = harris(rgb2gray(im));
size(points)

% Show the cornerness heatmap
figure;imagesc(cornerness);
colormap('gray')

% And the detected corners
figure;imshow(im); hold on; 

% Choose threshold such that we show 500 points
nShow = min(500, size(points,1)); 
points = points(1:nShow, :);
plot(points(:,1),points(:,2),'r.', 'MarkerSize', 20);

% Compute scale
S = points(:,3)-min(points(:,3));
S = (S./max(S))*20 +10; 

