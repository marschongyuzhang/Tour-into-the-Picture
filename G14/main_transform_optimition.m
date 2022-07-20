clear; clc; close all
%% Load image and enter diagonal coordinates of the inner rectangle
%  I = imread('image/oil-painting.png'); % depth_to_rear=650~700
% I = imread('image/simple-room.png'); % depth_to_rear=1150~1200
I = imread('image/sagrada_familia.png');
% I = imread('metro-station.png');
% I = imread('shopping-mall.png'); %depth_to_rear=1000
% I=zip_pooling(I); % zip the image
imshow(I);
promptMessage = sprintf('Do you want to select a foreground?');
button = questdlg(promptMessage, 'Yes', 'No');
if strcmp(button, 'Yes')
    vorwand = true;
else
    vorwand = false;
end
I = Fluchtpunkt_2(I);  % 2 vanish  point situation
%I=I(400:end,400:end-400,:); 
if vorwand
    [maskRGB, I, pm,rxm, rym, hm, wm] = get_mask(I);
end
% imshow(I);
tic
[max_y, max_x, c] = size(I);
[ p,vx_i,vy_i,h,w ] = get_image_coordinates( I );
%p: pixel coordinates of 12 feature points in the image
%vx_i,vy_i: coordinates of vanish point
%h,w: height and width of middle face (rear wand)

%% Determine the world coordinates P1...P12 and Calculate the corresponding perspective matrix
depth_to_rear = 700;% the definition of a variable for calculating the lenth of each face
[ H_left,H_down,H_up,H_right,H_middle,P ] = get_world_coordinates( p,h,w);

%% 3D Reconstraction and Interpolation
[X,Y] = meshgrid(1:max_x,1:max_y);
X = X(:);  Y = Y(:);

% down
[ I_new_down8,PW_down,I1_down,I2_down,I3_down] = transfer_into_rectangle_down( I,p,X,Y,H_down);
I_new_down8 = interpolation( I_new_down8 );

% up
[ I_new_up8,PW_up,I1_up,I2_up,I3_up] = transfer_into_rectangle_up( I,p,X,Y,H_up);
I_new_up8  = interpolation( I_new_up8 );

% left
[ I_new_left8,PW_left,I1_left,I2_left,I3_left] = transfer_into_rectangle_left( I,p,X,Y,H_left);
I_new_left8 = interpolation( I_new_left8 );

% right
[ I_new_right8,PW_right,I1_right,I2_right,I3_right] = transfer_into_rectangle_right( I,p,X,Y,H_right);
I_new_right8 = interpolation( I_new_right8 );

% middle
[ I_new_middle8,PW_middle,I1_middle,I2_middle,I3_middle] = transfer_into_rectangle_middle( I,p,H_middle);
I_new_middle8 = interpolation( I_new_middle8 );

% middle_mask
if vorwand
    [ I_new_middle8_m,PW_middle_m,I1_middle_m,I2_middle_m,I3_middle_m] = transfer_into_rectangle_middle( maskRGB,pm,H_middle);
    index_m = min(find(I_new_middle8_m(:,1)~=0,1));
    I_new_middle8_m = interpolation( I_new_middle8_m(index_m:end,:,:) );
  % I_new_middle8_m =  I_new_middle8_m(index_m:end,:,:) ;
   ZM=rxm(1)/size(I,1)*abs((P(1,1)-P(5,3)))*0.5-100; % geometrische Beziehung
  % ZM=120;
    PW1 = [PW_down(1,:),PW_up(1,:),zeros(size(PW_left(1,:))),w*ones(size(PW_right(1,:))),PW_middle(1,:),PW_middle_m(1,:)];
    PW2 = [zeros(size(PW_down(1,:))),h*ones(size(PW_up(1,:))),PW_left(1,:),PW_right(1,:),PW_middle(2,:),PW_middle_m(2,:)];
    PW3 = [PW_down(2,:),PW_up(2,:),PW_left(2,:),PW_right(2,:),zeros(size(PW_middle(1,:))),ZM*ones(size(PW_middle_m(1,:)))];
    PW4 = [I1_down',I1_up',I1_left',I1_right',I1_middle',I1_middle_m'];
    PW5 = [I2_down',I2_up',I2_left',I2_right',I2_middle',I2_middle_m'];
    PW6 = [I3_down',I3_up',I3_left',I3_right',I3_middle',I3_middle_m'];
    PW = [PW1;PW2;PW3;PW4;PW5;PW6]; %3D model (the world coordinates based on P1)
    PW_M = [PW_middle_m;ZM*ones(size(PW_middle_m(1,:)))];
else
    PW1 = [PW_down(1,:),PW_up(1,:),zeros(size(PW_left(1,:))),w*ones(size(PW_right(1,:))),PW_middle(1,:)];
    PW2 = [zeros(size(PW_down(1,:))),h*ones(size(PW_up(1,:))),PW_left(1,:),PW_right(1,:),PW_middle(2,:)];
    PW3 = [PW_down(2,:),PW_up(2,:),PW_left(2,:),PW_right(2,:),zeros(size(PW_middle(1,:)))];
    PW4 = [I1_down',I1_up',I1_left',I1_right',I1_middle'];
    PW5 = [I2_down',I2_up',I2_left',I2_right',I2_middle'];
    PW6 = [I3_down',I3_up',I3_left',I3_right',I3_middle'];
    PW = [PW1;PW2;PW3;PW4;PW5;PW6];
end

%% Reset of camera coordinates
PW_cam(1,:) = double(PW(1,:))-abs(vx_i-p(1,1));
PW_cam(2,:) = double(PW(2,:))-abs(vy_i-p(1,2));
PW_cam(3,:) = double(PW(3,:))-depth_to_rear;
if vorwand
PW_M(2,:) = double(PW_middle_m(2,:)+abs(p(2,2)-pm(2,2)));
PW_M_cam(1,:) = double(PW_M(1,:))-abs(vx_i-p(1,1));
PW_M_cam(2,:) = double(PW_M(2,:))-abs(vy_i-p(1,2));
PW_M_cam(3,:) = ZM-depth_to_rear;
end
P(:,1) = P(:,1)-abs(vx_i-p(1,1));
P(:,2) = P(:,2)-abs(vy_i-p(1,2));
P(:,3) = P(:,3)-depth_to_rear;
i_down = size(I1_down,1);

R_const=[0 1 0;1 0 0;0 0 -1];
PW_cam=R_const*PW_cam; %reset the x/y/z-dierection of axis in camera1
P = R_const*P';
if vorwand
PW_M_cam = R_const*PW_M_cam;
end
%% Preprocessing for 'warp'
xmin = P(1,1); ymin = P(2,1); xmax = P(1,3); ymax = P(2,2);
left_z = P(3,12); right_z = P(3,7); down_z = P(3,6); up_z = P(3,9);
zmin = depth_to_rear;
if vorwand
mask_xmin = min(PW_M_cam(1,:));
mask_xmax = max(PW_M_cam(1,:));
mask_ymin = min(PW_M_cam(2,:));
mask_ymax = max(PW_M_cam(2,:));
Z = PW_M_cam(3,1);
end
up_x = [xmax xmax xmax; xmax xmax xmax];
up_y = [ymin ymin ymin; ymax ymax ymax];
up_z = [zmin,(up_z+zmin)/2 up_z;zmin,(up_z+zmin)/2 up_z];
bottom_x = [xmin xmin xmin; xmin xmin xmin];
bottom_y = [ymin ymin ymin; ymax ymax ymax];
bottom_z = [zmin,(down_z+zmin)/2 down_z;zmin,(down_z+zmin)/2 down_z];

if vorwand
    middle_maskx = [mask_xmin (mask_xmax+mask_xmin)/2 mask_xmax; mask_xmin (mask_xmin+mask_xmax)/2 mask_xmax];
    middle_masky = [mask_ymin mask_ymin mask_ymin; mask_ymax mask_ymax mask_ymax];
    ZM2 =depth_to_rear- rxm(1)/size(I,1)*(depth_to_rear-down_z);
    middle_maskz = [ZM2 ZM2 ZM2;ZM2 ZM2 ZM2];
end

middle_x = [xmin (xmax+xmin)/2 xmax; xmin (xmin+xmax)/2 xmax];
middle_y = [ymin ymin ymin; ymax ymax ymax];
middle_z = [zmin zmin zmin; zmin zmin zmin];

left_x = [xmin xmin xmin; xmax xmax xmax];
left_y = [ymin ymin ymin; ymin ymin ymin];
left_z = [zmin (left_z+zmin)/2 left_z; zmin (left_z+zmin)/2 left_z];

right_x = [xmin xmin xmin; xmax xmax xmax];
right_y = [ymax ymax ymax; ymax ymax ymax];
right_z = [zmin (right_z+zmin)/2 right_z; zmin (right_z+zmin)/2 right_z];

%% 3D 'wrap'
figure 
hold on
warp(up_x, up_y, up_z, I_new_up8);
if vorwand
warp(middle_maskx, middle_masky, middle_maskz, I_new_middle8_m);
end
warp(bottom_x, bottom_y, bottom_z, I_new_down8);
warp(right_x, right_y, right_z, I_new_right8);
warp(left_x, left_y, left_z, I_new_left8);
warp(middle_x, middle_y, middle_z, I_new_middle8);

plot([0,0,0],'ro','LineWidth',3); % camera_1 position
text(0,0,0,'   camera_1 & original point')
axis equal; % axis equal;  % make X,Y,Z dimentions be equal % axis vis3d;  % freeze the scale for better rotations % axis off;    % turn off the stupid tick marks
hold off
title('3D Reconstruction - Coordinates of Camera_1');
xlabel('X');
ylabel('Y');
zlabel('Z');
set(gca,'YDir','normal')

%% Projection and Plot
P_1_hom=PW_cam;
P_1_hom(4,:)=1;

alpha=0; %rotation um x   %change here
beta=0; %um y  %change here
theta=-5; %um z   %change here
Rotation  = Rotation_matrix( alpha,beta,theta );
Translation=[0;0;0];  %change here

x2_cam = Projection( P_1_hom,PW,depth_to_rear,Rotation,Translation );
view =  plot_new_image( I,vx_i,vy_i,x2_cam );
%x2_cam: x y 1 R G B
%view: new image view

figure()
imshow(rot90(view,1)) 
view = interpolation( view );
figure()
imshow(rot90(view,1))
toc