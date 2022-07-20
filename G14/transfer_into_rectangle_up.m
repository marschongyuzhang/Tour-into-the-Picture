function [ I_new_up,PW_up,I1_up,I2_up,I3_up] = transfer_into_rectangle_up( I,p,X,Y,H_up)

    [max_y, max_x, ~] = size(I);
    
    I = double(I);
    
    I_logical_up = -Inf*ones(max_y, max_x);
    for i_y = round(p(10,2)):round(p(3,2))
        x_edge_left = P_inter(p(3,1),p(3,2),p(10,1),p(10,2),'y',i_y);
        if x_edge_left(1) < 1
            x_edge_left(1) = 1;
        end
        x_edge_right = P_inter(p(4,1),p(4,2),p(9,1),p(9,2),'y',i_y);
        if x_edge_right(1) > max_x
            x_edge_right(1) = max_x;
        end
        I_logical_up(i_y,round(x_edge_left(1)):round(x_edge_right(1)))=1;
    end
    I1 = I(:,:,1).*I_logical_up;
    I2 = I(:,:,2).*I_logical_up;
    I3 = I(:,:,3).*I_logical_up;
    I1 = I1(:);
    I2 = I2(:);
    I3 = I3(:);
    I1_up = I1(I1>=0);
    I2_up = I2(I1>=0);
    I3_up = I3(I1>=0);
    p_Ixy_upx = X(I1>=0);
    p_Ixy_upy = Y(I1>=0);
    p_I_up = [p_Ixy_upx';p_Ixy_upy'];
    p_I_up(3,:)=1;
    PW_up = H_up*p_I_up;
    PW_up(1,:)=round(PW_up(1,:)./PW_up(3,:));
    PW_up(2,:)=round(PW_up(2,:)./PW_up(3,:));
    PW_up(3,:)=round(PW_up(3,:)./PW_up(3,:));
    change = round(abs(min([min(PW_up(1,:)),min(PW_up(2,:))]))+1);
    for NUM=1:size(PW_up,2)
        x_d = PW_up(1,NUM)+change;
        y_d = PW_up(2,NUM)+change;
        I_new_up(x_d,y_d,1) = I1_up(NUM);
        I_new_up(x_d,y_d,2) = I2_up(NUM);
        I_new_up(x_d,y_d,3) = I3_up(NUM);
    end
    I_new_up = uint8(I_new_up);

end

