%% Q3.6 Evaluating the drawcam function
% See q3_6.jpg for output image

load hw1_problem3.mat

[R t]=estimateCamera2(xy,XYZ);

visualize3Dpoints(XYZ)
drawcam(R,t);

