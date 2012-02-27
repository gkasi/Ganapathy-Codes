function [bestH2to1, bestError, inliers]=ransacH2to1(keypoints1, keypoints2, matches)
m=size(matches,2);
fitnessold=10000;
count=0;

while((count<1000))
 
% Selecting a random sample of 4 correspondences from a total of K points  
xi=randsample(m,4);
xy1=[keypoints1(1,matches(1,xi)) ;keypoints1(2,matches(1,xi))];
xy2=[keypoints2(1,matches(2,xi)) ;keypoints2(2,matches(2,xi))];

% Estimating the homography between these points
H=computeH_norm(xy1,xy2);

% Evaluating the model on all points
p1=[keypoints1(1,matches(1,:)) ;keypoints1(2,matches(1,:));ones(1,length(matches))];
p2=[keypoints2(1,matches(2,:)) ;keypoints2(2,matches(2,:));ones(1,length(matches))];
P1=H*p2;
for i=1:length(P1)
pest1(1:2,i)=P1(1:2,i)/P1(3,i);
end

% Evaluating the error on all points
dist=pdist2(pest1',p1(1:2,:)');
errs = diag(dist);

% Finding the inlier points which has error value less than a threshold
t=10;
inlier = find(errs < t);

% Checking for the no. of inliers
if (length(inlier)>=m/10)
fitnessnew= mean(errs(inlier));
% If error is less than old error, fitting a consensus set
if (fitnessold>fitnessnew)
          fitnessold=fitnessnew;
          bestError=fitnessnew;
          inliers=inlier;
          bestH2to1=H;
end
end
count=count+1;
end
end
