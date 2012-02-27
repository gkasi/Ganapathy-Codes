% histInter = 1xT
% textonHist = Kx1
% histograms = KxT
function [histInter] = distanceToSet(textonHist, histograms)
K=size(histograms,1);
T=size(histograms,2);
histInter=zeros(1,T);
for i=1:T
    for j=1:K
        histInter(1,i)=histInter(1,i)+min(textonHist(j,1), histograms(j,i));
    end
end
end
    