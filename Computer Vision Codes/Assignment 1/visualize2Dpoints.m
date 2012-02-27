function visualize2Dpoints(xy)
% FUNCTION visualize2Dpoints(xy)
% Given 2D joint location visualizes the skeleton
% 
% INPUT: xy - 2x23 matrix of joint locations in the form of [ x; y] where x
%        is a row of the x-coordinates of the points and y is a row of
%        y-coordinates of the points.
%
%
%
% 16-720 Computer Vision Fall 2011. Carnegie Mellon University.
% Author: Varun Ramakrishna.

xy = xy';
numPts=size(xy,2);
for i =1:numPts
    strs{i}={int2str(i)};
end

load connectMat;
indices = find(connectMat);
[I, J] = ind2sub(size(connectMat), indices);

%figure
plot(xy(1,:),xy(2,:),'x');
hold on
colors=prism(6);
M= [colors(4:6,:); colors(1,:); ...
    colors(4:6,:); colors(1,:); ...
    colors(6,:); colors(6,:); colors(6,:); colors(5,:); colors(6,:); colors(5,:);...
    colors(1,:); colors(2,:); colors(1,:); colors(4,:); ...
    colors(1,:); colors(2,:); colors(1,:); colors(4,:);...
    ]; 

for i =1:size(xy,2)
    text(xy(1,i),xy(2,i),strs{i});
end

axis equal
for i = 1:length(indices)
  handle(i+1) = line([xy(1,I(i)) xy(1,J(i))], ...
                     [xy(2,I(i)) xy(2,J(i))],'color',M(i,:));
  set(handle(i+1), 'linewidth', 2);
end