function [histPyramid, vecHistPyramid] = createSpatialPyramid(textonMap, K, L)
H=(K/3)*(4^(L+1)-1);
histPyramid=cell(H/K,1);
vecHistPyramid=zeros(H,1);
m=size(textonMap,1);
n=size(textonMap,2);
I=mat2cell(textonMap,[m/(2^(L)) m/(2^(L)) m/(2^(L)) m/(2^(L))],[n/(2^(L)) n/(2^(L)) n/(2^(L)) n/(2^(L))]);
I=I(:);
    for j=(H/K-4^L+1):H/K
        histPyramid{j}=histc(I{j-5}(:),1:K);
    end
    for j=5:-1:1
        histPyramid{j}=histPyramid{4*j-2}+histPyramid{4*j-1}+histPyramid{4*j}+histPyramid{4*j+1};
    end
    
     for i=1:5
    vecHistPyramid((K*(i-1)+1):K*(i),1)=(1/4)*histPyramid{i};
    end
    
    for i=6:21
    vecHistPyramid((K*(i-1)+1):K*(i),1)=(1/2)*histPyramid{i};
    end
end