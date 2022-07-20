function [ I_new_down,PW_down,I1_down,I2_down,I3_down] = transfer_into_rectangle_down(I,p,X,Y,H_down )
      
    [max_y, max_x, ~] = size(I);
    
    I = double(I);

    I_logical_down = -Inf*ones(max_y, max_x);
    for i_y = round(p(1,2)):max_y
        x_edge_left = P_inter(p(1,1),p(1,2),p(5,1),p(5,2),'y',i_y);
        if x_edge_left(1) < 1
            x_edge_left(1) = 1;
        end
        x_edge_right = P_inter(p(2,1),p(2,2),p(6,1),p(6,2),'y',i_y);
        if x_edge_right(1) > max_x
            x_edge_right(1) = max_x;
        end
        I_logical_down(i_y,round(x_edge_left(1)):round(x_edge_right(1)))=1;
    end
    I1 = I(:,:,1).*I_logical_down;
    I2 = I(:,:,2).*I_logical_down;
    I3 = I(:,:,3).*I_logical_down;
    I1 = I1(:);
    I2 = I2(:);
    I3 = I3(:);
    I1_down = I1(I1>=0);
    I2_down = I2(I1>=0);
    I3_down = I3(I1>=0);
    p_Ixy_downx = X(I1>=0);
    p_Ixy_downy = Y(I1>=0);
    p_I_down = [p_Ixy_downx';p_Ixy_downy'];
    p_I_down(3,:)=1;
    PW_down = H_down*p_I_down; %2D to 2D
    PW_down(1,:)=round(PW_down(1,:)./PW_down(3,:));
    PW_down(2,:)=round(PW_down(2,:)./PW_down(3,:));
    PW_down(3,:)=round(PW_down(3,:)./PW_down(3,:));
    change = round(abs(min([min(PW_down(1,:)),min(PW_down(2,:))]))+1);
    
    for NUM=1:size(PW_down,2)
        x_d = PW_down(1,NUM)+change;
        y_d = PW_down(2,NUM)+change;
        I_new_down(x_d,y_d,1) = I1_down(NUM);
        I_new_down(x_d,y_d,2) = I2_down(NUM);
        I_new_down(x_d,y_d,3) = I3_down(NUM);
    end

    I_new_down = uint8(I_new_down);

end

