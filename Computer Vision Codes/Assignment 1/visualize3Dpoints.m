function visualize3Dpoints(XY)
% FUNCTION visualize3Dpoints(X)
% Given 3D joint locations, visualizes the human skeleton
%
% INPUT - XY = 23x3 matrix of 3D points
%
% 16-720 Computer Vision Fall 2011. Carnegie Mellon University.
% Author: Varun Ramakrishna.
vals =XY;


for i =1:size(vals,1)
    strs{i}={int2str(i)};
end

load connectMat;
indices = find(connectMat);
[I, J] = ind2sub(size(connectMat), indices);

handle(1) = plot3(vals(:, 1), vals(:, 3), vals(:, 2), '.');
axis ij % make sure the left is on the left.
set(handle(1), 'markersize', 1);

hold on
grid on
colors=prism(6);

M= [colors(4:6,:); colors(1,:); ...
    colors(4:6,:); colors(1,:); ...
    colors(6,:); colors(6,:); colors(6,:); colors(5,:); colors(6,:); colors(5,:);...
    colors(1,:); colors(2,:); colors(1,:); colors(4,:); ...
    colors(1,:); colors(2,:); colors(1,:); colors(4,:);...
    ];

for i = 1:length(indices)
    handle(i+1) = line([vals(I(i), 1) vals(J(i), 1)], ...
        [vals(I(i), 3) vals(J(i), 3)], ...
        [vals(I(i), 2) vals(J(i), 2)]);
    set(handle(i+1), 'linewidth', 5,'Color',M(i,:));
end
axis equal