% This function is used to calculate the Normalization matrix (N) for each set
% of points in a plane. Also it returns the set of points in a homogenous
% co-ordinate representation. 
%Input p = 2xN  
%Output N= 3x3  pm=3xN
function [N, pm]=normmat(p)
% Representing p (2xN) in a homogenous representation pm (3xN)
pm(1:2,:)=p(1:2,:);
pm(3,:)=1;

% xrange and yrange account for scaling of the points
% xavg and yavg are used for the translation of the points
xrange=range(pm(1,:))/2;
xavg=(max(pm(1,:)) + min(pm(1,:)))/2 ;

yrange=range(pm(2,:))/2;
yavg=(max(pm(2,:)) + min(pm(2,:)))/2 ;

% Normalization matrix constructed by accounting for scaling and
% translation of the points
N=[1/xrange   0            -xavg/xrange;
      0            1/yrange   -yavg/yrange; 
      0               0                1               ];

end