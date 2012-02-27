function [I,C] = splitAndFilter(I,C)
N=size(C,1);
m=size(I,1);
n=size(I,2);
count=1;
for i=1:N
    count1=0;
    Im=I;
    % Masking the image
    Im(Im~=i)=0;
    Im(Im==i)=1;
    % Finding the connected components
    CC = bwconncomp(Im);
    S = regionprops(CC,'Area');
    % If an object is not present in I remove it
    if (size(S,1)==0)
         for j=i+1:max(I(:))
            C(j-1,:)=C(j,:);
            I(I==j)=j-1;
        end
    end
    
  % If no. of objects in a cluster are more than one  
    if(size(S,1)>1)
        tmp=size(S,1);
        for k=1:tmp
            % Neglecting clusters if Area of a object is small
            if(S(k,1).Area<100)
                I=I(:);
                I(CC.PixelIdxList{1,k})=0;
                I=reshape(I,m,n);
            else
                % If more than one object in a cluster and with area >100,
                % then splitting the no. of regions into different clusters
                if(count1==1)
                     I=I(:);
                     % Assigning new cluster value to I
                     I(CC.PixelIdxList{1,k})=count+max(I);
                     %Updating the corresponding cluster Matrix
                     C(count+max(I),:)=C(i,:);
                     I=reshape(I,m,n);
                     count=count+1;
                end
                count1=1;
            end
        end
    end
end
end
                     
                