%% Q2.6 To get panoroma from warp_im1 and warp_im2
% Obtain warp_im1 and warp_im2 from q2_5.m

%% Average Blend

imn = warp_im1;
for i=1:1280
    for j=1:2220
        for k=1:3
            if warp_im2(i,j,k) ~=0
                if imn(i,j,k)~=0
                  imn(i,j,k)=imn(i,j,k)/2+warp_im2(i,j,k)/2;
                else
                    imn(i,j,k)=warp_im2(i,j,k);
                end
            end
        end
    end
end

imavg=imn;
figure(1)
  imshow(imavg)   
 title('AvgBlend')
   
 %% Maskblend
mask = zeros(size(imn,1), size(imn,2));
mask(1,:) = 1; mask(end,:) = 1; mask(:,1) = 1; mask(:,end) = 1;
mask = bwdist(mask, 'city');
mask = mask/max(mask(:));

imn=warp_im1;

for i=1:1280
    for j=1:2220
        for k=1:3
            if warp_im2(i,j,k) ~=0
                if imn(i,j,k)~=0
                  imn(i,j,k)=(1-mask(i,j))*double(warp_im1(i,j,k))+mask(i,j)*double(warp_im2(i,j,k));
                else
                    imn(i,j,k)=warp_im2(i,j,k);
                end
            end
        end
    end
end

immask=imn;

figure(2)
imshow(immask)
title('MaskBlend')