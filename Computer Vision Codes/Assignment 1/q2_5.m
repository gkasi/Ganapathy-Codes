%% Q2.5 To calculate Matrix M and outsize(1) and perform the following functions
% warp_im1=warpH(im1, M, out_size);
% warp_im2=warpH(im2, M*H2to1, out_size);

% to load p1 and p2 (points selected using cpselect)
% load q2_4.mat

% Initialising outsize 2
out_size(1:2)=[0 1280];

im1=imread('taj1.jpg');
im2=imread('taj2.jpg');

H2to1=computeH_norm(p1,p2);

% taking height and width of image 2
im2ht=size(im2,1);
im2wt=size(im2,2);

% Take corner points of image 2 as p2c and estimate it in the reference plane of image 1

p2c=[1  1   im2wt im2wt;
           1 im2ht 1 im2ht;
           ones(1,4)];
       
% Estimating corner points in reference of Image 1
p2c_est1 = H2to1*p2c;

% divide by last row i.e x=a/c,  y=b/c
N=4
for i=1:N
p2c_est(1:2,i)=p2c_est1(1:2,i)/p2c_est1(3,i);
end

% Maximum and minimum height after estimation
p2c_htmax=max(p2c_est(2,:));
p2c_htmin=min(p2c_est(2,:));


%% Calculating matrix M
% Now equating max height = outsize(2) , minheight = 1
% Getting scale and translate

scale = double((out_size(2)-1)/(p2c_htmax-p2c_htmin));
translate = -scale*p2c_htmin + 1;

% Matrix M
M = [scale 0       0;
        0 scale translate;
        0        0        1];
    %%
    
    % Calculating Outsize(1) from p2c_est and scale
    out_size(1)=int32(max(scale*p2c_est(1,:)))

    %% Calculating warp_im1 and warp_im2 from the  calculated H
    
warp_im1=warpH(im1, M, [out_size(2) out_size(1)]);
subplot(1,2,1)
imshow(warp_im1)
title('Warped Image1');
warp_im2=warpH(im2, M*H2to1, [out_size(2) out_size(1)]);
subplot(1,2,2)
imshow(warp_im2)
title('Warped Image2');

