% This program is used to run lucaskanade tracker over a sequential set of
% images.

clc
clear all

load data\carSequence.mat
u=0;
v=0;
rect=[328 213 419 265];
coordinates=zeros(100,4);

for i=1:100
    It=im2double(rgb2gray(sequence(:,:,:,i)));
    It1=im2double(rgb2gray(sequence(:,:,:,i+1)));
    [u,v] = LucasKanade(It,It1,rect)
    rect=[rect(1)+u rect(2)+v rect(3)+u rect(4)+v];
    coordinates(i,:)=rect;
    disp(['Frame ',num2str(i)]);
    Imdisp=im2double(sequence(:,:,:,i));

rect=round(coordinates(i,:))

Imdisp((rect(2)-2):(rect(4)+2),(rect(1)-2):rect(1):(rect(1)+2),2)=1;
Imdisp((rect(2)-2):rect(2):(rect(2)+2),rect(1):rect(3),2)=1;
Imdisp((rect(2)-2):(rect(4)+2),(rect(3)-2):rect(3):(rect(3)+2),2)=1;
Imdisp((rect(4)-2):rect(4):(rect(4)+2),rect(1):rect(3),2)=1;
    imshow(Imdisp);
    drawnow;
    end
