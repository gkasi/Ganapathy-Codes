% This function is used to cluster the points and also so to merge regions
% if cluster centre is less than threshold
function [C] = mergeRegions(A,I,distanceThreshold)
numClusters=min(50,size(A,1));
 disp(numClusters)
 [~, C] = adaptiveKmeans(A,numClusters, distanceThreshold);

end