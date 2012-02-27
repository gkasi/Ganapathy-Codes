function [points, cornerness] = harris(I)

I = im2double(I);

k=0.04;

% Computing x and y derivatives of image
G=fspecial('gaussian',[3 3],0.001);
[Gx Gy]=gradient(G);
Ix=conv2(I,Gx,'same');
Iy=conv2(I,Gy,'same');

% Computing the products of derivatives at every pixel
Ix2=Ix.*Ix;
Iy2=Iy.*Iy;
Ixy=Ix.*Iy;

% Computing the sum of product of derivaties at each pixel
G1=fspecial('gaussian',[3 3],0.5);
Sx2=conv2(Ix2,G1,'same');
Sy2=conv2(Iy2,G1,'same');
Sxy=conv2(Ixy,G1,'same');
m=size(Sx2,1);
n=size(Sx2,2);

% Computing the Harris detector matrix at each pixel 
% Computing the response of the detector at each pixel
for i =1:m
    for j=1:n
        H=[Sx2(i,j) Sxy(i,j); Sxy(i,j) Sy2(i,j)];
        Hd(i,j)=det(H)-k*(trace(H)^2);
    end
end

cornerness=Hd;

% This part does non-maxima suppression

% Do non-maxima suppression
[inds] = find( imregionalmax( cornerness ) );

% Order all local maxima by their cornerness measure
[sort_corn, sort_inds]=sort(cornerness(inds), 'descend');

% Just return them all, sorted order
[i,j]=ind2sub(size(I),inds(sort_inds));
points = [j(:), i(:), sort_corn(:)]; % x, y
