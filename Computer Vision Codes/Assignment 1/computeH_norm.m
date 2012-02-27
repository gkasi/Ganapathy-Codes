% This function is used to homography between two set of points after normalization of the points
% p1,p2 - 2xN Matrices with corresponding points
% H - 3x3 Matrix which maps the homography between the set of points from
% p2 to the set of points in p1 after normalization of p1 and p2

%%% Please Also see normmat.m for calculating N (normalisation matrix)

function H=computeH_norm(p1,p2)
  
% N1, N2 are normalization matrices for p1 and p2. N1,N2 = 3x3
% pm1, pm2 are the set of points p1,p2 in a homogenous co-ordinate
% representation. pm1,pm2 = 3xN

[N1, pm1]=normmat(p1); 
[N2, pm2]=normmat(p2);

% Normalizing the points, so that pn1,pn2 are between [-1,1];
pn1=N1*pm1
pn2=N2*pm2

% Compute the Homography matrix for the normalized points
Hn=computeH(pn1,pn2);

% Computing the actual homography matrix from the normalized homography
% matrix
H=(N1\Hn)*N2;

end
