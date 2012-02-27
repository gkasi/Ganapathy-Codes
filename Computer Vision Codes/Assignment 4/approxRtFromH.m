function [R,t]=approxRtFromH(K,H)
       
% Normalising H and computing A matrix from H=KA
        H=H/H(3,3);
        A=K\H;

% finding column 1 and 2 of rotation matrix and t matrix from A=[R1 R2 t]
        R1=A(:,1);
        R2=A(:,2);
        t=A(:,3);
     
 % Normalising the first two columns of R and also computing scale from eigen values       
        R_tmp=[R1 R2];
        [u s v] = svd(R_tmp);
        scale=s(1,1)*s(2,2);
        s(1,1)=1;
        s(2,2)=1;
        R_tmp=u*s*v';
        
  % Finding the full rotation matrix by computing R3      
        R3=cross(R_tmp(:,1),R_tmp(:,2));
        R=[R1 R2 R3];
 
   % Normalising R again and also computing t upto scale     
        [u s v]=svd(R);
        R=u*v';

        t=(1/sqrt(scale))*t;
end        