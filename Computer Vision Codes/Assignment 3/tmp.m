N=size(C,1);
m=size(I,1);
n=size(I,2);
count=1;
for i=1:N
    count1=0;
    Im=I;
    Im(Im~=i)=0;
    Im(Im==i)=1;
    CC = bwconncomp(Im);
    S = regionprops(CC,'Area');
    if (size(S,1)==0)
        for j=(i+1):max(I(:))
            C(j-1,:)=C(j,:);
            I(I==j)=j-1;
        end
    end
    
    if(size(S,1)>1)
        tmp=size(S,1);
        for k=1:tmp
            if(S(k,1).Area<100)
                I=I(:);
                I(CC.PixelIdxList{1,k})=NaN;
                I=reshape(I,m,n);
                for j=(i+1):max(I(:))
                    C(j-1,:)=C(j,:);
                    I(I==j)=j-1;
                end
            else
                if(count1==1)
                     I=I(:);
                     I(CC.PixelIdxList{1,k})=count+max(I);
                     C(count+max(I),:)=C(i,:);
                     I=reshape(I,m,n);
                     count=count+1;
                end
                count1=1;
            end
        end
    end
end