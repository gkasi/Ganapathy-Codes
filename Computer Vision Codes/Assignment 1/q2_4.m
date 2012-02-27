% Q 2.4
% cpselect('taj1.jpg','taj2.jpg')

% to load p1 and p2 (points selected using cpselect)
load q2_4.mat

% Making a 3xN array from 2xN array.
p2f=p2;
p2f(3,:)=1;

N=size(p2f,2)
% Computing H2to1 from the set of points p1 and p2 
H2to1=computeH_norm(p1,p2)

% Estimating p2 in reference of image 1
p2_t1=H2to1*p2f

%Dividing by the last co-ordinate. i.e x=a/c and y=b/c
for i=1:N
p2_t(1:2,i)=p2_t1(1:2,i)/p2_t1(3,i);
end

% save q2_4.mat H2to1 p1 p2 p2_t

%% Plotting image with overlapped pixels marked in green and red.
val1=int32(p1);

val2=int32(p2_t);

for i=1:15
    im((val1(2,i)-2:val1(2,i)+2),(val1(1,i)-2:val1(1,i)+2),1)=255;
    im((val1(2,i)-2:val1(2,i)+2),(val1(1,i)-2:val1(1,i)+2),2)=0;
    im((val1(2,i)-2:val1(2,i)+2),(val1(1,i)-2:val1(1,i)+2),3)=0;
    
    im((val2(2,i)-2:val2(2,i)+2),(val2(1,i)-2:val2(1,i)+2),1)=0;
    im((val2(2,i)-2:val2(2,i)+2),(val2(1,i)-2:val2(1,i)+2),2)=255;
    im((val2(2,i)-2:val2(2,i)+2),(val2(1,i)-2:val2(1,i)+2),3)=0;
end

imshow(im)

% imwrite(im,'q2.jpg','jpg');
%% Error using normalised H
disp('Error from estimate of p2 in Image 1 using Normalised H = ')
 E=norm(p1-p2_t)
 
 %% Error For Non-normalised H
 
 H=computeH(p1,p2)

% Estimating p2 in reference of image 1
p2_t1=H*p2f
 
%Dividing by the last co-ordinate. i.e x=a/c and y=b/c
for i=1:N
p2_s(1:2,i)=p2_t1(1:2,i)/p2_t1(3,i);
end

% Error for non-normalised H
disp('Error from estimate of p2 in Image 1 using NON - Normalised H = ')
 E=norm(p1-p2_s)
 %%
 
 %%

