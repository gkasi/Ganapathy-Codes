% This program is used to overlay the image axes and the outline of the
% image into the picture
[n m]=size(I1);

%% Drawing the boundary of the template in the test image
impoints=[1 1 1;
                  m 1 1;
                  m n 1;
                   1 n 1;
                   1 1 1];

H=bestH2to1;
pim2=inv(H)*impoints';

  for i=1:length(pim2)
        Pim2(1:2,i)=pim2(1:2,i)/pim2(3,i);
  end
   
  X=Pim2(1,:);
  Y=Pim2(2,:);
  
  imagesc(im2)
   % Creating line objects for the projected points

    for i=1:4
      line([X(i) X(i+1)],[Y(i) Y(i+1)],'Color','m','LineWidth',2) 
    end
  
    %% Drawing the image axes in the test image
    impoints=[  m/2 n/2 0;
                        m/2 n 0;
                        m n/2 0;
                        m/2 n/2 300];
              
     H=bestH2to1;
     H=inv(H);
                    
    [R,t]=approxRtFromH(K,H);
    
    % Projecting in three dimensions so as to get overlay of Z axes as well
    pim2 = projectP3D_1( impoints, K, R, t);

  for i=1:length(pim2)
        Pim2(1:2,i)=pim2(1:2,i);
  end
   
  X=Pim2(1,:);
  Y=Pim2(2,:);
  
  % Creating line objects for the projected points
  
   line([X(1) X(2)],[Y(1) Y(2)],'Color','g','LineWidth',2) 
   line([X(1) X(3)],[Y(1) Y(3)],'Color','r','LineWidth',2) 
   line([X(1) X(4)],[Y(1) Y(4)],'Color','b','LineWidth',2) 
   
  hold on