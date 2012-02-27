%% Q2x Normal and Laplacian Blend for Classic Orange and Apple Hybrid
or=double(imread('apple.jpg'));
al=double(imread('orange.jpg'));

mk=al;
col=size(mk,2)/2+1;
mk(:,:,:)=0;
mk(1:end,col:end,:)=255;

% imshow(mk)

or=imresize(or,[size(al,1) size(al,2)]);


%% Normal Blend
mk1=mk/max(max(max(mk)));
normalblend=(1-mk1).*or+mk1.*al;

imshow(normalblend/255);
title('Normal Blend')
%% Laplacian Blend

%% Calculating gaussian pyramid and laplacian pyramid for images upto level 5.
%% Calculating Gaussian Pyramid for oranges,alex and mask
or1=impyramid(or,'reduce');
or2=impyramid(or1,'reduce');
or3=impyramid(or2,'reduce');
or4=impyramid(or3,'reduce');
or5=impyramid(or4,'reduce');

al1=impyramid(al,'reduce');
al2=impyramid(al1,'reduce');
al3=impyramid(al2,'reduce');
al4=impyramid(al3,'reduce');
al5=impyramid(al4,'reduce');

mk1=impyramid(mk,'reduce');
mk2=impyramid(mk1,'reduce');
mk3=impyramid(mk2,'reduce');
mk4=impyramid(mk3,'reduce');
mk5=impyramid(mk4,'reduce');

%% Scaling images for further calculation of laplacian pyramid
ort1=or1;
ort2=imresize(impyramid(or2,'expand'),[size(or1,1) size(or1,2)]);
ort3=imresize(impyramid(or3,'expand'),[size(or2,1) size(or2,2)]);
ort4=imresize(impyramid(or4,'expand'),[size(or3,1) size(or3,2)]);
ort5=imresize(impyramid(or5,'expand'),[size(or4,1) size(or4,2)]);

alt1=al1;
alt2=imresize(impyramid(al2,'expand'),[size(al1,1) size(al1,2)]);
alt3=imresize(impyramid(al3,'expand'),[size(al2,1) size(al2,2)]);
alt4=imresize(impyramid(al4,'expand'),[size(al3,1) size(al3,2)]);
alt5=imresize(impyramid(al5,'expand'),[size(al4,1) size(al4,2)]);



%% Calculating Laplacian pyramid 

orl1=or1-ort2;
orl2=or2-ort3;
orl3=or3-ort4;
orl4=or4-ort5;
orl5=or5;

all1=al1-alt2;
all2=al2-alt3;
all3=al3-alt4;
all4=al4-alt5;
all5=al5;

% Normalising mask
mk1=mk1/max(max(max(mk1)));
mk2=mk2/max(max(max(mk2)));
mk3=mk3/max(max(max(mk3)));
mk4=mk4/max(max(max(mk4)));
mk5=mk5/max(max(max(mk5)));

%% Reconstructing Images

% Level reconstruction
re1=(1-mk1).*orl1+mk1.*all1;
re2=(1-mk2).*orl2+mk2.*all2;
re3=(1-mk3).*orl3+mk3.*all3;
re4=(1-mk4).*orl4+mk4.*all4;
re5=(1-mk5).*orl5+mk5.*all5;

% Final Reconstruction
l4=re4+imresize(impyramid(re5,'expand'),[size(re4,1) size(re4,2)]);
l3=re3+imresize(impyramid(l4,'expand'),[size(re3,1) size(re3,2)]);
l2=re2+imresize(impyramid(l3,'expand'),[size(re2,1) size(re2,2)]);
l1=re1+imresize(impyramid(l2,'expand'),[size(re1,1) size(re1,2)]);
lre=impyramid(l1,'expand');

% re=re1+re2+re3+re4+re5;

figure(2)
imshow(lre/255)
title('Laplacian Blend')
%%

% imwrite(lre,'qx_2_laplacianblend.jpg','jpg');