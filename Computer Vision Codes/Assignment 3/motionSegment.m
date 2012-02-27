%This function is used to calculate the motion flwo from the velocity of
%motion between two frames.
function [I, C] = motionSegment(vx,vy)
% m=no of rows of I;n=no of columns of I
m=size(vx,1);
n=size(vx,2);
I=zeros(m,n);
norm1=1500;
% Initialising the matrix I will 10x10 windows
for i=1:m
    for j=1:n
        I(i,j)=ceil((i/10)-1)*ceil(n/10)+ceil(j/10);
    end
end
C=zeros(10,1);
j=1;
while ((j<4)&&(norm1>1000)&&size(C,1)~=2)
     disp(['Iteration...',num2str(j)]);

[A] = generateAffineHypotheses(vx, vy, I);

distanceThreshold=50;

[C] = mergeRegions(A,I,distanceThreshold);

 [I]= assignRegions(vx,vy,C);
 
 [I,C] = splitAndFilter(I,C);

% Checking for norm 
 if j>1
 norm1=norm(I2(:)-I(:));
 end

 I2=I;
 j=j+1;
 end
end