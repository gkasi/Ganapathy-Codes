function [IDX, C] = adaptiveKmeans(X, numClusters, distThresh)
% [IDX, C] = adaptiveKmeans(X)
% Inputs:
% X  - Nx6 data
% numClusters = number of k-means clusters
% distThresh  = threshold on distance between cluster centres for merging clusters
%
% Simple version of adaptive k-means described in Wang and Adelson.
% Author : Varun Ramakrishna



[IDX, C ]= kmeans(X, numClusters,'EmptyAction', 'drop');

% Combine close centers
s = squareform(pdist(C,'euclidean'));

for i = 1:size(s,1)
    
    % Find closest cluster centre.
    dists =s(i,:);
    dists(i) = inf;
    ind = find(dists == min(dists));
    
    % check if dist is less than threshold.
    if(dists(ind)<distThresh)
        
        N1 = sum(IDX ==i);
        N2 = sum(IDX ==ind);
        
        % Keep cluster which has more members.
        if(N1 > N2)
            IDX(IDX==ind)= i;
            C(ind,:) = NaN;
            s(ind,:) = NaN;
            s(:,ind) = NaN;
        else
            IDX(IDX==i)= ind;
            C(i,:) = NaN;
            s(i,:) = NaN;
            s(:,i) = NaN;
        end
    end
    
end

ids = unique(IDX);
ids(isnan(ids))=[];
ids(ids ==NaN) = [];
C = C(ids,:);

%Re-assign IDs and recompute means.
for i = 1:length(ids)
    IDX(IDX==ids(i))=i;
    C(i,:) = mean(X(IDX==i,:),1);
end
ids = unique(IDX);
length(ids)
