% This function is used to homography between two set of points
% p1,p2 - 2xN Matrices with corresponding points
% H - 3x3 Matrix which maps the homography between the set of points from
% p2 to the set of points in p1

function H=computeH(p1,p2)
    N=size(p1,2);
    
    while (N~=size(p2,2))
        disp('The number of corresponding points in p1 and p2 do not match');
        break;
    end
    
    % p1 - co-ordinates are (x,y)
    % p2 - co-ordinates are (u,v)
    
    % A - matrix which has the values of p1 and p2 in the format Ah = b
    % where b is 0 and h is to be determined. 
    
    A=zeros(2*N,9);
    
    for i=1:N
        A(2*i-1,1:9)=[p2(1:2,i)' ones(1,1) zeros(1,3) -p1(1,i)*p2(1:2,i)' -p1(1,i)];
        A(2*i,1:9)  = [zeros(1,3) p2(1:2,i)' ones(1,1) -p1(2,i)*p2(1:2,i)' -p1(2,i)];
    end
    
    % Performing singular value decomposition of A to obtain h
    [U S V]=svd(A);
    
    % h is the last column of V (since it corresponds to values of the
    % least eigen value)
    h=V(1:9,9); 
    
   % H - 3x3 matrix is reconstructed from h - 9x1 vector 
    H=reshape(h,3,3)';
    
    % Testing - to check whether A*h=b i.e. A*h = 0
    A*h;
    
  
end