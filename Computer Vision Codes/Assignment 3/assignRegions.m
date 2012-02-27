function [I]= assignRegions(vx,vy,C)
N=size(C,1);
m=size(vx,1);
n=size(vx,2);
% vectorizing the velocities
vx1=vx(:);
vy1=vy(:);
I=zeros(size(vx1,1),1);
% v=[vx1 vy1];
X=1:size(vx,2);
Y=1:size(vy,1);
[X1,Y1]=meshgrid(X,Y);
%Normalising the coordinates
X=X1(:)/max(max(X1));
Y=Y1(:)/max(max(Y1));
sub=zeros(N,1);
Cx=C(:,1:3)';
Cy=C(:,4:6)';

% Calculating the Si matrix which is [x y 1]
si=[X Y ones(size(vx1,1),1)];
% Calculating new velocity from affine components
        vxa=si*Cx;
        vya=si*Cy;
%         va=[vxa vya];

for i=1:N
    % Finding the best cluster centers for each pixel
        normx(:,i)=(vxa(:,i)-vx1).^2;
        normy(:,i)=(vya(:,i)-vy1).^2;
end

clear vxa vya Cx Cy si
sub=(normx+normy)';

% Assigning the pixel values to the Image mask I
    [~,I]=min(sub);

save sub.mat sub I
I=reshape(I,m,n);
end
