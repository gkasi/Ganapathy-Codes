% This function is used to calculate the flow of moving parts between two
% images
function [moving_image] = SubtractDominantMotion(image1, image2)

image1=medfilt2(image1/255);
image2=medfilt2(image2/255);

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

while ((norm1 > 0.0001)&&(count<1000))
%Vectorizing
Ix=Ix(:);
Iy=Iy(:);
 It=It(:);
 
 % Affine Matrix A
A=[X1.*Ix Y1.*Ix Ix X1.*Iy Y1.*Iy Iy]; 

% Calculating delp
delp=-inv(A'*A)*A'*It;

% Updating delp
p=p+delp;


a=p(1);
b=p(2);
c=p(3);
d=p(4);
e=p(5);
f=p(6);

% Calculating the Transformation matrix M
M=[1+a b c;
      d 1+e f;
      0 0 1];
  
 % Warped output of the first image 
warp_image1=medfilt2(warpH(image1,M,[size(image2,1) size(image2,2)]));
% imshow(warp_image1);
% drawnow;

% Difference between image 2 and warped image 1
It=(image2-warp_image1);

% calculating the norm value
norm1=norm(delp)
count=count+1

[Ix,Iy]=gradient(warp_image1,1/320,1/240);

end

It=abs(It);

% Doing median filtering for removing salt and pepper noise
moving_image=medfilt2(hysthresh(It,0.3,0.2));
se = strel('disk',8);
moving_image = imdilate(moving_image,se);

% figure
% imshow(moving_image);
end

% delI=conv2(image1,[1 -1;-1 0],'same');
% dw=[x 0 y 0 1 0;0 x 0 y 0 1];
