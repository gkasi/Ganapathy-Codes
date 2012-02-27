function [textonMap, textonHisto] = textonify(I, filterBank, TextonLibrary)
K=size(TextonLibrary,1);
N=size(TextonLibrary,2); % No. of Filter Responses 
textonMap=zeros(256,256);  
temp=zeros(K,1);
filterResponses=extractFilterResponses(I,filterBank);
filterResponses=filterResponses(1:N,:)';
temp=pdist2(filterResponses,TextonLibrary);
[~,index]=min(temp');
textonMap=reshape(index,256,256);
% imagesc(textonMap);
textonHisto=histc(index,1:K);
end
