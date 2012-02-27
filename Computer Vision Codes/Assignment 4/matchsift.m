% Matching the best SIFT features of two images
function [matches,dists] = matchsift(D1, D2, alpha)

if (nargin == 2)
    alpha=0.8;
end

n=size(D1,2);
m=size(D2,2);

% Finding distances between two sets of feature points 
dist=pdist2(D1',D2');
dist2=dist;
xtemp=dist;

% Find the First and Second Closest Descriptors
[firstmin,index]=min(xtemp);
for i=1:m
xtemp(index(i),i)=Inf;
end
[secondmin,index2]=min(xtemp);

% The Closest descriptor is matched if the ratio of the first and second
% closest descriptors is less than alpha
count=1;
for i=1:m
    if (dist(index(i),i)/dist2(index2(i),i)) < alpha
        matches(1,count)=index(i);
        matches(2,count)=i;
        count=count+1;
    end
end

% Returning the distance between the matched points
for i=1:length(matches)
    dists(i)=dist(matches(1,i),matches(2,i));
end

end
