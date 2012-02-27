% this program is used to generate the  and get the
% affine vector matrix A (N*6)

function [A] = generateAffineHypotheses(vx, vy, I)
vx1=vx(:);
vy1=vy(:);
I1=I(:);

X=1:size(vx,2);
Y=1:size(vy,1);
[X1,Y1]=meshgrid(X,Y);

%Normalising the coordinates
X=X1(:)/max(max(X1));
Y=Y1(:)/max(max(Y1));

N=max(I1);
% A=zeros(N,6);
count=1;

for i=1:N
   index=find(I1==i);
   sumst=zeros(3,3);
   sumsivx=zeros(3,1);
   sumsivy=zeros(3,1);
   for j=1:length(index)
       % Si matrix of the form [x y 1]'
       si=[X(index(j)) Y(index(j)) 1]';
       
       % Calculating Si x Si Transpose
       sisit=si*si';
         
       % summing the Si x Si Transpose for all pixel with same cluster
       % value
        sumst=sumst+sisit;
        
        % Calculating Si x Vx1 and Si x Vy1 
        sivx=si*vx1(index(j));
        sivy=si*vy1(index(j));
        
        sumsivx=sumsivx+sivx;
        sumsivy=sumsivy+sivy;
   end
   
   % ax is inverse of sum of si x si' and  sum of si x Vx
   ax=sumst\sumsivx;
   ay=sumst\sumsivy;
   
   At=[ax' ay'];
   
   % Updating the affine parameter matrix only if values are defined
   if (sum(isnan(At))==0);
   A(count,:)=At;
   count=count+1;
   end
end
save A.mat A
end
       
      
 
