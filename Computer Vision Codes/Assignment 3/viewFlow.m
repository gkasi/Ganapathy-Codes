function viewFlow(vx,vy)
% function viewFlow(vx,vy)
% Down samples the optical flow for visualization and plots it using
% MATLAB's quiver function
%
% CMU Computer Vision Fall 2011. Author: Varun Ramakrishna.
figure;
[x,y]= meshgrid(1:10:size(vx,2),1:10:size(vy,1));
vx1 = vx(1:10:end,1:10:end);
vy1 = vy(1:10:end,1:10:end);
quiver(x,y,vx1,vy1)
axis image;