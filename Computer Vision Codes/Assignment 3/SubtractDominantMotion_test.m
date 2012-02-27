% load data\carSequence.mat
% i=50;
fname = sprintf('%s\\frame%d.pgm',path_to_images,7);
image1=im2double(imread(fname));
fname = sprintf('%s\\frame%d.pgm',path_to_images,8);
image2=im2double(imread(fname));

% image1=im2double(rgb2gray(sequence(:,:,:,i)));
% image2=im2double(rgb2gray(sequence(:,:,:,i+1)));

% load data\carSequence.mat
% i=10;
% image1=medfilt2(image1);
% image2=medfilt2(image2);

X=1:size(image1,2);
Y=1:size(image1,1);
[X1,Y1]=meshgrid(X,Y);

Ix=conv2(image1,[1 -1],'same');
Iy=conv2(image1,[1 -1]','same');
It=image2-image1;

X1=X1(:);
Y1=Y1(:);

norm1 =1;
count=0;
p=[0 0 0 0 0 0]';

while (norm1 > 0.001)

Ix=Ix(:);
Iy=Iy(:);
 It=It(:);
A=[X1.*Ix Y1.*Ix Ix X1.*Iy Y1.*Iy Iy]; 

delp=-inv(A'*A)*A'*It;

p=p+delp;


a=p(1);
b=p(2);
c=p(3);
d=p(4);
e=p(5);
f=p(6);

M=[1+a b c;
      d 1+e f;
      0 0 1];
  
warp_image1=medfilt2(warpH(image1,M,[size(image2,1) size(image2,2)]));
imshow(warp_image1);
drawnow;

It=(image2-warp_image1);

norm1=norm(delp)
count=count+1

[Ix,Iy]=gradient(warp_image1,1/320,1/240);

end

It=abs(It);

moving_image=medfilt2(hysthresh(It,0.25,0.22));
se = strel('disk',11);
moving_image = imdilate(moving_image,se);

figure
imshow(moving_image);


% delI=conv2(image1,[1 -1;-1 0],'same');
% dw=[x 0 y 0 1 0;0 x 0 y 0 1];
