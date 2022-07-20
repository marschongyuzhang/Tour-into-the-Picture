function [ I_new_8 ] = GUI_Fluchtpunkt_2( I, p, P )

% I = I(1:3:end,1:3:end,:); % Compress the image, or leave it uncompressed if it works
% I = I(1:5:end,1:5:end,:); % Compress the image, or leave it uncompressed if it works

% imshow(I);
% hold on
% while(1)
%     [vx, vy, button] = ginput(4);
%     if (isempty(button))
%         break
%     end

% roi_P = roi_fp2.Position;
    % p1...p12 are pixel points
% p1 = [roi_P(1, 1), roi_P(1, 2)];
% p2 = [roi_P(2, 1), roi_P(2, 2)];
% p3 = [roi_P(4, 1), roi_P(4, 2)];
% p4 = [roi_P(3, 1), roi_P(3, 2)];
% 
% P1 = [roi_P(4, 1), roi_P(1, 2)];
% P2 = [roi_P(3, 1), roi_P(1, 2)];
% P3 = p3;
% P4 = p4;
% 
% hold(app.UIAxes, "on");
% plot([p1(1),p2(1),p4(1),p3(1),p1(1)],[p1(2),p2(2),p4(2),p3(2),p1(2)], 'y','LineWidth',3);
% plot(app.UIAxes, [P1(1),P2(1),P4(1),P3(1),P1(1)], [P1(2),P2(2),P4(2),P3(2),P1(2)], 'Color', [0.9 0.9 0.9], 'LineWidth', 1);
% hold(app.UIAxes, "off");
% hold off;
% end
[max_y, max_x, ~] = size(I);
Vertex_right = [max_x,max_y,1]; % I(end,end,1)
Vertex_left = [1,max_y,1]; %I(1,end,1)

[X,Y] = meshgrid(1:max_x,1:max_y);
X = X(:);
Y = Y(:);
I1 = I(:,:,1);
I1 = I1(:);
I2= I(:,:,2);
I2 = I2(:);
I3 = I(:,:,3);
I3 = I3(:);
p_Ixy = [X';Y'] ;
p_Ixy(3,:) = 1;
% p = [p1;p2;p3;p4]';
% P = [P1;P2;P3;P4]';
H = HMatrix(p,P);
% P_tran = p_Ixy;
P_tran = H*p_Ixy;
PW_I = [I1';I2';I3'];

P_tran(1,:)=round(P_tran(1,:)./P_tran(3,:));
P_tran(2,:)=round(P_tran(2,:)./P_tran(3,:));
P_tran(3,:)=round(P_tran(3,:)./P_tran(3,:));
change_1 = 200;
change_2 = round(abs(min([min(P_tran(2,:))]))+1);
P_tran_show = [P_tran(1,:) + change_1;P_tran(2,:)+change_2];


Vertex_right = H*Vertex_right';
Vertex_left = H*Vertex_left';
Vertex_right(1) = Vertex_right(1)/Vertex_right(3);
Vertex_right(2) = Vertex_right(2)/Vertex_right(3);
Vertex_left(1) = Vertex_left(1)/Vertex_left(3);
Vertex_left(2) = Vertex_left(2)/Vertex_left(3);

I_new=zeros(max(P_tran(2,:)),round(Vertex_right(1)+2*change_1));
for NUM=1:size(P_tran,2)
    x_d = P_tran_show(2,NUM);
    y_d = P_tran_show(1,NUM);
    if y_d>0 && y_d<=Vertex_right(1)+2*change_1+Vertex_left(1)
        I_new(x_d,y_d,1) = PW_I(1,NUM);
        I_new(x_d,y_d,2) = PW_I(2,NUM);
        I_new(x_d,y_d,3) = PW_I(3,NUM);
    end
end
I_new8 = uint8(I_new(300:end,:,:));
% figure
% imshow(I_new8)
% hold on
mask=false(size(I_new8(:,:,1)));
mask(I_new8(:,:,1)==0)=1;
I_new_8 = inpaintCoherent(I_new8, mask);
% figure
% imshow(I_new_8)
end