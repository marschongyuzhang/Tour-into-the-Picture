function [ I_new_left,PW_left,I1_left,I2_left,I3_left] = transfer_into_rectangle_left( I,p,X,Y,H_left)

    [max_y, max_x, ~] = size(I);
    
    I = double(I);
    
    I_logical_left = -Inf*ones(max_y, max_x);
    for i_x = round(p(11,1)):round(p(3,1))
        y_edge_up = P_inter(p(3,1),p(3,2),p(11,1),p(11,2),'x',i_x);
        if y_edge_up(2) < 1
            y_edge_up(2) = 1;
        end
        y_edge_down = P_inter(p(1,1),p(1,2),p(12,1),p(12,2),'x',i_x);
        if y_edge_down(2) > max_y
            y_edge_down(2) = max_y;
        end
        I_logical_left(round(y_edge_up(2)):round(y_edge_down(2)),i_x)=1;
    end
    I1 = I(:,:,1).*I_logical_left;
    I2 = I(:,:,2).*I_logical_left;
    I3 = I(:,:,3).*I_logical_left;
    I1 = I1(:);
    I2 = I2(:);
    I3 = I3(:);
    I1_left = I1(I1>=0);
    I2_left = I2(I1>=0);
    I3_left = I3(I1>=0);
    p_Ixy_leftx = X(I1>=0);
    p_Ixy_lefty = Y(I1>=0);
    p_I_left = [p_Ixy_leftx';p_Ixy_lefty'];
    p_I_left(3,:)=1;
    PW_left = H_left*p_I_left;
    PW_left(1,:)=round(PW_left(1,:)./PW_left(3,:));
    PW_left(2,:)=round(PW_left(2,:)./PW_left(3,:));
    PW_left(3,:)=round(PW_left(3,:)./PW_left(3,:));
    change = round(abs(min([min(PW_left(1,:)),min(PW_left(2,:))]))+1);
    
    for NUM=1:size(PW_left,2)
        x_d = PW_left(1,NUM)+change;
        y_d = PW_left(2,NUM)+change;
        I_new_left(x_d,y_d,1) = I1_left(NUM);
        I_new_left(x_d,y_d,2) = I2_left(NUM);
        I_new_left(x_d,y_d,3) = I3_left(NUM);
    end
    I_new_left = uint8(I_new_left);


end

