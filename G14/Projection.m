function x2_cam = Projection( P_1_hom,PW,depth_to_rear,Rotation,Translation )

    R_T=[Rotation,Translation;0 0 0 1];
    pi_0=[1 0 0 0;0 1 0 0;0 0 1 0];
    K=[depth_to_rear 0 0;0 depth_to_rear 0;0 0 1];
    x2_repro=K*pi_0*R_T*P_1_hom;
    remain_x2=find(x2_repro(3,:)>1);
    x2_repro_remain=x2_repro(:,remain_x2);
    PW_remain=PW(:,remain_x2);
    x2_repro_norm=x2_repro_remain./x2_repro_remain(3,:);%nomallize
    x2_cam=round(x2_repro_norm(1:2,:));
    x2_cam(3,:)=1;
    x2_cam(4,:)=PW_remain(4,:); %x2_cam:x y 1 R G B
    x2_cam(5,:)=PW_remain(5,:);
    x2_cam(6,:)=PW_remain(6,:);
    %m=500;  %view size

end

