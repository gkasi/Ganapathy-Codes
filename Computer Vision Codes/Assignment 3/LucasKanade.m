% This function is used to calculate estimates the motion of a template from frame It to
% It1. The boundaries of the template are given in rect=[x1,y1,x2,y2]
function [u,v] = LucasKanade(It,It1,rect)
% Initialising u,v for motion estimate. 
u=0;
v=0;
% Initialising u1,v1 which are updates for u,v in each iteration
u1=0;
v1=0;
count=0; % No. of iterations for convergence
p=[u v]; % Parameters p which are estimated.
norm=1;

% Meshgrid for X,Y for the entire range of image
[X,Y]=meshgrid(1:size(It,2),1:size(It,1));

% Meshgrid for the coordinates in the template T
Y1=rect(2):rect(4); 
X1=rect(1):rect(3);
 [XI,YI]=meshgrid(X1,Y1);
  
 % Calculating the values of the template using interpolation
 T=interp2(X,Y,It,XI,YI);

 % Calculating the X and Y derivaties for the templates
Tx=conv2(T,[1 -1],'same');
Ty=conv2(T,[1 -1]','same');
    
M=inv([sum(sum(Tx.*Tx)) sum(sum(Tx.*Ty));sum(sum(Tx.*Ty)) sum(sum(Ty.*Ty))]);

while((norm>0.01)&&(count<100))
    u=u-u1;
    v=v-v1;
    p=[u v];

    XI1=X1+p(1);
    YI1=Y1+p(2);
    [XI,YI]=meshgrid(XI1,YI1);
    
    Iw=interp2(X,Y,It1,XI,YI);
    
    ErIm=T-Iw;
    Er=ErIm(:);
    
    Sx=(-M(1,1)*Tx)+(-M(1,2)*Ty);
    Sx1=Sx(:);
    
    Sy=(-M(2,1)*Tx)+(-M(2,2)*Ty);
    Sy1=Sy(:);
    
    u1=sum(Sx1.*Er);
    v1=sum(Sy1.*Er);
    
    norm=sqrt(u1^2+v1^2);
    count=count+1;

end
count
end


