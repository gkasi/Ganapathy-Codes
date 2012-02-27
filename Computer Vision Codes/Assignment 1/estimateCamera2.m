% This function is used to estimate position of camera  (i.e to obtain camera matrix M = [ R t ] ) from 3D and 2D
% points
% xy- 3xN Matrix with corresponding points in image plane (x,y,1)
% XYZ - 3xN Matrix with corresponding points in space (X,Y,Z)
% R is a 3x3 matrix
% t is a 3x1 matrix

function [R t] = estimateCamera2(xy, XYZ)
p1 = xy';
p2=XYZ';

N=size(p1,2);
    
    while (N~=size(p2,2))
        disp('The number of corresponding points in p1 and p2 do not match');
        break;
    end
    
    % p1 - co-ordinates are (x,y,1)
    % p2 - co-ordinates are (X,Y,Z)
    
    % A - matrix which has the values of p1 and p2 in the format Am = b
    % where b is 0 and h is to be determined. 
    
    A=zeros(2*N,12);
    
    for i=1:N
        A(2*i-1,1:12)=[p2(1:3,i)' ones(1,1) zeros(1,4) -p1(1,i)*p2(1:3,i)' -p1(1,i)];
        A(2*i,1:12)  = [zeros(1,4) p2(1:3,i)' ones(1,1) -p1(2,i)*p2(1:3,i)' -p1(2,i)];
    end
    
    % Performing singular value decomposition of A to obtain m
    [U S V]=svd(A);
    
    % m is the last column of V (since it corresponds to values of the
    % least eigen value)
    m=V(1:12,12); 
    
   % M - 3x4 matrix is reconstructed from m - 12x1 vector 
    M=reshape(m,4,3)';
    
   % Steps to estimate the normalised R
    Rn=M(1:3,1:3);
    
    [U S V]=svd(Rn);
    
    % Determining scaling factor for t matrix
    Scale=1/S(3,3);
    
    % Equating S to Identity so as to obtain a normalised R matrix
    S=eye(3);
    
    % Estimating the normalised R
    R=U*S*V';
    
    if int32(det(R))==-1
        R=-R;
        Scale=-Scale;
    end
    
    t=Scale*M(1:3,4);
    
    
    % Testing - to check whether A*m=b i.e. A*m = 0
    A*m;
    
  
end