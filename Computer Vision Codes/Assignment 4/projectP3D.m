function P = projectP3D( vertices, K, R, t)
       intrinsics
       
       % Computing the homography matrix
       H=K*[R t];
       
       % Creating a 4x4 homography for projection of 3D points into 2D
       H3D=zeros(4,4);
       H3D(1:2,:)=H(1:2,:);
       H3D(3,:)=[0 0 400 0];
       H3D(4,:)=H(3,:);
       
       % Adding the mean in X and Y axes of vertices of image before
       % projection
       vert=vertices';
       vert(1,:)=vert(1,:)+mu(1);
       vert(2,:)=vert(2,:)+mu(2);
       vert(4,:)=1;
       
       % Projecting the points into 2D and normalising for the last
       % coordinate
       p=H3D*vert;
       for i=1:length(p)
        P(1:3,i)=p(1:3,i)/p(4,i);
       end
end
