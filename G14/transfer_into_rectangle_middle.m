function [ I_new_middle,PW_middle,I1_middle,I2_middle,I3_middle] = transfer_into_rectangle_middle( I,p,H_middle)

    [X,Y] = meshgrid(round(p(3,1)):round(p(4,1)),round(p(3,2)):round(p(1,2)));
    X = X(:);
    Y = Y(:);
    I1 = I(round(p(3,2)):round(p(1,2)),round(p(3,1)):round(p(4,1)),1);
    I1_middle = double(I1(:));
    I2= I(round(p(3,2)):round(p(1,2)),round(p(3,1)):round(p(4,1)),2);
    I2_middle = double(I2(:));
    I3 = I(round(p(3,2)):round(p(1,2)),round(p(3,1)):round(p(4,1)),3);
    I3_middle = double(I3(:));
    p_Ixy_middle = [X';Y'] ;
    p_Ixy_middle(3,:) = 1;
    PW_middle = H_middle*p_Ixy_middle;
    PW_middle(1,:)=PW_middle(1,:)./PW_middle(3,:);
    PW_middle(2,:)=PW_middle(2,:)./PW_middle(3,:);
    PW_middle(3,:)=PW_middle(3,:)./PW_middle(3,:);
    change = abs(min([min(PW_middle(1,:)),min(PW_middle(2,:))]))+1;
    for NUM=1:size(PW_middle,2)
        I_new_middle(round(PW_middle(1,NUM)+change),round(PW_middle(2,NUM)+change),1) = I1_middle(NUM);
        I_new_middle(round(PW_middle(1,NUM)+change),round(PW_middle(2,NUM)+change),2) = I2_middle(NUM);
        I_new_middle(round(PW_middle(1,NUM)+change),round(PW_middle(2,NUM)+change),3) = I3_middle(NUM);
    end
    I_new_middle = uint8(I_new_middle);


end

