function [filterResponses]=extractFilterResponses(I,filterBank)
filterResponses=zeros(3*size(filterBank,1),256,256);
[L,a,b]=RGB2Lab(I);
L=double(L);
a=double(a);
b=double(b);
for i=1:12
    filterResponses(i,:,:)=imfilter(L,filterBank{i});
    filterResponses(i+12,:,:)=imfilter(a,filterBank{i});
    filterResponses(i+24,:,:)=imfilter(b,filterBank{i});
end
end

