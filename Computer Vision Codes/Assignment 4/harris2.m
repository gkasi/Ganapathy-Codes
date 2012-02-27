k=0.04;

I=imread('objets\objet1.jpg');
I=double(rgb2gray(I));

G=fspecial('gaussian',[3 3],0.5);
[Gx Gy]=gradient(G);
% imagesc(Gy)
Ix=conv2(Gx,I);
Iy=conv2(Gy,I);

Ix2=Ix.*Ix;
Iy2=Iy.*Iy;
Ixy=Ix.*Iy;

G1=fspecial('gaussian',[3 3],0.5);
Sx2=conv2(G1,Ix2);
Sy2=conv2(G1,Iy2);
Sxy=conv2(G1,Ixy);
m=size(Sx2,1);
n=size(Sx2,2);
for i =1:m
    for j=1:n
        H=[Sx2(i,j) Sxy(i,j); Sxy(i,j) Sy2(i,j)];
        Hd(i,j)=det(H)-k*(trace(H)^2);
    end
end

imagesc(Hd);
hold on 
imshow(I/255)