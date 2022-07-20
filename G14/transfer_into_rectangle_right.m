function [ I_new_right,PW_right,I1_right,I2_right,I3_right] = transfer_into_rectangle_right( I,p,X,Y,H_right)

    [max_y, max_x, ~] = size(I);
    I = double(I);
    
    I_logical_right = -Inf*ones(max_y, max_x);
    for i_x = round(p(4,1)):round(p(8,1))
         y_edge_up = P_inter(p(4,1),p(4,2),p(8,1),p(8,2),'x',i_x);
        if y_edge_up(2) < 1
            y_edge_up(2) = 1;
        end
        y_edge_down = P_inter(p(2,1),p(2,2),p(7,1),p(7,2),'x',i_x);
        if y_edge_down(2) > max_y
            y_edge_down(2) = max_y;
        end
        I_logical_right(round(y_edge_up(2)):round(y_edge_down(2)),i_x)=1;
    end
    I1 = I(:,:,1).*I_logical_right;
    I2 = I(:,:,2).*I_logical_right;
    I3 = I(:,:,3).*I_logical_right;
    I1 = I1(:);
    I2 = I2(:);
    I3 = I3(:);
    I1_right = I1(I1>=0);
    I2_right = I2(I1>=0);
    I3_right = I3(I1>=0);
    p_Ixy_rightx = X(I1>=0);
    p_Ixy_righty = Y(I1>=0);
    p_I_right = [p_Ixy_rightx';p_Ixy_righty'];
    p_I_right(3,:)=1;
    PW_right = H_right*p_I_right;
    PW_right(1,:)=round(PW_right(1,:)./PW_right(3,:));
    PW_right(2,:)=round(PW_right(2,:)./PW_right(3,:));
    PW_right(3,:)=round(PW_right(3,:)./PW_right(3,:));
    change = round(abs(min([min(PW_right(1,:)),min(PW_right(2,:))]))+1);
    
    for NUM=1:size(PW_right,2)
        x_d = PW_right(1,NUM)+change;
        y_d = PW_right(2,NUM)+change;
        I_new_right(x_d,y_d,1) = I1_right(NUM);
        I_new_right(x_d,y_d,2) = I2_right(NUM);
        I_new_right(x_d,y_d,3) = I3_right(NUM);
    end
    I_new_right = uint8(I_new_right);

end

