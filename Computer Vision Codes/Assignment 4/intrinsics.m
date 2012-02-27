 
fx = 569.79;
fy = fx';
cx = 401.6;
cy = 199.15;

% Intrinsic parameters of test camera
K = [fx 0 cx; 
     0 -fy cy;  % Negative sign makes image axis grow down 
     0 0 1];
 
 
% 2D sift template image to object space offset (center in image)
mu = [614/2; 474/2];