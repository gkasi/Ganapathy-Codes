function [bestH2to1, bestError, inliers]=ransacH2to1_full(keypoints1, keypoints2, matches)
m=size(matches,2);
fitnessold=10000;
fitnessnew=9999;
noc=4;
d=1;
count=0;
while((count<1000))
  
    
xi=randsample(m,noc);

xy1=[keypoints1(1,matches(1,xi)) ;keypoints1(2,matches(1,xi))];
xy2=[keypoints2(1,matches(2,xi)) ;keypoints2(2,matches(2,xi))];

H=computeH_norm(xy1,xy2);

p1=[keypoints1(1,matches(1,:)) ;keypoints1(2,matches(1,:));ones(1,length(matches))];
p2=[keypoints2(1,matches(2,:)) ;keypoints2(2,matches(2,:));ones(1,length(matches))];
P1=H*p2;
for i=1:length(P1)
pest1(1:2,i)=P1(1:2,i)/P1(3,i);
end

temp1=pest1-p1(1:2,:);

dist=sqrt(sum(temp1.*temp1));
t=1;
inlier=dist;
inlier(inlier<=t)=1;
inlier(inlier>t)=0;


if (sum(inlier)>=m/10)
    match_inlier = zeros(2,sum(inlier));
    counter=1;
    for i =1 :m
        if (inlier(i)==1)
           match_inlier(:,counter)=matches(:,i);
           counter=counter+1;
        end
    end
    
    clear xy1 xy2 p1 p2 P1 pest1 temp1 dist
    xy1=[keypoints1(1,match_inlier(1,:)) ;keypoints1(2,match_inlier(1,:))];
    xy2=[keypoints2(1,match_inlier(2,:)) ;keypoints2(2,match_inlier(2,:))];
    H_inlier=computeH_norm(xy1,xy2);

   p1=[keypoints1(1,match_inlier(1,:)) ;keypoints1(2,match_inlier(1,:));ones(1,length(match_inlier))];
   p2=[keypoints2(1,match_inlier(2,:)) ;keypoints2(2,match_inlier(2,:));ones(1,length(match_inlier))];
  
   P1=H_inlier*p2;
   for i=1:length(P1)
    pest1(1:2,i)=P1(1:2,i)/P1(3,i);
   end

   temp1=pest1-p1(1:2,:);

  dist=sqrt(sum(temp1.*temp1));

fitnessnew=sum(dist)/length(dist);
if (fitnessold>fitnessnew)
          fitnessold=fitnessnew;
          bestError=fitnessnew;
          bestH2to1=H;
          inliers=inlier;
          bestdist=dist;
          intrinsics
    xy1=[keypoints1(1,match_inlier(1,:)) ;keypoints1(2,match_inlier(1,:))];
    xy2=[keypoints2(1,match_inlier(2,:)) ;keypoints2(2,match_inlier(2,:))];
% 
% for i=1:length(xy1)
%     xy1(1,i)=xy1(1,i)-mu(1);
%     xy1(2,i)=xy1(2,i)-mu(2);
%     xy2(1,i)=xy2(1,i)-mu(1);
%     xy2(2,i)=xy2(2,i)-mu(2);
% end
% 
% 
% 
% H=computeH_norm(xy1,xy2)
bestH2to1=H;
         % d=sum(inliers);
end
end
count=count+1
end

end