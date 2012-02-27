
im1=imread('taj1.jpg');
im2=imread('taj2.jpg');

if 1
    % Label points the first time...
    [im1_points,im2_points] = ...
        cpselect(im1,im2,'Wait',true);
    
    p1 = im1_points'; % Should be 2xN
    p2 = im2_points';
    
    save taj_points p1 p2;
end

load taj_points;

% Code forth ...
