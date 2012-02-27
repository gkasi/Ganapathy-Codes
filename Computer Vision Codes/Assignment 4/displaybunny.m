figure;
% im_test is the image we want to draw
im_test=im2;
zoff = 900; % Draw image in the far background (so the z-buffer doesn't interfere)
 
hSurf = surface('XData',[1 size(im_test,2); 1 size(im_test,2)],'YData',[1 1; size(im_test,1) size(im_test,1)],...
        'ZData',-(t(3)+zoff)*[1 1; 1 1], ... % Matlab convention has the camera looking down the negative Z axis
    'CData',im_test, 'FaceColor','texturemap','EdgeColor','none', 'FaceLighting', 'none');
hold on;

axis image; axis ij; axis off;% Image axes (y grows down)

load bunny; % Two variables, vertices and faces, to be used with patch

% Project 3Dpoints of the Bunny image into the 2D test image
p = projectP3D( vertices, K, R, t);

% Calling program to draw the image axes overlay and outline
q4_7

% Displaying the projected Bunny in the test image
patch('Vertices',p','Faces',faces,'FaceColor','red','EdgeColor', 'none','FaceLighting', 'phong')
camlight headlight; 
material metal;